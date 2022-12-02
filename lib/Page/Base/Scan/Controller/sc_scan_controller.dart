import 'package:get/get.dart';

/// 扫一扫controller
class SCScanController extends GetxController {
  /// 是否开启闪光灯
  bool isOpenFlash = false;

  /// 开启闪光灯
  openFlash({required bool isOpen}) {
    isOpenFlash = isOpen;
    update();
  }
}