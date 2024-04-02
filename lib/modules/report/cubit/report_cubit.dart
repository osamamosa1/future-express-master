import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/report_model.dart';
import 'package:future_express/shared/utils/app_url.dart';

import '../../../model/drob_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/router.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());
  static ReportCubit get(context) => BlocProvider.of(context);

  List<DropItems>? ClientItems = [];
  String? Client;

  void getClient() async {
    try {
      emit(ClientLoad());
      var response = await DioHelper.getData(
        Url: AppUrl.clientDelegate,
      );
      if (response.statusCode == 200) {
        (response.data['clients']).forEach((value) {
          print(response.data['clients']);
          ClientItems!
              .add(DropItems(id: value['id'], title: value['store_name']));
        });
        log(ClientItems!.length.toString());

        emit(ClientSuccess());
      } else {}

      {
        emit(ClientLoadFailed());
      }
    } catch (_) {
      print(Client);
    }
  }

  List<ReportEntry>? reportModel = [];

  void getReport() async {

    try {
      emit(ReportLoading());
      var response = await DioHelper.getData(
        Url: AppUrl.reports,
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        ReportResponse reportResponse = ReportResponse.fromJson(data);
        reportModel = reportResponse.data;
        log(reportModel!.length.toString());

        emit(ReportLoadSuccess());
      } else {
        print(response.statusMessage);
      }

      {
        emit(ReportLoadFailed());
      }
    } catch (_) {
      print(Client);
    }
  }

  TextEditingController? get RecipientController => _RecipientController;

  final TextEditingController _RecipientController = TextEditingController();
  TextEditingController? get ReceivedController => _ReceivedController;

  final TextEditingController _ReceivedController = TextEditingController();
  TextEditingController? get ReturnedController => _ReturnedController;

  final TextEditingController _ReturnedController = TextEditingController();
  TextEditingController? get totalController => _totalController;

  final TextEditingController _totalController = TextEditingController();

  void SendReport() async {
    var data = FormData.fromMap({
      'client_id': Client,
      'Recipient': _RecipientController,
      'Received': _ReceivedController,
      'Returned': _ReturnedController,
      'total': _totalController
    });
    try {
      emit(SendReportLoading());
      var response =
          await DioHelper.postData(Url: AppUrl.sendReport, data: data);
      log(response.data.toString());
      if (response.statusCode == 200) {
        showToast(
            message: response.data['message'].toString(),
            toastStates: ToastStates.SUCCESS);
        router.pop();
        log(reportModel!.length.toString());

        emit(SendReportLoadSuccess());
      } else {
        print(response.statusMessage);
      }

      {
        emit(SendReportLoadFailed());
      }
    } catch (_) {
      showToast(
          message: 'تم ارسال التقرير من قبل ',
          toastStates: ToastStates.SUCCESS);
      print(Client);
    }
  }
}
