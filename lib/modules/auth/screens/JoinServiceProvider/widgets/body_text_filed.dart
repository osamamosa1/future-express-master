import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_text_field.dart';

import '../cubit/join_service_provider_cubit.dart';

class BodyTextFiled extends StatelessWidget {
  const BodyTextFiled({
    super.key,
    required this.ServiceProvider,
  });

  final JoinServiceProviderCubit ServiceProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ExpressTextField(
            hint: context.tr.name_company,
            controller: ServiceProvider.nameController,
            prefix: SvgPicture.asset('assets/icons/profile.svg')),
        const SizedBox(
          height: 10,
        ),
        ExpressTextField(
            hint: context.tr.email,
            controller: ServiceProvider.emailController,
            prefix: SvgPicture.asset('assets/icons/email.svg')),
        const SizedBox(
          height: 10,
        ),
        ExpressTextField(
          hint: context.tr.manger_phone,
          controller: ServiceProvider.mangerPhoneController,
        ),
        const SizedBox(
          height: 10,
        ),
        ExpressTextField(
          hint: context.tr.num_employees,
          controller: ServiceProvider.numEmployeesController,
        ),
        const SizedBox(
          height: 10,
        ),
        ExpressTextField(
          hint: context.tr.num_car,
          controller: ServiceProvider.numCarsController,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
