import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/extension.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/widgets/express_app_bar.dart';
import '../../../shared/widgets/express_button.dart';
import '../../../shared/widgets/express_text_field.dart';
import '../cubit/report_cubit.dart';

class FormReport extends StatelessWidget {
  const FormReport({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    var report = ReportCubit.get(context);

    return BlocProvider(
      create: (context) => ReportCubit()..getClient(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: ExpressAppBar(
            myTitle: context.tr.today_report,
            widget: IconButton(
              onPressed: () => router.pop(),
              icon: const Icon(Icons.arrow_back_ios, color: Palette.greyColor),
            )),
        body: SingleChildScrollView(
          child: Container(
            height: 0.85.sh,
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                BlocBuilder<ReportCubit, ReportState>(
                    builder: (context, state) {
                  return report.ClientItems!.isEmpty
                      ? const SizedBox()
                      : DropdownButtonFormField(
                          validator: Validation().empty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hint: Row(
                            children: [
                              SvgPicture.asset('assets/icons/client.svg'),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                context.tr.client,
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
                          value: report.Client,
                          onChanged: (String? newValue) {
                            report.Client = newValue!;
                            print(report.Client);
                          },
                          items: report.ClientItems!.map((value) {
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
                        );
                }),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: ExpressTextField(
                            hint: context.tr.received_orders,
                            controller: report.RecipientController,
                            prefix: SvgPicture.asset('assets/icons/order.svg')),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 70,
                        child: ExpressTextField(
                            hint: context.tr.delivered_orders,
                            controller: report.ReceivedController,
                            prefix: SvgPicture.asset('assets/icons/order.svg')),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 70,
                        child: ExpressTextField(
                            hint: context.tr.returned_orders,
                            controller: report.ReturnedController,
                            prefix:
                                SvgPicture.asset('assets/icons/received.svg')),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 70,
                        child: ExpressTextField(
                            hint: context.tr.amounts_collected,
                            controller: report.totalController,
                            prefix: SvgPicture.asset(
                                'assets/icons/receive-money.svg')),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 1.sw,
                  child: ExpressButton(
                    child: Text(
                      context.tr.send,
                      style: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      if (report.Client == null) {
                        showToast(
                            message: 'اختار عميل ',
                            toastStates: ToastStates.SUCCESS);
                      }
                      if (formKey.currentState!.validate()) {
                        log('hiiiiiiiiiiiiiiiiiiiiiiii');

                        report.SendReport();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
