
import 'package:get/get.dart';

class SCLoginController extends GetxController {
  /// 是否同意相关协议，默认不同意
  bool isAgree = false;

  /// 手机号
  String phone = '';

  /// 验证码
  String code = '';

  /// 登录按钮是否可以点击
  bool loginBtnEnable = false;

  /// 更新勾选协议状态
  updateAgreementState() {
    isAgree = !isAgree;
    update();
  }

  /// 登录按钮是否可以点击
  updateLoginButtonState({required bool enable}) {
    loginBtnEnable = enable;
    update();
  }
}