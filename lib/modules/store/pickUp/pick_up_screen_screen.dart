import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/back_botton.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';
import 'package:future_express/shared/widgets/qr_code_screen.dart';

import 'cubit/pickup_cubit.dart';
import 'package:audioplayers/audioplayers.dart';

class PickUpScreenScreen extends StatefulWidget {
  const PickUpScreenScreen({super.key});

  @override
  State<PickUpScreenScreen> createState() => _PickUpScreenScreenState();
}

class _PickUpScreenScreenState extends State<PickUpScreenScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
String? newVal;
  void init() async {
    await _audioPlayer
        .setSourceUrl('asset.mp3'); // استبدل بالمسار الفعلي لملف الصوت الخاص بك
  }

  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickupCubit, PickupState>(listener: (context, state) {
      if (state is SuccessScanOrderState) {
        unawaited(_audioPlayer.play(AssetSource('images/alert.mp3')));


        // استبدل بالمسار الفعلي لملف الصوت الخاص بك
      }
    }, builder: (context, state) {
      return BackButtonHandler(
        onWillPop: () => router.go('/homeLayOut'),
        child: Scaffold(
          appBar: ExpressAppBar(
            myTitle: 'Order scaned',
            widget: IconButton(
                onPressed: () => router.go('/homeLayOut'),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextButton(
              //     onPressed: () {
              //       PickupCubit.get(context).scanOrder(code: 'OR000618');
              //     },
              //     child: const Text('context.tr.order')),
              SizedBox(
                height: 0.8.sh,
                child: QRViewExample(
                  onScan: (String value) {

                    PickupCubit.get(context).scanOrder(code: value);
                    print("mmmmmmmmmmmm $value");
                  },
                ),
                // QrCodeScanner(
                //     title: 'pick up',
                //     description: 'scan the order',
                //     onScan: (v) {
                //       print("in scanned v is $v");
                //       // if (!isScanned) {
                //       //   PickupCubit.get(context).scanOrder(code: v);
                //       //   isScanned = true;
                //       // }
                //
                //       // PickupCubit.get(context).scanOrder(code: v);
                //     }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
