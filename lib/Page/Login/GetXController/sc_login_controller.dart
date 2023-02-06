
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../../Constants/sc_enum.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../../../Skin/Model/sc_user.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';

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
  codeLogin({required Function(int code) resultHandler}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kPhoneCodeLoginUrl,
        params: {'mobileNum' : phone, 'code' : code, 'appCode': SCDefaultValue.appCode},
        success: (value) {
          //print('请求登录接口value=============$value');
          if (value['retCode'] != null) {
            var dic = jsonDecode(value['retCode']);
            if (dic['code'] == 200000003) {
              resultHandler(200000003);
            }
          } else {
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
            resultHandler(200);
            if (showCloseBtn) {
              SCRouterHelper.back(null);
              Get.forceAppUpdate();
            } else {
              SCRouterHelper.pathOffAllPage(SCRouterPath.tabPath, null);
            }
          }
        },
        failure: (value) {
          log('登陆失败===$value');
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          resultHandler(-1);
        });
  }

  /// 登录并完善信息接口
  codeLoginWithName({
    required String userInputName,
    required String birthday,
    required String gender,
    required Function(bool success) resultHandler}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kPhoneCodeLoginWithNameUrl,
        params: {
          "appCode": SCDefaultValue.appCode,
          "birthday": birthday,
          "gender": gender,
          "mobileNum": phone,
          "userInputName": userInputName
        },
        success: (value) {
          //print('登录并完善信息接口value=============$value');
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
          resultHandler(true);
          SCRouterHelper.pathOffAllPage(SCRouterPath.tabPath, null);
        },
        failure: (value) {
          print('登陆失败===$value');
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          resultHandler(false);
        });

  }

}