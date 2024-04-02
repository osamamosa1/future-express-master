import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/modules/notification/cubit/notification_cubit.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';

import '../../shared/palette.dart';
import '../../shared/router.dart';
import '../account/widgets/notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var not =
        NotificationCubit.get(context).notificationResponse!.notifications.data;
    return BlocProvider(
      create: (context) => NotificationCubit()..fetchNotification(),
      child: Scaffold(
        appBar: ExpressAppBar(
          myTitle: context.tr.notifications,
          widget: IconButton(
            onPressed: () => router.pop(),
            icon: const Icon(Icons.arrow_back_ios, color: Palette.greyColor),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemBuilder: (ctx, index) => NotificationWidget(
                        not: not[index],
                      ),
                  itemCount: not.length),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
