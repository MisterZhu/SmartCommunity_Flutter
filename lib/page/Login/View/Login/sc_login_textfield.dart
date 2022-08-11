
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_login_controller.dart';

/// 手机号和验证码输入框

class SCLoginTextField extends StatefulWidget {

  @override
  SCLoginTextFieldState createState() => SCLoginTextFieldState();
}

class SCLoginTextFieldState extends State<SCLoginTextField> {
  /// 手机号controller
  TextEditingController phoneController = TextEditingController();

  /// 手机号focusNode
  FocusNode phoneNode = FocusNode();

  /// 验证码controller
  TextEditingController codeController = TextEditingController();

  /// 验证码focusNode
  FocusNode codeNode = FocusNode();

  /// 手机号输入长度
  int inputLength = 0;

  /// 是否显示手机号删除按钮
  bool isShowPhoneClear = false;

  /// 验证码按钮是否可以点击
  bool isCodeBtnEnable = false;
  /// 验证码按钮text
  String codeText = "获取验证码";
  /// 验证码定时器
  late Timer codeTimer;
  /// 倒计时
  int codeTime = 60;
  /// 验证码按钮背景颜色
  Color codeBGColor = SCColors.color_FFC59B;

  /// 手机号长度
  final int phoneLength = 13;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  initState() {
    super.initState();
    phoneController.addListener(phoneControllerNotify);
    codeController.addListener(codeControllerNotify);
    phoneNode.addListener(phoneFocusChange);
  }

  /// body
  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [phoneItem(), line(), codeItem()],
        ),
      ),
    );
  }

  /// 手机号容器
  Widget phoneItem() {
    return Container(
      height: 46.0,
      padding: const EdgeInsets.only(left: 12.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: phoneTextField()),
          const SizedBox(
            width: 10.0,
          ),
          deleteIcon()
        ],
      ),
    );
  }

  /// 手机号textField
  Widget phoneTextField() {
    return TextField(
      controller: phoneController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: phoneNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(phoneLength),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        hintText: "请输入11位手机号",
        hintStyle: TextStyle(fontSize: 14, color: SCColors.color_B0B1B8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {
        formatPhoneNumber(value);
      },
      keyboardType: TextInputType.phone,
      keyboardAppearance: Brightness.dark,
      textInputAction: TextInputAction.next,
    );
  }

  /// 删除icon
  Widget deleteIcon() {
    if (isShowPhoneClear) {
      return GestureDetector(
        child: Container(
          padding: const EdgeInsets.only(right: 12.0),
          width: 36,
          height: 40,
          alignment: Alignment.centerRight,
          color: Colors.white,
          child: Image.asset(SCAsset.iconGreyDelete, width: 18.0, height: 18.0),
        ),
        onTap: () {
          phoneController.clear();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  /// 横线
  Widget line() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 验证码容器
  Widget codeItem() {
    return Container(
      height: 46.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: codeTextField()),
          const SizedBox(
            width: 10.0,
          ),
          sendCodeItem()
        ],
      ),
    );
  }

  /// 验证码输入框
  Widget codeTextField() {
    return TextField(
      controller: codeController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: codeNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        hintText: "请输入短信验证码",
        hintStyle: TextStyle(fontSize: SCFonts.f14, color: SCColors.color_B0B1B8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {},
      keyboardType: TextInputType.number,
      keyboardAppearance: Brightness.dark,
      textInputAction: TextInputAction.next,
    );
  }

  /// 获取验证码item
  Widget sendCodeItem() {
    if (codeTime < 60 && codeTime > 0) {
      return Text(
        codeText,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.normal,
            color: SCColors.color_FF6C00),
      );
    } else {
      return GestureDetector(
        onTap: (){
          if (isCodeBtnEnable == true) {
            initTimer();
          }
        },
        child: Container(
          width: 100.0,
          height: 28.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: codeBGColor, width: 0.5)),
          child: Text(
            codeText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.normal,
                color: codeBGColor),
          ),
        ),
      );
    }
  }

  /// 监听手机号controller
  phoneControllerNotify() {
    SCLoginController state = Get.find<SCLoginController>();
    bool status = false;
    state.phone = phoneController.text.removeAllWhitespace;
    updateLoginButtonState();

    if (phoneController.text.isEmpty) {
      status = false;
    } else {
      status = true;
    }

    setState(() {
      isShowPhoneClear = status;
    });
  }

  /// 登录按钮是否可以点击
  updateLoginButtonState() {
    SCLoginController state = Get.find<SCLoginController>();

    if (state.phone.length == 11 && state.code.length == 6) {
      state.updateLoginButtonState(enable: true);
    } else {
      state.updateLoginButtonState(enable: false);
    }
  }

  /// 监听手机号聚焦
  phoneFocusChange() {
    bool status = false;
    if (phoneNode.hasFocus) {
      if (phoneController.text.isEmpty) {
        status = false;
      } else {
        status = true;
      }
    } else {
      status = false;
    }

    setState(() {
      isShowPhoneClear = status;
    });
  }

  /// 手机号格式化
  formatPhoneNumber(String text) {

    if (text.length > inputLength) {
      // 输入
      if (text.length == 4 || text.length == 9) {
        text = "${text.substring(0, text.length - 1)} ${text.substring(text.length - 1, text.length)}";
        phoneController.text = text;
        phoneController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: text.length)); //光标移到最后
      }
    } else {
      // 删除
      if (text.length == 4 || text.length == 9) {
        text = text.substring(0, text.length - 1);
        phoneController.text = text;
        phoneController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: text.length)); //光标移到最后
      }
    }

    if (text.length == phoneLength) {
      setState(() {
        isCodeBtnEnable = true;
        codeBGColor = SCColors.color_FF6C00;
      });
    } else {
      setState(() {
        isCodeBtnEnable = false;
        codeBGColor = SCColors.color_FFC59B;
      });
    }

    if (text.length == phoneLength) {
      phoneNode.unfocus();
      codeNode.requestFocus();
    }

    inputLength = text.length;
  }

  /// 监听验证码controller
  codeControllerNotify() {
    SCLoginController state = Get.find<SCLoginController>();
    state.code = codeController.text;
    updateLoginButtonState();
  }

  /// 初始化定时器
  void initTimer() {
    isCodeBtnEnable = false;
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      codeTime--;
      setState(() {
        if (codeTime <= 0) {
          codeTime = 60;
          codeBGColor = phoneController.text.length == phoneLength ? SCColors.color_FF6C00 : SCColors.color_FFC59B;
          isCodeBtnEnable = phoneController.text.length == phoneLength ? true : false;
          codeText = "获取验证码";
          disposeTimer();
        } else {
          codeText = '${codeTime}s';
          codeBGColor = SCColors.color_FF6C00;
        }
      });
    });
  }

  /*销毁定时器*/
  void disposeTimer() {
    codeTimer.cancel();
  }

  @override
  dispose() {
    super.dispose();
    phoneNode.dispose();
    codeNode.dispose();
    phoneController.dispose();
    codeController.dispose();
    disposeTimer();
  }
}
