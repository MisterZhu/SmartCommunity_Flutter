
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_login_code_item.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_number_keyboard_item.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../GetXController/sc_login_code_controller.dart';
import '../../GetXController/sc_login_controller.dart';

/// 输入验证码页面
class SCLoginCodeView extends StatelessWidget {

  SCLoginController loginState = Get.find<SCLoginController>();

  SCLoginCodeController codeState = Get.find<SCLoginCodeController>();

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: SCUtils().getBottomSafeArea()),
      decoration: const BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 18.0,),
          topItem(context),
          const SizedBox(height: 8.0,),
          phoneItem(),
          const SizedBox(height: 28.0,),
          codeItem(),
          const SizedBox(height: 18.0,),
          sendCodeItem(),
          const SizedBox(height: 42.0,),
          keyboardView(context),
        ],
      ),
    );
  }

  /// 顶部文字item
  Widget topItem(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 44.0,),
          const Expanded(
            child: Text(
              '输入验证码',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SCFonts.f22,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1C33,
            ),)),
          SizedBox(width: 44.0,
            child: CupertinoButton(
                padding: const EdgeInsets.only(top: 0.0, left: 10.0,bottom: 12.0,right: 16.0),
                child: Image.asset(
                  SCAsset.iconLoginCodeClose,
                  width: 18.0,
                  height: 18.0,
                ),
                onPressed: () {
                  clearData(context);
                }),
          ),
        ],
      ),
    );
  }

  /// 验证码已发至 XXX手机号
  Widget phoneItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '验证码已发至 ',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99,
          ),),
        Text(
          '${phoneNumberFormatter()}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_1B1D33,
          ),)
      ],
    );
  }

  /// 格式化手机号
  phoneNumberFormatter() {
    var string = "";
    for (int i = 0; i < loginState.phone.length; i++) {
      // 这里第 4 位，与第 8 位，我们用空格填充
      if (i == 3 || i == 7) {
        if (loginState.phone[i] != " ") {
          string = string + " ";
        }
      }
      string += loginState.phone[i];
    }
    return string;
  }

  /// 验证码输入框
  Widget codeItem() {
    return SCLoginCodeItem(numberList: codeState.numberList);
  }

  /// 获取验证码按钮item
  Widget sendCodeItem() {
    return GestureDetector(
      onTap: (){
        if (codeState.isCodeBtnEnable == true) {
          /// 发送验证码
          sendCode();
        }
      },
      child: Text(
        codeState.codeText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.normal,
            color: codeState.isCodeBtnEnable ? SCColors.color_FF6C00 : SCColors.color_8D8E99),
      ),
    );
  }

  /// 数字键盘
  Widget keyboardView(BuildContext context) {
    return SCNumberKeyboardItem(numberTapAction: (int number) {
      codeState.numberListAdd(value: number);
      if (codeState.numberList.length == 6) {
        loginState.code = codeState.numberList.join();
        loginState.login(resultHandler: (status) {
          if (status == true) {
            clearData(context);
          }
        });
      }
    }, deleteAction: () {
      codeState.numberListDelete();
    },);
  }

  /// 清空数据，并关闭页面
  clearData(BuildContext context) {
    codeState.disposeTimer();
    codeState.numberListClear();
    codeState.codeTime = 60;
    codeState.codeText = '重新发送';
    Navigator.of(context).pop();
  }

  /// 请求发送验证码接口
  sendCode() {
    loginState.sendCode(resultHandler: (status){
      if (status == true) {
        codeState.initTimer();
      }
    });
  }

}