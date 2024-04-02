import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/user.dart';
import 'package:future_express/shared/components/components.dart';
import 'package:future_express/shared/network/remote/dio_helper.dart';
import 'package:future_express/shared/utils/app_url.dart';
import 'package:image_picker/image_picker.dart';

part 'profie_state.dart';

class ProfieCubit extends Cubit<ProfieState> {
  ImageSource? source;

  ProfieCubit() : super(ProfieInitial());

  static ProfieCubit get(context) => BlocProvider.of(context);

  TextEditingController? get nameController => _nameController;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  TextEditingController? get emailController => _emailController;

  final TextEditingController _phoneController = TextEditingController();

  TextEditingController? get phoneController => _phoneController;
  String? image = '';
  Future<void> getProfileData() async {
    emit(StateGetProfileLoded());
    try {
      await DioHelper.getData(
        Url: AppUrl.profile,
      ).then((value) {
        nameController!.text = value.data['user']['name'];
        emailController!.text = value.data['user']['email'];
        phoneController!.text = value.data['user']['phone'];

        image = value.data['user']['avatar'];

        log(value.data.toString());
        emit(StateGetProfileSuccess(profileModel: User.fromJson(value.data)));
      });
    } catch (error) {
      emit(StateGetProfileError());
    }
  }

  XFile? avatar;
  Future<void> getAvatar() async {
    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImages =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImages != null) {
      avatar = selectedImages;
      emit(SetAvatarImageState());
    }
    emit(SetImageState());
  }

  void updateProfile() async {
    emit(ProfileUpdateLodingState());
    try {
      FormData data = FormData.fromMap({
        'name': nameController!.text,
        'email': emailController!.text,
        'phone': phoneController!.text,
        if (avatar != null)
          'avatar': await MultipartFile.fromFile(avatar!.path,
              filename: avatar!.name),
      });

      await DioHelper.postData(Url: AppUrl.profileUpdate, data: data)
          .then((value) {
        log(value.data.toString());
        showToast(
          message: value.data['message'],
          toastStates: ToastStates.SUCCESS,
        );
        emit(ProfileUpdateSuccessState());
        getProfileData();
      });
    } catch (error) {
      
      emit(ProfileUpdateErrorState());
    }
  }
}
