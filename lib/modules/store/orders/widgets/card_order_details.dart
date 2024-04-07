import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/model/order.dart';
import 'package:future_express/shared/components/components.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_card.dart';
import 'package:qr_flutter/qr_flutter.dart';


class CardOrderDetails extends StatelessWidget {
  const CardOrderDetails({
    super.key,
    required this.order,
    required this.isArabic,
  });

  final Order order;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 18,
            right: 12,
            left: 12,
            bottom: 8,
          ),
          width: 0.9.sw,
          height: 372.h,
          child: ExpressCard(
            padding: const EdgeInsets.only(
              top: 18,
              right: 12,
              left: 12,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QrImageView(
                  data: order.orderId,
                  version: QrVersions.auto,
                  size: 250.0.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      text: '${context.tr.order} : #${order.orderId}',
                      // textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Palette.blackColor,
                        fontSize: 18,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Clipboard.setData(
                              ClipboardData(text: order.orderId));
                          showToast(
                            message: 'Copied to Clipboard',
                            toastStates: ToastStates.EROOR,
                          );
                        },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        !isArabic
            ? Positioned(
                top: 70.h,
                right: -32.h,
                child: Image.asset(
                  'assets/images/Poly.png',
                  height: 320.h,
                ),
              )
            : Positioned(
                top: 40.h,
                left: -40.h,
                child: Image.asset(
                  'assets/images/Poly-r.png',
                  height: 350.h,
                ),
              ),
        !isArabic
            ? Positioned(
                top: 200.h,
                right: 15.h,
                child: Text(
                  '${order.amount} ${context.tr.sar}',
                  style: TextStyle(
                      color: Palette.whiteColor,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold),
                ),
              )
            : Positioned(
                top: 210.h,
                left: 15.h,
                child: Text.rich(TextSpan(
                  text: "${order.amount} ${context.tr.sar}",
                  style: TextStyle(
                    color: Palette.whiteColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ))
                // Text(
                //   '${widget.order.amount} ${context.tr.sar}',
                //   style: TextStyle(
                //     color: Palette.whiteColor,
                //     fontSize: 24.sp,
                //     fontWeight: FontWeight.bold,
                //
                //   ),
                //
                // ),
                ),
      ],
    );
  }
}
