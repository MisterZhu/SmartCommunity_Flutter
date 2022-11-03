
import 'dart:async';
import 'dart:developer';
import 'dart:convert' as convert;
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

  /// 是否显示关闭按钮，默认不显示
  late bool showCloseBtn = false;

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
          // SCUser user = SCScaffoldManager.instance.getUserData();
          // log('登陆成功获取用户token=====${user.token}===用户昵称：${user.userName}');
          var userParams = value['userInfoV'];
          List defaultConfigList = userParams['defaultConfigList'];
          SCUser user = SCUser.fromJson(userParams);

          if (defaultConfigList.isNotEmpty) {
            var defaultParams = defaultConfigList.first;
            num? defaultConfigId = defaultParams['id'];
            var jsonValue = defaultParams['jsonValue'];
            var jsonParams = convert.jsonDecode(jsonValue);
            user.defaultConfigId = defaultConfigId;
            user.communityId = jsonParams['communityId'];
            user.communityName = jsonParams['communityName'];
            user.spaceId = jsonParams['spaceId'];
            user.spaceName = jsonParams['spaceName'];
            user.identityId = jsonParams['identityId'];
            user.identityName = jsonParams['identityName'];
            user.housingId = jsonParams['housingId'];
          }

          SCScaffoldManager.instance.user = user;
          SCScaffoldManager.instance.isLogin = true;

          if (showCloseBtn) {
            SCRouterHelper.back(null);
            Get.forceAppUpdate();
          } else {
            if (user.communityId == null || user.communityId == '') {
              SCRouterHelper.pathPage(SCRouterPath.selectCommunityPath, {"type" : SCSelectHouseLogicType.login});
            } else {
              SCRouterHelper.codeOffAllPage(10000, null);
            }
          }
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