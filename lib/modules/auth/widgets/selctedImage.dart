import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/modules/auth/cubit/auth_cubit.dart';
import 'package:future_express/modules/auth/widgets/pick_image_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceBottomShet extends StatelessWidget {
  final VoidCallback onPressed;

  const ImageSourceBottomShet({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 10.h),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 300.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PickImageWidget(
                onPressed: () async {
                  AuthCubit.get(context).source = ImageSource.camera;
                  context.pop();
                  onPressed();
                },
                title: 'camera'),
            SizedBox(
              width: 25.w,
            ),
            PickImageWidget(
                onPressed: () async {
                  AuthCubit.get(context).source = ImageSource.gallery;

                  context.pop();
                  onPressed();
                },
                title: 'gallery'),
          ],
        ),
      ),
    );
  }
}
