import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/header_text.dart';
import 'package:future_express/shared/widgets/text_field_header.dart';

import '../cubit/join_service_provider_cubit.dart';
import '../widgets/body_text_filed.dart';
import '../widgets/dropdown_body.dart';

class JoinServiceProviderScreen extends StatefulWidget {
  const JoinServiceProviderScreen({super.key});

  @override
  State<JoinServiceProviderScreen> createState() =>
      _JoinServiceProviderScreenState();
}

class _JoinServiceProviderScreenState extends State<JoinServiceProviderScreen> {
  @override
  void initState() {
    unawaited(JoinServiceProviderCubit.get(context).getCity());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ServiceProvider = JoinServiceProviderCubit.get(context);
    return BlocBuilder<JoinServiceProviderCubit, JoinServiceProviderState>(
        builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 16.h),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              HeaderText(text: context.tr.request_join_service_provider),
              const SizedBox(
                height: 25,
              ),
              TextFieldHeader(text: context.tr.personal_info),
              BodyTextFiled(ServiceProvider: ServiceProvider),
              DropdownBody(ServiceProvider: ServiceProvider),
              const Spacer(),
              SizedBox(
                child: ExpressButton(
                  loading: state is LodingRequestJoin,
                  style: ExpressButtonStyle.primary,
                  onPressed: () {
                    unawaited(
                        JoinServiceProviderCubit.get(context).request_join());
                  },
                  child: Text(context.tr.next,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
