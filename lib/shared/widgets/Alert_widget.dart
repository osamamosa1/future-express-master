import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/model/order_rest/order/order.dart';

import 'package:future_express/shared/palette.dart';

import 'express_button.dart';

class AlertClasses {
  static Widget ConfirmOrdersDialog(
    BuildContext context,
    Future<void> setPickUp,
  ) =>
      AlertDialog(
        icon: const Icon(
          Icons.info,
          color: Palette.primaryColor,
          size: 75,
        ),
        title: const Text('انتبه'),
        content: const Text('هل انت متأكد من استلامك كافة الطلبات',
            textAlign: TextAlign.center),
        actions: [
          SizedBox(
            height: 90.h,
            width: 0.3.sw,
            child: ExpressButton(
              onPressed: () async {
                await setPickUp;
                Navigator.pop(context);
              },
              style: ExpressButtonStyle.primary,
              child: const Text(
                'نعم',
                style: TextStyle(
                    color: Palette.whiteColor, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          SizedBox(
            height: 90.h,
            width: 0.3.sw,
            child: ExpressButton(
              onPressed: () => Navigator.pop(context),
              style: ExpressButtonStyle.secondary,
              child: const Text(
                'تراجع',
                style: TextStyle(
                    color: Palette.primaryColor, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
  static Widget DelateOrdersDialog(
    BuildContext context,
    VoidCallback setPickUp,
  ) =>
      AlertDialog(
        icon: const Icon(
          Icons.info,
          color: Palette.primaryColor,
          size: 75,
        ),
        title: const Text('انتبه'),
        content: const Text('هل انت متأكد من حذف الطلب'),
        actions: [
          SizedBox(
            height: 90.h,
            width: 0.3.sw,
            child: ExpressButton(
              onPressed: () async {
                setPickUp();
                Navigator.pop(context);
              },
              style: ExpressButtonStyle.primary,
              child: const Text(
                'نعم',
                style: TextStyle(
                    color: Palette.whiteColor, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          SizedBox(
            height: 90.h,
            width: 0.3.sw,
            child: ExpressButton(
              onPressed: () => Navigator.pop(context),
              style: ExpressButtonStyle.secondary,
              child: const Text(
                'تراجع',
                style: TextStyle(
                    color: Palette.primaryColor, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
  static Future<void> showInvoice(
      BuildContext context, OrdersRestaurant orders) {
    return showDialog(
      context: context,
      barrierDismissible:
          true, // يمنع إغلاق الـ AlertDialog عند النقر على البلور

      builder: (BuildContext context) {
        return Stack(alignment: Alignment.center, children: [
          ModalBarrier(
            color: Colors.black.withOpacity(0.2),
            dismissible: false,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Center(
              child: AlertDialog(
                content: Container(
                  height: 350,
                  width: 250,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Text(
                        'فاتورة الطلب',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: const Text(
                              'الصنف',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                              width: 100.w,
                              child: const Text(
                                'الحجم',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              )),
                          SizedBox(
                            width: 25.w,
                          ),
                          SizedBox(
                              width: 100.w,
                              child: const Text(
                                'العدد',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              )),
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        height: 0.25.sh,
                        child: ListView.separated(
                          itemCount: orders.productList.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      orders.productList[index].productName!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        orders.productList[index].size!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: Text(
                                      orders.productList[index].number
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]);
      },
    );
  }
}
