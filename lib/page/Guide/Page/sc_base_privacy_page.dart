/// 用户协议和隐私政策弹窗page

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import '../../../constants/sc_colors.dart';
import '../../../constants/sc_key.dart';
import '../../../utils/Toast/sc_toast.dart';
import '../GetXController/sc_base_privacy_controller.dart';
import '../View/Privacy/sc_privacy_alert.dart';

class SCBasePrivacyPage extends StatefulWidget {
  const SCBasePrivacyPage({Key? key}) : super(key: key);

  @override
  SCBasePrivacyState createState() => SCBasePrivacyState();
}

class SCBasePrivacyState extends State<SCBasePrivacyPage> {

  SCBasePrivacyController state = Get.find<SCBasePrivacyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: body(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// body
  Widget body() {
    return Stack(
      children: [
        maskItem(),
        privacyAlertItem()
      ],
    );
  }

  /// 半透明背景蒙层
  Widget maskItem() {
    return Container(
      width: double.infinity,
      color: SCColors.color_000000.withOpacity(0.5),
    );
  }

  /// 协议弹窗
  Widget privacyAlertItem() {
    return GetBuilder<SCBasePrivacyController>(builder: (state){
      return SCBasicPrivacyAlert(
        isAgree: state.isAgree,
        titleString: state.title,
        contentString: state.content,
        userAgreementUrl: '用户协议url',
        privacyPolicyUrl: '隐私政策url',
        cancelAction: (){
          log('取消');
        },
        sureAction: () async {
          if (state.isAgree == true) {
            SharedPreferences preference = await SharedPreferences.getInstance();
            preference.setBool(SCKey.isShowPrivacyAlert, false);
            //SCRouterHelper.codeOffAllPage(10000, null);
            SCRouterHelper.codeOffAllPage(9001, null);
          } else {
            SCToast.showTip('请先同意用户协议和隐私政策');
          }
        },
        agreeAction: () {
          state.updateAgreementState();
        },
        agreementDetailAction: (String url) {
          log('协议详情:${url}');
        },
      );
    });
  }
}
