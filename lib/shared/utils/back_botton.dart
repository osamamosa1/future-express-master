import 'package:flutter/material.dart';

class BackButtonHandler extends StatelessWidget {
  final Widget child;
  final Function()? onWillPop;

  const BackButtonHandler({required this.child, this.onWillPop});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (onWillPop != null) {
          // قم بتنفيذ السلوك المخصص إذا كان محددًا
          return onWillPop!();
        }
        // يمكنك تركه فارغًا إذا كنت تريد السلوك الافتراضي (العودة إلى الشاشة السابقة)
        return true;
      },
      child: child,
    );
  }
}
