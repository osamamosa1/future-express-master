import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/model/statices_model.dart';
import 'package:future_express/modules/home/cubit/home_cubit.dart';
import 'package:future_express/shared/utils/extension.dart';

import '../../../shared/palette.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      Statistics? state = HomeCubit.get(context).statistics;
      final isArabic = Localizations.localeOf(context).languageCode == 'ar';
      return Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
          height: 0.28.sh,
          decoration: BoxDecoration(
              boxShadow: [Palette.cardShadow],
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/wallet_card.png'),
                fit: BoxFit.fitWidth,
              )),
          child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 90, 0, 0),
              child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr.current_wallet_balance,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Palette.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "${state?.balanceAccount ?? 'Loading'}",

                          style: const TextStyle(
                            fontSize: 26,
                            color: Palette.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: context.tr.sar,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Palette.whiteColor,
                              ),
                            ),
                          ]),
                    ),
                    const Spacer(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ])));
    });
  }
}
