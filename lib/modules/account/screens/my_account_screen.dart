import 'dart:async';

import 'package:flutter/material.dart';
import 'package:future_express/modules/technicalSupport/TechnicalSupportScreen.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/utils/my_utils.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';

import '../../../layouts/cubit/cubit.dart';
import '../../../shared/utils/back_botton.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../profile/screens/my_profile_screen.dart';
import '../widgets/account_list_tile.dart';
import '../../notification/notifications_screen.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackButtonHandler(
      child: Scaffold(
        appBar: ExpressAppBar(
          myTitle: context.tr.profile,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              AccountListTile(
                title: context.tr.my_acc,
                icon: 'assets/icons/profile.svg',
                onPressed: () {
                  unawaited(pushPage(context, const MyProfileScreen()));
                },
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              AccountListTile(
                title: context.tr.technical_support,
                icon: 'assets/icons/notification.svg',
                onPressed: () {
                  unawaited(pushPage(context, const TechnicalSupport()));
                },
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              AccountListTile(
                title: context.tr.notifications,
                icon: 'assets/icons/notification.svg',
                onPressed: () {
                  unawaited(pushPage(context, const NotificationScreen()));
                },
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              AccountListTile(
                title: context.tr.log_out,
                icon: 'assets/icons/exit.svg',
                onPressed: () {
                  AppCubit.get(context).stopLocationRecord();

                  AuthCubit.get(context).signOut();
                },
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
}
