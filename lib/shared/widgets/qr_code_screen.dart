import 'package:flutter/material.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/widgets/camera_border_painter.dart';

// import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

//
//
// class QrCodeScanner extends StatefulWidget {
//   final String title;
//   final String description;
//   final void Function(String value) onScan;
//
//   const QrCodeScanner({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.onScan,
//   });
//
//   @override
//   State<QrCodeScanner> createState() => _QrCodeScannerState();
// }
//
// class _QrCodeScannerState extends State<QrCodeScanner> {
//   bool detected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final size = MediaQuery.sizeOf(context);
//
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         MobileScanner(
//           startDelay: true,
//           onDetect: (capture) {
//             final value = capture.barcodes.first.rawValue;
//
//             if (value == null) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('the_qr_code_is_broken_please_try_again'),
//                 ),
//               );
//               return;
//             }
//
//             if (!detected) {
//               widget.onScan(value);
//             }
//
//             setState(() {
//               detected = true;
//             });
//           },
//         ),
//         ColorFiltered(
//           colorFilter: ColorFilter.mode(
//             Palette.blackColor.withOpacity(0.8),
//             BlendMode.srcOut,
//           ),
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   color: Palette.blackColor,
//                   backgroundBlendMode: BlendMode.dstOut,
//                 ),
//               ),
//               Center(
//                 child: Container(
//                   width: 0.85 * size.width,
//                   height: 0.85 * size.width,
//                   decoration: BoxDecoration(
//                     color: Palette.blackColor,
//                     borderRadius: BorderRadius.circular(50.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Center(
//           child: CustomPaint(
//             foregroundPainter: CameraBorderPainter(),
//             child: SizedBox(
//               width: 0.85 * size.width,
//               height: 0.85 * size.width,
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: 0.1 * size.width,
//             horizontal: 0.15 * size.width,
//           ),
//           child: Column(
//             children: [
//               Text(
//                 widget.title,
//                 style: theme.textTheme.titleLarge!
//                     .copyWith(color: Palette.whiteColor),
//               ),
//               const SizedBox(height: 24.0),
//               Text(
//                 widget.description,
//                 textAlign: TextAlign.center,
//                 style: theme.textTheme.titleMedium!
//                     .copyWith(color: Palette.whiteColor, height: 1.75),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key, required this.onScan}) : super(key: key);
  final void Function(String value) onScan;

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    else
                      const Text('Scan a code'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () {
                                router.go('/orderScaned');
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Text('Finish');
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        widget.onScan(scanData.code ?? 'Loading');
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
