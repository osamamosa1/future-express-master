import 'package:flutter/material.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/media_query_values.dart';

class LoginTypeItem extends StatelessWidget {
  const LoginTypeItem({
    super.key,
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.4,
      height: context.height * 0.2,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Palette.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(image),
              Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFFca1221),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
