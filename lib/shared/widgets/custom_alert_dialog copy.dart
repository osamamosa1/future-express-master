
import 'package:flutter/material.dart';
import 'package:future_express/shared/widgets/custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String description;
  final Function onOkPressed;
  const CustomAlertDialog({super.key, required this.description, required this.onOkPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Icon(Icons.info, size: 80, color: Theme.of(context).primaryColor),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description, textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),

          CustomButton(
        'ok',
            onPress: onOkPressed(),
          ),

        ]),
      ),
    );
  }
}
