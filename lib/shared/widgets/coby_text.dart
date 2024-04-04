import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:future_express/shared/palette.dart';

class CopyableWidget extends StatefulWidget {
  final String textToCopy;

  const CopyableWidget({super.key, required this.textToCopy});

  @override
  _CopyableWidgetState createState() => _CopyableWidgetState();
}

class _CopyableWidgetState extends State<CopyableWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // عند النقر على العنصر، قم بنسخ النص إلى الحافظة
        unawaited(Clipboard.setData(ClipboardData(text: widget.textToCopy)));

        // قم بإظهار رسالة توضيحية للمستخدم
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم نسخ النص إلى الحافظة'),
          ),
        );
      },
      child: Text(
        widget.textToCopy,
        style: const TextStyle(color: Palette.greyColor, fontSize: 18),
      ),
    );
  }
}
