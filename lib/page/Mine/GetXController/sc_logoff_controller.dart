

import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../skin/Tools/sc_scaffold_manager.dart';
import '../../../utils/Loading/sc_loading_utils.dart';
import '../../../utils/Toast/sc_toast.dart';

/// 账户注销controller

class SCLogoffController extends GetxController {
  /// 是否同意相关协议，默认不同意
  bool isAgree = false;

  /// 手机号
  String? phone = SCScaffoldManager.instance.user.mobileNum;

  /// 验证码
  String code = '';

  /// 验证码定时器
  late Timer? codeTimer;

  /// 倒计时
  late int codeTime = 60;

  /// 发送验证码按钮是否可以点击
  bool isCodeBtnEnable = true;

  /// 验证码按钮text
  String codeBtnText = '获取验证码';

  /// 确认按钮是否可以点击
  bool isSureBtnEnable = false;


  /// 获取验证码按钮是否可以点击
  updateCodeButtonState({required bool enable}) {
    isCodeBtnEnable = enable;
    update();
  }

  /// 更新勾选协议状态
  updateAgreementState() {
    isAgree = !isAgree;
    update();
  }

  /// 确认按钮是否可以点击
  updateSureButtonState({required bool enable}) {
    isSureBtnEnable = enable;
    update();
  }

  /// 发送验证码
  sendCode() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kSendCodeUrl,
        params: {'mobileNum' : phone},
        success: (value) {
          SCLoadingUtils.success(text:'验证码发送成功');
          initTimer();
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
        });
  }

  /// 初始化定时器
  initTimer() {
    isCodeBtnEnable = false;
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      codeTime--;
      if (codeTime <= 0) {
        codeTime = 60;
        isCodeBtnEnable = true;
        codeBtnText = "重新发送";
        disposeTimer();
      } else {
        codeBtnText = '${codeTime}s后重新发送';
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