import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smartcommunity/skin/View/sc_custom_scaffold.dart';

/// 扫一扫page

class SCScanPage extends StatefulWidget {

  SCScanPage({Key? key}) : super(key: key);

  @override
  SCScanState createState() => SCScanState();
}

class SCScanState extends State<SCScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(),
      ),
    );
  }

  /// 扫描结果
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("扫描结果:${scanData.code}");
      // setState(() {
      //   result = scanData;
      //   //'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
      // });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}