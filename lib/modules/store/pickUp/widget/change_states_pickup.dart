import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/modules/store/pickUp/cubit/pickup_cubit.dart';
import 'package:future_express/shared/network/local/cache_helper.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/Alert_widget.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/orders_utils.dart';
import 'package:go_router/go_router.dart';

import '../../../home/cubit/home_cubit.dart';

class ChangeStatePickup extends StatefulWidget {
  const ChangeStatePickup({super.key});

  @override
  State<ChangeStatePickup> createState() => _ChangeStatePickupState();
}

class _ChangeStatePickupState extends State<ChangeStatePickup> {
  @override
  Widget build(BuildContext context) {
    var statusesItem = HomeCubit.get(context);

    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Container(
          height: 0.6.sh,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                context.tr.change_status_order,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...[
                      ...getVisibleStatuses(statusesItem.statusesItems!,
                              CacheHelper.getData(key: 'user') == 2)
                          .map((value) {
                        bool isSelected =
                            statusesItem.statuseItme == value.id.toString();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                                child: Text(
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'ar'
                                      ? value.titleAr.toString()
                                      : value.title.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Palette.primaryColor
                                          : Palette.greyColor),
                                ),
                                onPressed: () {
                                  setState(() {
                                    statusesItem.statuseItme =
                                        value.id.toString();
                                    PickupCubit.get(context).statuseItme =
                                        value.id.toString();
                                  });
                                }),
                            const Divider()
                          ],
                        );
                      }).toList(),
                    ],
                  ],
                ),
              ),
              SizedBox(
                width: 1.sw,
                child: ExpressButton(
                    child: Text(
                      context.tr.confirm,
                      style: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => AlertClasses.ConfirmOrdersDialog(
                          context,
                          PickupCubit.get(context)
                              .setAllOrder()
                              .then((value) => context.pop()),
                        ),
                      );
                      context.pop();
                    }),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ));
    });
  }
}
