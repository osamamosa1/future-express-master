import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/shared/widgets/body_text1.dart';
import 'package:future_express/shared/widgets/header_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'locale_cubit.dart';

class ChooseLanguageBottomSheet extends StatefulWidget {
  const ChooseLanguageBottomSheet({super.key});

  @override
  State<ChooseLanguageBottomSheet> createState() =>
      _ChooseLanguageBottomSheetState();
}

class _ChooseLanguageBottomSheetState extends State<ChooseLanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<LocaleCubit, Locale?>(builder: (context, state) {
      return SizedBox(
        height: 200,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            HeaderText(text: t.choose_a_language),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _languageWidget(
                    'assets/icons/sar_flag.svg', t.arabic, const Locale('ar')),
                const SizedBox(
                  width: 50,
                ),
                _languageWidget(
                    'assets/icons/english.svg', t.english, const Locale('en')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    });
  }

  Widget _languageWidget(String icon, String title, Locale locale) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<LocaleCubit>(context).changeLocale(
            locale); // قم بتغيير اللغة عند النقر على العلم أو النص
        Navigator.of(context).pop(); // قم بإخفاء البوتوم شيت بمجرد تحديد اللغة
      },
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 80,
            height: 80,
          ),
          const SizedBox(
            height: 10,
          ),
          BodyText1(text: title),
        ],
      ),
    );
  }
}
