
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/page/Mine/View/RealNameVerify/sc_input_formatter.dart';

import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';
import '../../GetXController/sc_real_name_verify_controller.dart';

/// 实名认证姓名、身份证号输入TextField

class SCRealNameVerifyTextField extends StatefulWidget {

  @override
  SCRealNameVerifyTextFieldState createState() => SCRealNameVerifyTextFieldState();
}

class SCRealNameVerifyTextFieldState extends State<SCRealNameVerifyTextField> {

  SCRealNameVerifyController state = Get.find<SCRealNameVerifyController>();

  /// 姓名controller
  TextEditingController nameController = TextEditingController();
  /// 身份证号controller
  TextEditingController numberController = TextEditingController();

  /// 姓名focusNode
  FocusNode nameNode = FocusNode();

  /// 身份证号focusNode
  FocusNode numberNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  initState() {
    super.initState();

  }

  /// body
  Widget body() {
    return Container(
      decoration: BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameItem(),
          line(),
          numberItem(),
        ],
      ),
    );
  }

  /// 姓名item
  Widget nameItem() {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          nameText(),
          const SizedBox(width: 10.0,),
          Expanded(child: nameTextField()),
        ],
      ),
    );
  }

  Widget nameText() {
    return const Text(
        '证件姓名',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1C33,
        ));
  }

  /// 姓名textField
  Widget nameTextField() {
    return TextField(
      controller: nameController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: nameNode,
      textAlign: TextAlign.right,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: "",
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
        state.name = value;
      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

  /// 身份证号item
  Widget numberItem() {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          numberText(),
          const SizedBox(width: 10.0,),
          Expanded(child: numberTextField()),
        ],
      ),
    );
  }

  Widget numberText() {
    return const Text(
        '身份证号',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.w500,
        color: SCColors.color_1B1C33,
    ));
  }

  /// 身份证号textField
  Widget numberTextField() {
    return TextField(
      controller: numberController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: numberNode,
      textAlign: TextAlign.right,
      inputFormatters: [
        LengthLimitingTextInputFormatter(18),
        SCInputFormatter(RegExp("^[A-Za-z0-9]")),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: "",
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
        state.number = value;
      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

  /// 横线
  Widget line() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
    nameController.dispose();
    numberController.dispose();
  }

}