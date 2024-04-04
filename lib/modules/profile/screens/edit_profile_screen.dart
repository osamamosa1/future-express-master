import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/modules/auth/widgets/sar_flag_widget.dart';
import 'package:future_express/modules/profile/cubit/profie_cubit.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/express_text_field.dart';
import 'package:future_express/shared/widgets/text_field_header.dart';

import '../../../shared/palette.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    unawaited(ProfieCubit.get(context).getProfileData());
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool personal = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return formOne(context, size);
  }

  Widget formOne(BuildContext context, Size size) {
    ProfieCubit auth = ProfieCubit.get(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: .60.sh,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            TextFieldHeader(text: context.tr.personal_info),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                log('message');
                                await auth.getAvatar();
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Palette.greyColor.shade200,
                                        borderRadius: BorderRadius.circular(90),
                                        border: Border.all(
                                          color: Palette.greyColor.shade500,
                                        )),
                                    child: auth.avatar == null
                                        ? Center(
                                            child: Image.network(
                                                auth.image ?? ''),
                                          )
                                        : Image.file(File(auth.avatar!.path)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            ExpressTextField(
                                hint: context.tr.name,
                                controller: auth.nameController,
                                prefix: SvgPicture.asset(
                                    'assets/icons/profile.svg')),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: ExpressTextField(
                                    hint: context.tr.phone,
                                    controller: auth.phoneController,
                                  ),
                                ),
                                SarFlagWidget(
                                  size: size.width * 0.3,
                                  outline: true,
                                  filled: true,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ExpressTextField(
                                hint: context.tr.email,
                                controller: auth.emailController,
                                prefix:
                                    SvgPicture.asset('assets/icons/email.svg')),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 0.5.sw,
                    child: ExpressButton(
                      style: ExpressButtonStyle.primary,
                      onPressed: () {
                        log('next');
                        auth.updateProfile();
                      },
                      child: Text(context.tr.edit_profile,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
