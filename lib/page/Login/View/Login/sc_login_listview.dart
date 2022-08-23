import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_type_define.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/page/Login/View/Login/sc_login_btn.dart';
import 'package:smartcommunity/page/Login/View/Login/sc_login_logo.dart';
import 'package:smartcommunity/page/Login/View/Login/sc_login_textfield.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/utils/Toast/sc_toast.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../../network/sc_http_manager.dart';
import '../../../../network/sc_url.dart';
import '../../../../skin/Model/sc_user.dart';
import '../../../../skin/Tools/sc_scaffold_manager.dart';
import '../../../../utils/Loading/sc_loading_utils.dart';
import 'sc_login_agreement.dart';

/// 登录页listview

class SCLoginListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return getSeparateItem(index: index);
        },
        itemCount: 5);
  }

  /// cell
  Widget getCell({required int index}) {
    if (index == SCTypeDefine.SC_LOGIN_TYPE_LOGO) {
      return logoItem();
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_TEXTFIELD) {
      return textFieldItem();
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_BUTTON) {
      return loginBtnItem();
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_AGREEMENT) {
      return agreementItem();
    } else {
      return const SizedBox();
    }
  }

  /// 分割线
  Widget getSeparateItem({required int index}) {
    if (index == SCTypeDefine.SC_LOGIN_TYPE_LOGO) {
      return const SizedBox(
        height: 0,
      );
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_TEXTFIELD) {
      return const SizedBox(
        height: 32.0,
      );
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_BUTTON) {
      return const SizedBox(
        height: 10.0,
      );
    } else {
      return const SizedBox();
    }
  }

  /// logo
  Widget logoItem() {
    return const SCLoginLogo();
  }

  /// 手机号验证码输入框
  Widget textFieldItem() {
    return GetBuilder<SCLoginController>(builder: (state) {
      return SCLoginTextField();
    });
  }

  /// 登录按钮
  Widget loginBtnItem() {
    return GetBuilder<SCLoginController>(builder: (state) {
      return SCLoginBtn(
        enable: state.loginBtnEnable,
        onPressed: () {
          SCLoginController state = Get.find<SCLoginController>();

          if (state.loginBtnEnable == false) {
            return;
          }

          if (SCUtils().checkPhone(phone: state.phone) == false) {
            SCToast.showTip('请输入正确的手机号');
            return;
          }

          if (state.isAgree == false) {
            SCToast.showTip('请同意用户服务协议和隐私协议');
            return;
          }
          // if (state.phone.isEmpty) {
          //   SCToast.showTip('请输入手机号');
          //   return;
          // } else if (state.phone.length != 11) {
          //   SCToast.showTip('请输入正确的手机号');
          //   return;
          // }
          //
          // if (state.code.isEmpty) {
          //   SCToast.showTip('请输入验证码');
          //   return;
          // } else if (state.code.length != 6) {
          //   SCToast.showTip('请输入正确的验证码');
          //   return;
          // }

          log('请求验证码登陆接口');
          SCLoadingUtils.show();
          SCHttpManager.instance.post(
              url: SCUrl.kPhoneCodeLoginUrl,
              params: {'mobileNum' : state.phone, 'code' : state.code},
              success: (value) {
                SCUser user = SCScaffoldManager.instance.getUserData();
                log('登陆成功获取用户token=====${user.token}===用户昵称：${user.userName}');
                SCRouterHelper.codePage(9003, null);
              },
              failure: (value) {
                log('登陆失败===$value');
                String message = value['message'];
                SCToast.showTip(message);
              });
        },
      );
    });
  }

  /// 用户协议和隐私政策
  Widget agreementItem() {
    return GetBuilder<SCLoginController>(builder: (state) {
      return SCLoginAgreement(
        isAgree: state.isAgree,
        agreeAction: () {
          state.updateAgreementState();
        },
        agreementDetailAction: (String url) {},
      );
    });
  }
}
