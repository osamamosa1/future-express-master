import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/shared/components/constant.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';

import '../cubit/join_service_provider_cubit.dart';

class DropdownBody extends StatelessWidget {
  const DropdownBody({
    super.key,
    required this.ServiceProvider,
  });

  final JoinServiceProviderCubit ServiceProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<JoinServiceProviderCubit, JoinServiceProviderState>(
          builder: (context, state) => SizedBox(
            height: 105.h,
            child: DropdownButtonFormField(
              validator: Validation().empty,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              dropdownColor: Colors.grey.shade50,
              value: ServiceProvider.city,
              onChanged: (String? newValue) {
                ServiceProvider.city = newValue!;
              },
              items: ServiceProvider.cityItems!.map((value) {
                return DropdownMenuItem<String>(
                  value: value.id!.toString(),
                  child: Text(
                    value.title!,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
        BlocBuilder<JoinServiceProviderCubit, JoinServiceProviderState>(
          builder: (context, state) => SizedBox(
            height: 105.h,
            child: DropdownButtonFormField(
              validator: Validation().empty,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hint: Row(
                children: [
                  SvgPicture.asset('assets/icons/city.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    context.tr.is_transport,
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
              value: ServiceProvider.IsTransport,
              onChanged: (String? newValue) {
                ServiceProvider.IsTransport = newValue!;
              },
              items: ServiceProvider.IsTransportItems!.map((value) {
                return DropdownMenuItem<String>(
                  value: value.id!.toString(),
                  child: Text(
                    value.title!,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
      ],
    );
  }
}
