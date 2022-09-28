
import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../constants/sc_enum.dart';
import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../skin/Model/sc_user.dart';
import '../../../skin/Tools/sc_scaffold_manager.dart';
import '../../../utils/Loading/sc_loading_utils.dart';
import '../../../utils/Router/sc_router_helper.dart';
import '../../../utils/Router/sc_router_path.dart';
import '../../../utils/Toast/sc_toast.dart';

class SCLoginController extends GetxController {
  /// 是否同意相关协议，默认不同意
  bool isAgree = false;

  /// 手机号
  String phone = '';

  /// 验证码
  String code = '';

  /// 获取验证码按钮是否可以点击
  bool codeBtnEnable = false;

  /// 获取验证码按钮是否可以点击
  updateCodeButtonState({required bool enable}) {
    codeBtnEnable = enable;
    update();
  }

  /// 更新勾选协议状态
  updateAgreementState() {
    isAgree = !isAgree;
    update();
  }

  /// 发送验证码
  sendCode({required Function(bool success) resultHandler}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kSendCodeUrl,
        params: {'mobileNum' : phone},
        success: (value) {
          SCLoadingUtils.success(text:'验证码发送成功');
          resultHandler(true);
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          resultHandler(false);
        });
  }

  /// 请求登录接口
  login() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kPhoneCodeLoginUrl,
        params: {'mobileNum' : phone, 'code' : code},
        success: (value) {
          SCUser user = SCScaffoldManager.instance.getUserData();
          log('登陆成功获取用户token=====${user.token}===用户昵称：${user.userName}');
          SCRouterHelper.pathPage(SCRouterPath.selectCommunityPath, {"type" : SCSelectHouseLogicType.login});
        },
        failure: (value) {
          log('登陆失败===$value');
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
        });
  }
}