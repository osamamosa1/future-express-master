import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:future_express/model/user.dart';
import 'package:future_express/shared/utils/app_url.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/drob_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/router.dart';
import '../../notification/cubit/notification_cubit.dart';
import '../screens/reset_password_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoading());

  User? LoginModel;

  // this sectain to get image

  XFile? avatar;

  String? city;

  // get the cityItems

  List<DropItems>? cityItems = [];

  int? code = 0;
  XFile? formImage;
  XFile? frontPhoto;
  bool isPasswordShowen = true;
  String? mobilea;
  String? regions;

  // get the regions

  List<DropItems>? regionsItems = [];

  ImageSource? source;
  IconData sufix = Icons.visibility_outlined;

  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  //controllers
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _plateNumController = TextEditingController();
  final TextEditingController _statusCardNumberController =
      TextEditingController();

  final TextEditingController _vehicleDetailsController =
      TextEditingController();

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> init() async {
    router.go('/myLoadingPage');

    var dio = Dio();

// if token is expier when app log out
    final token = await CacheHelper.getToken();
    var check = await dio.request(
      '${basesUrl}check_token',
      options: Options(
        method: 'POST',
      ),
      data: FormData.fromMap({
        'token': token,
      }),
    );
    try {
      if (token == null || check.data['token'] == false) {
        router.go('/');
        signOut();
        emit(AuthSignedOut());
      } else {
        router.go('/homeLayOut');
      }
    } catch (error) {
      signOut();
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlutterNativeSplash.remove();
      });
    }
  }

  Future<void> login({
    required String mobile,
    required String password,
    required BuildContext? context,
  }) async {
    FormData data = FormData.fromMap({
      'phone': mobile,
      'password': password,
    });
    emit(AuthLoading());
    try {
      final response = await DioHelper.postData(Url: AppUrl.login, data: data);
      final userV2 = LoginModelV2.fromJson(response.data);

      String responseBody = response.toString();
      Map<String, dynamic> json = jsonDecode(responseBody);
      if (json['success'] == 1) {
        await CacheHelper.saveData(
            key: MyCacheKey.token.name, value: userV2.user?.apiToken);
          print(json.toString());
        LoginModel = User.fromJson(json);

        if (LoginModel?.work.length == 1) {
          if (LoginModel?.work.first == 1 || LoginModel?.work.first == 4) {
            await CacheHelper.saveData(
                key: 'user', value: LoginModel!.work.first);
            router.go('/homeLayOut');
            await saveData(context);
          } else if (LoginModel?.work.first == 2) {
            await CacheHelper.saveData(
                key: 'user', value: LoginModel!.work.first);
            router.go('/homeLayOut');
            await saveData(context);
          }
        } else {
          await saveData(context);
          router.go('/loginTypeScreen', extra: userV2.user?.work ?? []);
        }

        // if (LoginModel!.work.contains(3)) {
        //   router.go('/typeScreen');
        //   await saveData(context);

        // } else if (LoginModel!.work.contains(2)  || LoginModel!.work.contains(1)) {
        //   await CacheHelper.saveData(key: 'user', value: LoginModel!.work);
        //
        //   router.go('/homeLayOut');
        //   await saveData(context);
        // }
        // if (userV2.user?.work?.contains(3) ?? false) {
        //   router.go('/typeScreen');
        //   await saveData(context);
        // } else if ((userV2.user?.work?.contains(2) ?? false) ||
        //     (userV2.user?.work?.contains(1) ?? false)) {
        //   await CacheHelper.saveData(
        //       key: 'user', value: LoginModel!.work.first);
        //   router.go('/homeLayOut');
        //   await saveData(context);
        // }
        emit(AuthSuccess(user: LoginModel));

        // end success state
      } else if (json['success'] == 0) {
        showToast(
          message: json['message'].toString(),
          toastStates: ToastStates.WARNING,
        );
        emit(AuthLoadFailed());
      } else {
        if (json['message']['phone'][0] != null) {
          showToast(
            message: " ${json['message']['phone'][0].toString()}",
            toastStates: ToastStates.EROOR,
          );
        }
        if (json['message']['password'] != null) {
          showToast(
            message: " ${json['message']['password'][0].toString()}",
            toastStates: ToastStates.EROOR,
          );
        }
        emit(AuthLoadFailed());
      }
    } catch (error) {
      log(error.toString());
      showToast(
        message: error.toString(),
        toastStates: ToastStates.EROOR,
      );
      emit(AuthLoadFailed());
    }
  }

  Future<void> saveData(context) async {
    await CacheHelper.setToken(LoginModel!.apiToken);
    await CacheHelper.saveData(
        key: 'userReport', value: LoginModel!.work.first);
    await NotificationCubit.get(context).sendToken();
  }

  Future<void> forgetPassword({required String mobile, context}) async {
    FormData data = FormData.fromMap({
      'phone': mobile,
    });
    emit(ForgetPasswordLoadFailed());
    await DioHelper.postData(
      Url: AppUrl.forgetPassword,
      data: data,
    ).then((value) {
      log(value.toString());
      if (value.data['success'] == 0) {
        showToast(
          message: value.data['message']['phone'][0].toString(),
          toastStates: ToastStates.WARNING,
        );
      }
      if (value.data['success'] == 1) {
        mobilea = mobile;

        showToast(
          message: value.data['message'].toString(),
          toastStates: ToastStates.SUCCESS,
        );
        unawaited(Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const ResetPasswordScreen())));
      } else {
        showToast(
          message: value.data['message'].toString(),
          toastStates: ToastStates.WARNING,
        );
      }
    }).catchError((error) {
      log(error);

      showToast(
          message: "error['message'].toString()",
          toastStates: ToastStates.EROOR);
      emit(AuthLoadFailed());
    });
  }

  void resetPassword(
      {required String password, required BuildContext? context}) async {
    FormData data = FormData.fromMap({
      'code': code,
      'password': password,
    });
    emit(ForgetPasswordLoadFailed());
    await DioHelper.postData(
      Url: AppUrl.resetPassword,
      data: data,
    ).then((value) {
      emit(SuccessResetPasswordState());
      login(mobile: mobilea!, password: password, context: context);
    }).catchError((error) {
      log(error);
      showToast(
          message: "error['message'].toString()",
          toastStates: ToastStates.EROOR);
      emit(AuthLoadFailed());
    });
  }

  void signOut() async {
    router.go('/');

    unawaited(CacheHelper.setToken(null));
    emit(AuthSignedOut());
  }

  void changePasswordVisibility() {
    if (isPasswordShowen == false) {
      isPasswordShowen = true;
    } else {
      isPasswordShowen = false;
    }
    sufix = isPasswordShowen
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityStates());
  }

  TextEditingController? get nameController => _nameController;

  TextEditingController? get nationalityController => _nationalityController;

  TextEditingController? get statusCardNumberController =>
      _statusCardNumberController;

  TextEditingController? get cityController => _cityController;

  TextEditingController? get neighborhoodController => _neighborhoodController;

  TextEditingController? get phoneController => _phoneController;

  TextEditingController? get emailController => _emailController;

  TextEditingController? get vehicleDetailsController =>
      _vehicleDetailsController;

  TextEditingController? get plateNumController => _plateNumController;

  TextEditingController? get expiryDateController => _expiryDateController;

// TODO : This section is related to the registration API.

  Future<void> request_join() async {
    FormData data = FormData.fromMap({
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'city_id': city,
      'region_id': regions,
      'work_type': '1',
      'Residency_number': _statusCardNumberController.text,
      'type_vehicle': _vehicleDetailsController.text,
      'Num_vehicle': _plateNumController.text,
      'avatar':
          await MultipartFile.fromFile(avatar!.path, filename: avatar!.name),
      'vehicle_photo': await MultipartFile.fromFile(formImage!.path,
          filename: frontPhoto!.name),
      'residence_photo': await MultipartFile.fromFile(formImage!.path,
          filename: formImage!.name),
      'license_photo': await MultipartFile.fromFile(formImage!.path,
          filename: formImage!.name),
    });

    emit(LodingRequestJoin());
    var response = await DioHelper.postData(
      Url: AppUrl.requestJoin,
      data: data,
    );

    if (response.statusCode == 200) {
      router.go('/');
      emit(SuccessRequestJoin());

      print(json.encode(response.data));
    } else {
      emit(RequestJoinFailed());
      print(response.statusMessage);
    }
  }

  Future<void> getAvatar() async {
    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImages = await imagePicker.pickImage(source: source!);
    if (selectedImages != null) {
      avatar = selectedImages;
      emit(SetAvatarImageState());
    }
    emit(SetImageState());
  }

  Future<void> getFrontPhoto() async {
    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImages = await imagePicker.pickImage(source: source!);
    if (selectedImages != null) {
      frontPhoto = selectedImages;
      emit(SetFrontPhotoImageState());
    }
    emit(SetImageState());
  }

  Future<void> getFormImage() async {
    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImages = await imagePicker.pickImage(source: source!);
    if (selectedImages != null) {
      formImage = selectedImages;
      emit(SetFormImageImageState());
    }
    emit(SetImageState());
  }

  Future<void> getCity() async {
    cityItems = [];
    emit(LoadingCiteState());
    var response = await DioHelper.getData(
      Url: AppUrl.cities,
    );
    log(response.data['success'].toString());

    if (response.statusCode == 200) {
      (response.data['message']).forEach((value) {
        // log(value['id'].toString());
        cityItems!.add(
            DropItems(id: value['id'], isOtp: 0, title: value['title_ar']));
        emit(GetCiteItemsState());
      });
    } else {}

    {
      emit(GetCiteItemsState());
    }
  }

  Future<void> getregions(String newValue) async {
    regionsItems = [];
    emit(LoadingCiteState());
    var response = await DioHelper.getData(
      Url: AppUrl.regions + newValue,
    );

    if (response.statusCode == 200) {
      (response.data).forEach((value) {
        regionsItems!
            .add(DropItems(id: value['id'], isOtp: 0, title: value['title']));
        emit(GetCiteItemsState());
      });
    } else {}

    {
      emit(GetCiteItemsState());
    }
  }
}
