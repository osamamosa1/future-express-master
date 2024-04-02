import 'package:flutter/material.dart';
import 'package:future_express/shared/palette.dart';
import 'package:shimmer/shimmer.dart';

class MyLoadingPage extends StatelessWidget {
  const MyLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Shimmer.fromColors(baseColor: Palette.primaryLightColor , highlightColor:Palette.greyColor, child:    Image.asset('assets/images/logo_splash.png'))),
    );
  }
}
