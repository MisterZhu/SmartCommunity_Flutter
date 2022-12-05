import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Base/Scan/View/sc_scan_navigation.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_default_value.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_scan_controller.dart';

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
  SCScanController state = Get.put(SCScanController());

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
      body: Stack(
        children: [
          scanView(),
          navigation()
        ],
      ),
    );
  }

  /// 扫码view
  Widget scanView() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(),
      onPermissionSet: (controller, status) {
        if (status == false) {
          showNoPermissionAlert();
        }
      },
    );
  }

  /// 导航栏
  Widget navigation() {
    return Positioned(
      left: 0, right: 0 ,top: SCUtils().getTopSafeArea(),
        child: GetBuilder<SCScanController>(builder: (state){
          return SCScanNavigation(
            isOpenFlash: state.isOpenFlash,
            tapBack: () {/// 返回
              SCRouterHelper.back(null);
            },
            tapAlbum: () {/// 相册
              scanFromAlbum();
            },
            tapFlash: () {/// 闪光灯
              openFlash();
            },
          );
        })
    );
  }

  /// 扫描结果
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.stopCamera();
      SCRouterHelper.back(scanData.code);
    });
  }

  /// 无权限弹窗
  showNoPermissionAlert() {
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      title: "温馨提示",
      content: SCDefaultValue.noCameraPermissionMessage,
      customWidgetButtons: [
        defaultCustomButton(context,
            text: '好的',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400, onTap: () {
          openAppSettings();
        }),
      ],
    );
  }

  /// 从相册选择照片扫描
  scanFromAlbum() {
    SCLoadingUtils.developing();
  }

  /// 开启闪光灯
  openFlash() {
    controller?.toggleFlash();
    state.openFlash(isOpen: !state.isOpenFlash);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
