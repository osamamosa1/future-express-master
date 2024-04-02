import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_express/modules/profile/screens/edit_profile_screen.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/utils/my_utils.dart';

import '../../../shared/palette.dart';
import '../../../shared/utils/back_botton.dart';
import '../../../shared/widgets/express_app_bar.dart';
import '../../account/widgets/account_list_tile.dart';
import '../widgets/choose_language_bottom_sheet.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    super.key,
  });

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    return BackButtonHandler(
      child: Scaffold(
        appBar: ExpressAppBar(
          myTitle: context.tr.profile,
          widget: const SizedBox(),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              AccountListTile(
                title: context.tr.edit_profile,
                icon: 'assets/icons/profile.svg',
                onPressed: () {
                  unawaited(pushPage(context, const EditProfileScreen()));
                },
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              AccountListTile(
                title: context.tr.language,
                icon: 'assets/icons/translate.svg',
                onPressed: () => _changeLanguage(),
                trailing: const SizedBox(
                  width: 80.0,
                  height: 24.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Palette.greyColor,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              AccountListTile(
                title: context.tr.notifications,
                icon: 'assets/icons/notification.svg',
                onPressed: () {},
                trailing: CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeLanguage() {
    showMyBottomSheet(context, const ChooseLanguageBottomSheet());
  }
}
