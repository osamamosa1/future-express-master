import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/drob_model.dart';
import 'package:future_express/shared/components/components.dart';
import 'package:future_express/shared/network/remote/dio_helper.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/app_url.dart';

part 'join_service_provider_state.dart';

class JoinServiceProviderCubit extends Cubit<JoinServiceProviderState> {
  JoinServiceProviderCubit() : super(JoinServiceProviderInitial());

  static JoinServiceProviderCubit get(context) => BlocProvider.of(context);

  //controllers
  final TextEditingController _nameController = TextEditingController();

  TextEditingController? get nameController => _nameController;

  final TextEditingController _mangerPhoneController = TextEditingController();

  TextEditingController? get mangerPhoneController => _mangerPhoneController;

  final TextEditingController _emailController = TextEditingController();

  TextEditingController? get emailController => _emailController;

  final TextEditingController _numEmployeesController = TextEditingController();

  TextEditingController? get numEmployeesController => _numEmployeesController;

  final TextEditingController _numCarsController = TextEditingController();

  TextEditingController? get numCarsController => _numCarsController;

// TODO : This section is related to the registration API.

  Future<void> request_join() async {
    FormData data = FormData.fromMap({
      'name': _nameController.text,
      'email': _emailController.text,
      'manger_phone': _mangerPhoneController.text,
      'city_id': city,
      'num_employees': _numEmployeesController.text,
      'num_cars': _numCarsController.text,
      'is_transport': IsTransport,
    });

    emit(LodingRequestJoin());
    var response = await DioHelper.postData(
      Url: AppUrl.requestJoinServiceProvider,
      data: data,
    );

    if (response.statusCode == 200) {
      // فى حالة ان لو فيه مشكلة فى الداتا اللى مبعوته
      if (response.data['success'] != 1) {
        // الاستجابة من الAPI
        String apiResponse = response.toString();

// تحويل النص إلى Map
        Map<String, dynamic> responseData = json.decode(apiResponse);

// الحصول على الرسائل من الخريطة
        Map<String, dynamic> messages = responseData['message'];

// إعداد رسالة الخطأ
        String errorMessage = '';
        messages.forEach((key, value) {
          errorMessage += ' ${value[0]}\n'; // اختر أول قيمة في قائمة الرسائل
        });

// قم بعرض رسالة الخطأ (يمكنك استخدام SnackBar أو AlertDialog أو أي وسيلة أخرى)
        log(errorMessage);
        showToast(
          message: errorMessage.toString(),
          toastStates: ToastStates.WARNING,
        );
        emit(SuccessRequestJoin());

        print(json.encode(response.data));
      } //صح فى حالة ان لو الداتا اللى مبعوته

      if (response.data['success'] == 1) {
        showToast(
          message: json.encode(response.data['messages']),
          toastStates: ToastStates.WARNING,
        );
        router.pop();

        emit(SuccessRequestJoin());
      }
    } else {
      print(response.statusMessage);
    }
  }

  // get the cityItems

  List<DropItems>? IsTransportItems = [
    DropItems(id: 1, title: 'نعم'),
    DropItems(id: 0, title: 'لا'),
  ];
  List<DropItems>? cityItems = [];
  String? IsTransport;
  String? city;

  Future<void> getCity() async {
    cityItems = [];
    emit(LoadingCiteState());
    var response = await DioHelper.getData(
      Url: AppUrl.cities,
    );

    if (response.statusCode == 200) {
      (response.data['message']).forEach((value) {
        // log(value['id'].toString());
        cityItems!.add(
            DropItems(id: value['id'], isOtp: 0, title: value['title_ar']));
        emit(GetCiteItemsState());
      });
    } else {
      print(response.statusMessage);
    }
  }
}
