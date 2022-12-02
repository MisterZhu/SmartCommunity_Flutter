
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_login_controller.dart';

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

  /// 手机号输入长度
  int inputLength = 0;

  /// 是否显示手机号删除按钮
  bool isShowPhoneClear = false;

  /// 验证码按钮是否可以点击
  bool isCodeBtnEnable = false;

  /// 手机号长度，因为中间有两个空格，所以是13
  final int phoneLength = 13;

  /// 光标的位置，手机号输入完成时光标位置为11
  int cursorPosition = 0;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  initState() {
    super.initState();
    phoneController.addListener(phoneControllerNotify);
    phoneNode.addListener(phoneFocusChange);
  }

  /// body
  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 57.0),
      child: Container(
        decoration: BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: SCColors.color_CBCBCB, width: 0.5)
        ),
        child: phoneItem(),
      ),
    );
  }

  /// 手机号容器
  Widget phoneItem() {
    return Container(
      height: 48.0,
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
        phoneInputFormatter(),
        LengthLimitingTextInputFormatter(phoneLength),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: "请输入手机号",
        hintStyle: TextStyle(fontSize: 16, color: SCColors.color_B0B1B8),
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
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.next,
    );
  }

  /// 格式化手机号
  TextInputFormatter phoneInputFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text;
      // 获取光标左边的文本
      final positionStr = (text.substring(0, newValue.selection.baseOffset)).replaceAll(RegExp(r"\s+\b|\b\s"), "");
      // 计算格式化后的光标位置
      int length = positionStr.length;
      cursorPosition = length;
      var position = 0;
      if (length <= 3) {
        position = length;
      } else if (length <= 7) {
        // 因为前面的字符串里面加了一个空格
        position = length + 1;
      } else if (length <= 11) {
        // 因为前面的字符串里面加了两个空格
        position = length + 2;
      } else {
        // 号码本身为 11 位数字，因多了两个空格，故为 13
        position = 13;
      }

      //这里格式化整个输入文本
      text = text.replaceAll(RegExp(r"\s+\b|\b\s"), "");
      var string = "";
      for (int i = 0; i < text.length; i++) {
        // 这里第 4 位，与第 8 位，我们用空格填充
        if (i == 3 || i == 7) {
          if (text[i] != " ") {
            string = string + " ";
          }
        }
        string += text[i];
      }
      return TextEditingValue(
        text: string,
        selection: TextSelection.fromPosition(TextPosition(offset: position, affinity: TextAffinity.upstream)),
      );
    });
  }

  /// 删除icon
  Widget deleteIcon() {
    if (isShowPhoneClear) {
      return GestureDetector(
        child: Container(
          padding: const EdgeInsets.only(right: 12.0),
          width: 40,
          height: 40,
          alignment: Alignment.centerRight,
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

  /// 监听手机号controller
  phoneControllerNotify() {
    SCLoginController state = Get.find<SCLoginController>();
    bool status = false;
    state.phone = phoneController.text.removeAllWhitespace;
    updateCodeButtonState();

    if (phoneController.text.isEmpty) {
      status = false;
    } else {
      status = true;
    }

    if (mounted) {
      setState(() {
        isShowPhoneClear = status;
      });
    }
  }

  /// 验证码按钮是否可以点击
  updateCodeButtonState() {
    SCLoginController state = Get.find<SCLoginController>();
    if (state.phone.length == 11) {
      state.updateCodeButtonState(enable: true);
    } else {
      state.updateCodeButtonState(enable: false);
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

    if (mounted) {
      setState(() {
        isShowPhoneClear = status;
      });
    }
  }

  /// 手机号格式化
  formatPhoneNumber(String text) {
    if (text.length == phoneLength) {
      if (mounted) {
        setState(() {
          isCodeBtnEnable = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isCodeBtnEnable = false;
        });
      }
    }

  /// 输入的文本内容长度为13，且光标在文本最后，cursorPosition=11时，焦点自动跳到验证码输入框
  if (text.length == phoneLength && cursorPosition == phoneLength - 2) {
      phoneNode.unfocus();
    }

    inputLength = text.length;
  }

  @override
  dispose() {
    super.dispose();
    phoneNode.dispose();
    phoneController.dispose();
  }
}
