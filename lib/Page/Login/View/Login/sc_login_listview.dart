import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_agreement.dart';
import 'package:smartcommunity/Constants/sc_type_define.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_login_btn_item.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_login_code_btn.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_login_code_view.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_login_header.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_login_textfield.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../../Utils/Colors/sc_color_hex.dart';
import '../../GetXController/sc_login_code_controller.dart';
import 'sc_login_agreement.dart';

/// 登录页listview

class SCLoginListView extends StatelessWidget {

  late final BuildContext currentContext;
  final bool showClose;

  SCLoginListView({Key? key, this.showClose = false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listView(),
        agreementItem(),
      ],
    );
  }

  Widget listView() {
    return Expanded(child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return getSeparateItem(index: index);
        },
        itemCount: 4));
  }

  /// cell
  Widget getCell({required int index}) {
    if (index == SCTypeDefine.SC_LOGIN_TYPE_LOGO) {
      return headerItem();
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_TEXTFIELD) {
      return textFieldItem();
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_CODE_BUTTON) {
      return codeBtnItem();
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_SKIP_BUTTON) {
      return skipBtnItem();
    } else {
      return const SizedBox();
    }
  }

  /// 分割线
  Widget getSeparateItem({required int index}) {
    if (index == SCTypeDefine.SC_LOGIN_TYPE_LOGO) {
      return const SizedBox(
        height: 50.0,
      );
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_TEXTFIELD) {
      return const SizedBox(
        height: 25.0,
      );
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_CODE_BUTTON) {
      return const SizedBox(
        height: 10.0,
      );
    } else {
      return const SizedBox();
    }
  }

  /// header
  Widget headerItem() {
    return SCLoginHeader(
      showClose: showClose,
      closeAction: () {
        SCRouterHelper.back(null);
    },);
  }

  /// 手机号验证码输入框
  Widget textFieldItem() {
    return GetBuilder<SCLoginController>(builder: (state) {
      return SCLoginTextField();
    });
  }

  /// 获取验证码按钮
  Widget codeBtnItem() {
    return GetBuilder<SCLoginController>(builder: (state) {
      return SCLoginCodeBtn(
        enable: state.codeBtnEnable,
        onPressed: () {
          SCLoginController state = Get.find<SCLoginController>();
          if (state.codeBtnEnable == false) {
            return;
          }

          if (SCUtils().checkPhone(phone: state.phone) == false) {
            SCToast.showTipWithGravity(msg: '请输入正确的手机号', gravity: ToastGravity.BOTTOM);
            return;
          }

          if (state.isAgree == false) {
            SCToast.showTipWithGravity(msg: '请同意用户服务协议和隐私协议', gravity: ToastGravity.BOTTOM);
            return;
          }
          sendCode();
        },
      );
    });
  }

  /// 游客模式按钮
  Widget skipBtnItem() {
    return SCLoginBtnItem(skipTapAction: () {
      if (showClose) {
        SCRouterHelper.back(null);
      } else {
        SCRouterHelper.pathOffAllPage(SCRouterPath.tabPath, null);
      }
    }, register: () {

    },);
  }

  /// 用户协议和隐私政策
  Widget agreementItem() {
    List<dynamic> list = [
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '我已阅读并同意',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '《用户服务协议》',
        'imageUrl': '',
        'url': SCAgreement.userAgreementUrl,
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '《隐私协议》',
        'imageUrl': '',
        'url': SCAgreement.privacyProtocolUrl,
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '并使用本机号码登录',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
    ];
    return GetBuilder<SCLoginController>(builder: (state) {
      return SCLoginAgreement(
        list: list,
        isAgree: state.isAgree,
        agreeAction: () {
          state.updateAgreementState();
        },
        agreementDetailAction: (String title, String url) {
          var params = {'title' : title, 'url' : url,'removeLoginCheck' : true};
          SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
        },
      );
    });
  }

  /// 请求发送验证码接口
  sendCode() {
    SCLoginController state = Get.find<SCLoginController>();
    state.sendCode(resultHandler: (status) {
      if (status == true) {
        /// 发送验证码成功弹出输入验证码页面
        showCodeView();
      }
    });
  }

  /// 输入验证码页面
  showCodeView() {
    SCLoginCodeController state = Get.put(SCLoginCodeController());
    state.initTimer();
    Widget widget = GetBuilder<SCLoginCodeController>(builder: (state){
      return SCLoginCodeView();
    });
    SCDialogUtils().showCustomBottomDialog(context: currentContext, widget: widget);
  }

}
