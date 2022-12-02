
import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';

class SCLoginCodeController extends GetxController {

  /// 验证码数组
  late List<int> numberList = [];

  /// 验证码定时器
  late Timer? codeTimer;

  /// 倒计时
  late int codeTime = 60;

  /// 重新发送验证码按钮是否可以点击
  bool isCodeBtnEnable = false;

  /// 验证码按钮text
  String codeText = '重新发送';

  /// 输入验证码
  numberListAdd({required int value}) {
    if (numberList.length < 6) {
      numberList.add(value);
      update();
    }
  }

  /// 删除验证码
  numberListDelete() {
    if (numberList.isNotEmpty) {
      numberList.removeLast();
      update();
    }
  }

  /// 清空验证码数据
  numberListClear() {
    if (numberList.isNotEmpty) {
      numberList.clear();
      update();
    }
  }

  /// 初始化定时器
  initTimer() {
    isCodeBtnEnable = false;
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      codeTime--;
      if (codeTime <= 0) {
        codeTime = 60;
        isCodeBtnEnable = true;
        codeText = "重新发送";
        disposeTimer();
      } else {
        codeText = '重新发送(${codeTime}s)';
      }
      update();
    });
  }

  /// 销毁定时器
  disposeTimer() {
    codeTimer?.cancel();
    codeTimer = null;
  }

  @override
  dispose() {
    super.dispose();
    disposeTimer();
  }

}