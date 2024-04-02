import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/modules/auth/cubit/auth_cubit.dart';
import 'package:future_express/modules/auth/widgets/hesder_login_screen.dart';
import 'package:future_express/modules/auth/widgets/selcted_acc.dart';

import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/utils/my_utils.dart';
import 'package:future_express/shared/widgets/express_button.dart';

import '../../../shared/components/components.dart';
import '../widgets/footer_login_screen.dart';
import '../widgets/reset_password_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> _logIn(BuildContext context) async {
    await AuthCubit.get(context).login(
        mobile: phoneController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderLoginScreen(),
                body_login_screen(context, state),
                const Spacer(),
                const FooterLoginScreen()
              ],
            ),
          ),
        ),
      );
    });
  }

  Padding body_login_screen(BuildContext context, AuthState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 25.h,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: Center(
                        child: Image.asset(
                          'assets/images/log_bg.png',
                          height: 60,
                          width: 110,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 13,
                      child: Text(
                        context.tr.sign_in,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: .85.sw,
                  child: defaultFormField(
                    controller: phoneController,
                    lines: 1,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'numper_is_Too_Short';
                      }
                      return null;
                    },
                    label: context.tr.the_number_starts_with_05,
                    prefix: const Icon(Icons.person_3_rounded),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: .85.sw,
                  child: defaultFormField(
                    controller: passwordController,
                    lines: 1,
                    isPassword: AuthCubit.get(context).isPasswordShowen,
                    type: TextInputType.visiblePassword,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Password_is_Too_Short';
                      }
                      return null;
                    },
                    suffix: AuthCubit.get(context).sufix,
                    suffixPressed: () {
                      AuthCubit.get(context).changePasswordVisibility();
                    },
                    label: context.tr.password,
                    prefix: const Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1.sw,
                  height: 100.h,
                  child: ExpressButton(
                    loading: state is AuthLoading == true,
                    onPressed: () {
                      print("object");
                      // router.go('/loginTypeScreen');

                      unawaited(_logIn(context));

                    },
                    child: Text(
                      context.tr.sign_in,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr.forget_password,
                      style: const TextStyle(
                        color: Palette.greyColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: _resetPassword,
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 3,
                        ),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Palette.primaryColor,
                          width: 1.5,
                        ))),
                        child: Text(
                          context.tr.reset_password,
                          style: const TextStyle(
                            color: Palette.primaryColor,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () => showMyBottomSheet(
                      context, const SelctedAccuontBottomShet()),
                  child: const Text(
                    'سجل كمندوب او مزود خدمة',
                    style: TextStyle(
                      color: Palette.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _resetPassword() {
    showMyBottomSheet(context, const ResetPaswwordBottomShet());
  }
}
