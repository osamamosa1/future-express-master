import 'package:flutter/material.dart';

import '../palette.dart';

class ExpressCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final String? image;

  const ExpressCard({
    super.key,
    this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.onPressed,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
            color: Palette.whiteColor,
            boxShadow: [Palette.cardShadow],
            borderRadius: BorderRadius.circular(10),
            image: image == null
                ? null
                : DecorationImage(image: AssetImage(image!), fit: BoxFit.fill)),
        child: child,
      ),
    );
  }
}
