
import 'dart:developer';

import 'package:get/get.dart';

import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../skin/Model/sc_user.dart';
import '../../../skin/Tools/sc_scaffold_manager.dart';
import '../../../utils/Loading/sc_loading_utils.dart';
import '../../../utils/Router/sc_router_helper.dart';
import '../../../utils/Toast/sc_toast.dart';

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

  sendCode({required Function(bool success) resultHandler}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kSendCodeUrl,
        params: {'mobileNum' : phone},
        success: (value) {
          SCToast.showTip('验证码发送成功');
          resultHandler(true);
        },
        failure: (value) {
          String message = value['message'];
          SCToast.showTip(message);
          resultHandler(false);
        });
  }

  login() {
    SCRouterHelper.codePage(9003, null);

    // SCLoadingUtils.show();
    // SCHttpManager.instance.post(
    //     url: SCUrl.kPhoneCodeLoginUrl,
    //     params: {'mobileNum' : phone, 'code' : code},
    //     success: (value) {
    //       SCUser user = SCScaffoldManager.instance.getUserData();
    //       log('登陆成功获取用户token=====${user.token}===用户昵称：${user.userName}');
    //       SCRouterHelper.codePage(9003, null);
    //     },
    //     failure: (value) {
    //       log('登陆失败===$value');
    //       String message = value['message'];
    //       SCToast.showTip(message);
    //     });
  }
}