import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/modules/auth/cubit/auth_cubit.dart';
import 'package:future_express/modules/auth/widgets/sar_flag_widget.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/body_text1.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/express_text_field.dart';
import 'package:future_express/shared/widgets/header_text.dart';

class ResetPaswwordBottomShet extends StatelessWidget {
  const ResetPaswwordBottomShet({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 650.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                'assets/images/send_sms.png',
                fit: BoxFit.cover,
                height: 80,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            HeaderText(text: context.tr.forget_password),
            const SizedBox(
              height: 15,
            ),
            BodyText1(text: context.tr.verification_code_msg),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 0.6.sw,
                  child: ExpressTextField(
                    controller: phoneController,
                    hint: 'يبدأ ب 05',
                  ),
                ),
                SarFlagWidget(
                  size: 0.3.sw,
                  outline: true,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ExpressButton(
              child: Text(context.tr.restore),
              onPressed: () {
                unawaited(AuthCubit.get(context).forgetPassword(
                    mobile: phoneController.text, context: context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
