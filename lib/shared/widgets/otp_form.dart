import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../palette.dart';
import '../utils/validator.dart';

class OTPForm extends StatefulWidget {
  final String phone;
  final bool loading;
  final bool isOtp;
  final bool isSendImage;
  final Widget image;
  final String buttonText;
  final void Function()? onResend;
  final Future<String?> Function(String otp)? onActivate;

  const OTPForm(
      {super.key,
      required this.phone,
      required this.isSendImage,
      this.loading = false,
      this.isOtp = true,
      this.image = const SizedBox(),
      this.onResend,
      this.onActivate,
      required this.buttonText});

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  String otp = '';
  int _resendTime = 120; // in seconds
  Timer? _timer;
  bool? isFinished=false;
  String? error;

  void _resend() {
    _resetTimer();

    if (widget.onResend != null) widget.onResend!();
  }

  void _resetTimer() {
    setState(() {
      _resendTime = 120; // in seconds
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resendTime -= 1;
      });

      if (_resendTime == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _resetTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    const padding = 24.0;
    final size = MediaQuery.of(context).size;
    final contentWidth = size.width - 2 * padding;
    const digits = 4;
    const spaceBetweenOtpFields = 5;
    final otpFieldWidth =
        contentWidth / digits - (digits - 1) * spaceBetweenOtpFields / 0.75;
    final resendMinutes = (_resendTime ~/ 60).toString().padLeft(2, '0');
    final resendSeconds = (_resendTime % 60).toString().padLeft(2, '0');
    final formattedResendTime = '$resendMinutes:$resendSeconds';
    final canResend = _resendTime == 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.isOtp
            ? Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/otp.svg',
                    height: 200.h,
                  ),
                  const Text('كود التحقق',
                      style: TextStyle(
                          color: Palette.primaryColor,
                          fontWeight: FontWeight.bold)),
                  Text('الرجاء كتابة كود التحقق المرسل على جوال العميل',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Palette.greyColor.shade600,
                        height: 1.75,
                      )),
                  Text(
                    'حتى تستطيع تسليم الطلب',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.greyColor.shade600,
                      height: 1.75,
                    ),
                  ),
                  widget.isOtp
                      ? Text(
                          formattedResendTime,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Palette.greyColor.shade600,
                            height: 1.75,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 24.0),
                  widget.isOtp
                      ? Localizations.override(
                          context: context,
                          locale: const Locale('en'),
                          child: OTPTextField(
                            onChanged: (value) {
                              setState(() {
                                otp = value;
                              });
                            },
                            width: contentWidth,
                            length: digits,
                            fieldWidth: otpFieldWidth,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 15,
                            style: const TextStyle(fontSize: 40.0),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            isDense: true,
                            otpFieldStyle: OtpFieldStyle(
                              backgroundColor: Palette.whiteColor,
                              enabledBorderColor: Palette.greyColor,
                              focusBorderColor: Palette.primaryColor,
                              errorBorderColor: Palette.dangerColor,
                              borderColor: Palette.greyColor,
                              disabledBorderColor: Palette.greyColor,
                            ),
                            hasError: error != null,
                          ),
                        )
                      : const SizedBox(),
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        error!,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: Palette.dangerColor),
                      ),
                    ),
                  const SizedBox(height: 24.0),
                  ExpressButton(
                    loading: widget.loading,
                    onPressed: () async {
                      if (widget.isOtp) {
                        final message = Validator(otp)
                            .digits('t.otp_must_contain_only_digits')
                            .length(digits, 't.otp_must_be_of_length(digits)')
                            .error;

                        setState(() {
                          error = message;
                        });
                        if (widget.onActivate != null && error == null) {
                          final message = await widget.onActivate!(otp);
                            error = message;
                        }
                      }

                    },
                    child: Text(widget.buttonText),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لم تتلق الرسائل القصيرة؟',
                        style: TextStyle(
                          color: Palette.greyColor.shade600,
                          height: 1.75,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      GestureDetector(
                        onTap: _resend,
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 3,
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: canResend
                                ? Palette.blackColor
                                : Palette.greyColor.shade600,
                            width: 1.5,
                          ))),
                          child: Text(
                            'أرسل رمز التحقق مرة أخرى',
                            style: TextStyle(
                              color: canResend
                                  ? Palette.blackColor
                                  : Palette.greyColor.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
        widget.isSendImage
            ? Column(
                children: [
                  const SizedBox(height: 15,),
                  widget.image,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ExpressButton(
                        loading: widget.loading,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text(context.tr.send),
                      ),
                      SizedBox(
                        width: 0.4.sw,
                      ),
                      ExpressButton(
                        loading: widget.loading,
                        style: ExpressButtonStyle.secondary,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text(context.tr.cancel),
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }
}
