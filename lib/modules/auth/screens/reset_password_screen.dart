import 'dart:async';

import 'package:flutter/material.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/body_text1.dart';
import 'package:future_express/shared/widgets/header_text.dart';
import 'package:future_express/shared/widgets/otp_form.dart';

import '../cubit/auth_cubit.dart';
import 'new_password_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Image.asset(
                'assets/images/receive_sms.png',
                fit: BoxFit.cover,
                height: 80,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            HeaderText(text: context.tr.enter_code_sent_to_you),
            const SizedBox(
              height: 5,
            ),
            BodyText1(text: context.tr.entery_code_msg),
            const SizedBox(
              height: 5,
            ),
            Text(
              '(${AuthCubit.get(context).mobilea})',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            OTPForm(
              isSendImage: false,
                isOtp: true,
                buttonText: context.tr.verify,
                phone: AuthCubit.get(context).mobilea.toString(),
                onResend: () async => AuthCubit.get(context).forgetPassword(
                    mobile: AuthCubit.get(context).mobilea.toString()),
                onActivate: (otp) async {
                  unawaited(Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const NewPasswordScreen())));
                  return null;
                }),
          ],
        ),
      ),
    );
  }
}
