import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/model/notificationModel.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/widgets/express_card.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationItem not;
  const NotificationWidget({required this.not, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(not.updatedAt);

    String formattedDate = DateFormat.yMMMMd('en_US').format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ExpressCard(
        padding: const EdgeInsets.only(top: 18, right: 12, bottom: 8, left: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/icons/notification2.svg',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(width: 0.7.sw, child: Text(not.message)),
                  ],
                ),
                SizedBox(
                  height: 40,
                  width: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(endIndent: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/calender.svg',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          formattedDate,
                          style: const TextStyle(
                              color: Palette.greyColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
