
import 'package:flutter/material.dart';
import 'package:future_express/shared/widgets/custom_button.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final double iconSize;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool hasCancel;
  const ConfirmationDialog({Key? key, 
    required this.icon, this.iconSize = 50, this.title, required this.description, required this.onYesPressed,
    this.isLogOut = false, this.hasCancel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding:  EdgeInsets.all(8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(icon, width: iconSize, height: iconSize),
          ),

          title != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal:8),
            child: Text(
              title!, textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ) : const SizedBox(),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(description, style: TextStyle(fontSize:18), textAlign: TextAlign.center),
          ),
          const SizedBox(height: 12),

           Expanded(child: CustomButton(
                'ok'.tr,
                onPress: () =>  onYesPressed(),
              )),
        ]),
      ),
    );
  }
}