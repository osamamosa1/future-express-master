import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/shared/palette.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final XFile? image;
  const PickImageWidget(
      {super.key, required this.title, required this.onPressed, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 90,
            height: 80,
            decoration: BoxDecoration(
                color: Palette.greyColor.shade200,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Palette.greyColor.shade500,
                )),
            child: image == null
                ? Center(
                    child: SvgPicture.asset(
                      'assets/icons/pick_image.svg',
                      height: 40,
                      width: 40,
                    ),
                  )
                : Image.file(File(image!.path)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Palette.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
