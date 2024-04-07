import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/order.dart';
import '../../../../shared/palette.dart';
import '../../../../shared/utils/my_utils.dart';
import '../../../../shared/widgets/express_card.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => unawaited(
                GoRouter.of(context).push('/orderDetails', extra: order)),
            child: ExpressCard(
              padding: const EdgeInsets.only(
                top: 18,
                right: 12,
                left: 12,
                bottom: 8,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 0.14.sw,
                          height: 130,
                          child: Image.network(
                            order.storeImage.toString(),
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/logo_splash.png'),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, bottom: 0, right: 8, top: 0),
                              child: Text(
                                order.clientName,
                                style: TextStyle(
                                    color: Palette.blackColor,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Palette.greyColor,
                                  ),
                                ),
                                Text(
                                  order.clientName,
                                  style: TextStyle(
                                      color: Palette.greyColor,
                                      fontSize: 22.sp),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Palette.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 0.5.sw,
                                  child: Text(
                                    order.clientPhone,
                                    style: TextStyle(
                                        color: Palette.primaryColor,
                                        fontSize: 22.sp),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Palette.primaryColor,
                                  ),
                                ),
                                Text(
                                  order.orderStatus,
                                  style: TextStyle(
                                      color: Palette.primaryColor,
                                      fontSize: 22.sp),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Palette.greyColor,
                                  ),
                                ),
                                Text(
                                  (order.amountPaid==1)?'paid':'notPaid',
                                  style: TextStyle(
                                      color: (order.amountPaid==1)?Palette.successColor:Palette.greyColor,
                                      fontSize: 26.sp),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                        child: SizedBox(
                          child: ExpressButton(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/direction.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(context.tr.directions),
                              ],
                            ),
                            onPressed: () {
                              if(order.latitude==null||order.latitude==''){
                                unawaited(launchUrl(Uri.parse(
                                    'https://www.google.com/maps/@${order.latitude},${order.longitude},6z')));

                              }else{
                                showDialog(context: context, builder: (context)=>AlertDialog(
                                  title:const Text ('no location provided'),
                                  actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('ok'))],
                                ));
                              }
                              },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                        child: SizedBox(
                          child: ExpressButton(
                            child: Text(context.tr.contact),
                            onPressed: () {
                              showContant(context);
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        !isArabic
            ? Positioned(
                top: 95.h,
                right: -19.h,
                child: Image.asset(
                  'assets/images/Poly.png',
                  height: 200.h,
                ),
              )
            : Positioned(
                top: 60.h,
                left: -30.h,
                child: Image.asset(
                  'assets/images/Poly-r.png',
                  height: 250.h,
                ),
              ),
        !isArabic
            ? Positioned(
                top: 178.h,
                right: 15.h,
                child: Text(
                  '${order.amount} ${context.tr.sar}',
                  style: TextStyle(
                      color: Palette.whiteColor,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold),
                ),
              )
            : Positioned(
                top: 190.h,
                left: 2.h,
                child: Text(
                  '${order.amount} ${context.tr.sar}',
                  style: TextStyle(
                      color: Palette.whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
      ],
    );
  }

  void showContant(BuildContext context) {
    return showMyBottomSheet(
        context,
        SizedBox(
          height: 180,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text('Contact Viaa',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => unawaited(launchUrl(
                        Uri.parse(
                            'https://wa.me/+${order.clientPhone}?text=${Localizations.localeOf(context).languageCode == 'ar' ? order.whatUpMassageAr : order.whatUpMassage}'),
                      )),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/whatsapp.png',
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'What’s App',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () => unawaited(launchUrl(
                        Uri.parse('tel:+${order.clientPhone}'),
                      )),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/call.png',
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Mobile Phone',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
