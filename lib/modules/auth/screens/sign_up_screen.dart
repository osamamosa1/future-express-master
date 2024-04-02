import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/modules/auth/cubit/auth_cubit.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/express_text_field.dart';
import 'package:future_express/shared/widgets/header_text.dart';
import 'package:future_express/shared/widgets/notic_text.dart';
import 'package:future_express/shared/widgets/text_field_header.dart';

import '../../../shared/components/constant.dart';
import '../../../shared/palette.dart';
import '../../../shared/utils/my_utils.dart';
import '../widgets/pick_image_widget.dart';
import '../widgets/sar_flag_widget.dart';
import '../widgets/selctedImage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    unawaited(AuthCubit.get(context).getCity());
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool personal = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return personal ? formOne(context, size) : formTwo(size);
  }

  Widget formOne(BuildContext context, Size size) {
    AuthCubit auth = AuthCubit.get(context);
    return Scaffold(
          resizeToAvoidBottomInset: true,
          body:SafeArea(
      child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:  Column(
            children: [
              Container(
                height: .85.sh,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeaderText(text: context.tr.new_registration),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFieldHeader(text: context.tr.personal_info),
                        const SizedBox(
                          height: 10,
                        ),
                        ExpressTextField(
                            hint: context.tr.name,
                            controller: auth.nameController,
                            prefix: SvgPicture.asset('assets/icons/profile.svg')),
                        const SizedBox(
                          height: 10,
                        ),
                        ExpressTextField(
                            hint: context.tr.nationality,
                            controller: auth.nationalityController,
                            prefix: SvgPicture.asset(
                                'assets/icons/flight_international.svg')),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFieldHeader(
                            text: context.tr.accommodation_status_card),
                        NoticText(
                            text: context.tr.stated_on_card_residence_permit),
                        const SizedBox(
                          height: 10,
                        ),
                        ExpressTextField(
                            hint: context.tr.num,
                            controller: auth.statusCardNumberController,
                            prefix: SvgPicture.asset('assets/icons/id_card.svg')),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) => SizedBox(
                            height: 105.h,
                            child: DropdownButtonFormField(
                              validator: Validation().empty,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hint: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/city.svg'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    context.tr.city,
                                  ),
                                ],
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.grey.shade300),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              dropdownColor: Colors.grey.shade50,
                              value: auth.city,
                              onChanged: (String? newValue) {
                                auth.city = newValue!;
                                log(auth.city.toString());
                                unawaited(auth.getregions(newValue));
                              },
                              items: auth.cityItems!.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.id!.toString(),
                                  child: Text(
                                    value.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color: Palette.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        NeighborhoodDropdownButtonFormField(auth: auth),
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
                            prefix: SvgPicture.asset('assets/icons/email.svg')),
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
                width: size.width * 0.42,
                child: ExpressButton(
                  style: ExpressButtonStyle.primary,
                  onPressed: () {
                    setState(() {
                      personal = false;
                    });
                  },
                  child: Text(context.tr.next,
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

  WillPopScope formTwo(Size size) {
    AuthCubit auth = AuthCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          personal = true;
        });
        return false;
      },
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    HeaderText(text: context.tr.new_registration),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFieldHeader(
                      text: context.tr.vehicle_info,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpressTextField(
                        hint: context.tr.vehicle_details,
                        controller: auth.vehicleDetailsController,
                        prefix: SvgPicture.asset('assets/icons/profile.svg')),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.43,
                          child: ExpressTextField(
                              hint: context.tr.plate_num,
                              controller: auth.plateNumController,
                              prefix: SvgPicture.asset(
                                  'assets/icons/flight_international.svg')),
                        ),
                        SizedBox(
                          width: size.width * 0.43,
                          child: ExpressTextField(
                              hint: context.tr.expiry_date,
                              controller: auth.expiryDateController,
                              prefix: SvgPicture.asset(
                                  'assets/icons/flight_international.svg')),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldHeader(text: context.tr.required_photos),
                    NoticText(text: context.tr.attachments_id),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PickImageWidget(
                            title: context.tr.identification,
                            image: auth.avatar,
                            onPressed: () async {
                              showMyBottomSheet(
                                  context,
                                  ImageSourceBottomShet(
                                      onPressed: auth.getAvatar));
                            }),
                        PickImageWidget(
                            title: context.tr.front_photo,
                            image: auth.frontPhoto,
                            onPressed: () {
                              showMyBottomSheet(
                                  context,
                                  ImageSourceBottomShet(
                                      onPressed: auth.getFrontPhoto));
                            }),
                        PickImageWidget(
                            title: 'form',
                            image: auth.formImage,
                            onPressed: () {
                              showMyBottomSheet(
                                  context,
                                  ImageSourceBottomShet(
                                      onPressed: auth.getFormImage));
                            }),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.42,
                      child: ExpressButton(
                        style: ExpressButtonStyle.secondary,
                        onPressed: () {
                          setState(() {
                            personal = true;
                          });
                        },
                        child: Text(context.tr.previous,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: size.width * 0.42,
                      child: ExpressButton(
                        loading: state is LodingRequestJoin,
                        style: ExpressButtonStyle.primary,
                        onPressed: () {
                          unawaited(AuthCubit.get(context).request_join());
                        },
                        child: Text(context.tr.next,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class NeighborhoodDropdownButtonFormField extends StatelessWidget {
  const NeighborhoodDropdownButtonFormField({
    super.key,
    required this.auth,
  });

  final AuthCubit auth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => SizedBox(
              height: 105.h,
              child: DropdownButtonFormField(
                validator: Validation().empty,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hint: Row(
                  children: [
                    SvgPicture.asset('assets/icons/location.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      context.tr.neighborhood,
                    ),
                  ],
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey.shade300),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                dropdownColor: Colors.grey.shade50,
                value: auth.regions,
                onChanged: (String? newValue) {
                  auth.regions = newValue!;
                },
                items: auth.regionsItems!.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.id!.toString(),
                    child: Text(
                      value.title!,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: Palette.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                    ),
                  );
                }).toList(),
              ),
            ));
  }
}
