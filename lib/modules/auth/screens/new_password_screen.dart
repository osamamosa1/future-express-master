import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/modules/auth/cubit/auth_cubit.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';

import '../../../shared/components/components.dart';
import '../../../shared/palette.dart';
import '../../../shared/widgets/header_text.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    GlobalKey formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor.withAlpha(0),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Palette.greyColor,
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/new_password.png',
                    fit: BoxFit.cover,
                    height: 80,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                HeaderText(text: context.tr.create_new_password),
                const SizedBox(
                  height: 40,
                ),
                defaultFormField(
                  controller: passwordController,
                  lines: 1,
                  isPassword: AuthCubit.get(context).isPasswordShowen,
                  type: TextInputType.visiblePassword,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password_is_Too_Short';
                    }
                    if (value != passwordController.text) {
                      return 'the password is currint';
                    }
                    return null;
                  },
                  suffix: AuthCubit.get(context).sufix,
                  suffixPressed: () {
                    AuthCubit.get(context).changePasswordVisibility();
                  },
                  label: 'Password',
                  prefix: const Icon(Icons.lock_outline),
                ),
                defaultFormField(
                  controller: confirmPassword,
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
                  label: 'Password',
                  prefix: const Icon(Icons.lock_outline),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  return ExpressButton(
                    loading: state is ResetPasswordLoadFailed == true,
                    child: Text(context.tr.send),
                    onPressed: () {
                      if (passwordController.text != confirmPassword.text) {
                        // you can add your statements here
                        showToast(
                          message:
                              'Password does not match. Please re-type again.',
                          toastStates: ToastStates.EROOR,
                        );
                      } else {
                        AuthCubit.get(context).resetPassword(
                            password: passwordController.text,
                            context: context);
                      }
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
