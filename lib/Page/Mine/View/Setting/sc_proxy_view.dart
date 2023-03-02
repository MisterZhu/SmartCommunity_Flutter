import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/sc_sp_utils.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Utils/sc_utils.dart';

/// 抓包设置view

class SCProxyView extends StatefulWidget {
  @override
  SCProxyViewState createState() => SCProxyViewState();
}

class SCProxyViewState extends State<SCProxyView> {
  /// ip controller
  TextEditingController ipController = TextEditingController();

  /// ip focusNode
  FocusNode ipNode = FocusNode();

  /// 端口controller
  TextEditingController portController = TextEditingController();

  /// 端口focusNode
  FocusNode portNode = FocusNode();

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
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              ipItem(),
              const SizedBox(
                height: 18.0,
              ),
              portItem(),
              const SizedBox(
                height: 30.0,
              ),
              saveBtnItem(context),
              const SizedBox(
                height: 18.0,
              ),
              tipItem(),
            ]),
      ),
    );
  }

  /// ip容器
  Widget ipItem() {
    return Container(
      height: 52.0,
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: SCColors.color_E3E3E5, width: 0.5)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: ipTextField(),
    );
  }

  /// ip textField
  Widget ipTextField() {
    return TextField(
      controller: ipController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: ipNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: "请输IP地址",
        hintStyle: TextStyle(fontSize: 16, color: SCColors.color_8D8E99),
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
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

  /// 端口容器
  Widget portItem() {
    return Container(
      height: 52.0,
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: SCColors.color_E3E3E5, width: 0.5)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: portTextField(),
    );
  }

  /// 端口textField
  Widget portTextField() {
    return TextField(
      controller: portController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: portNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: "请输入端口",
        hintStyle: TextStyle(fontSize: 16, color: SCColors.color_8D8E99),
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
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

  /// 保存按钮
  Widget saveBtnItem(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: SCColors.color_4285F4,
          borderRadius: BorderRadius.circular(8.0),
          child: const Text(
            '保存',
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_FFFFFF,
            ),
          ),
          onPressed: () {
            SCUtils().hideKeyboard(context: context);
            saveBtnClick();
          }),
    );
  }

  /// tipItem
  Widget tipItem() {
    String text = '';
    if (SCSpUtil.getKeys().contains(SCKey.kProxyMap)) {
      var map = SCSpUtil.getMap(SCKey.kProxyMap);
      text = '当前IP：${map['IP']}  当前端口：${map['port']}';
    }
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.w400,
        color: SCColors.color_BABABA,
      ),
    );
  }

  /// 保存按钮点击
  saveBtnClick() {
    if (ipController.text.removeAllWhitespace.isEmpty) {
      SCToast.showTip('请输入IP');
      return;
    }

    if (portController.text.removeAllWhitespace.isEmpty) {
      SCToast.showTip('请输入端口');
      return;
    }

    if (ipController.text.removeAllWhitespace.isNotEmpty &&
        portController.text.removeAllWhitespace.isNotEmpty) {
      Map<String, dynamic> map = {
        "IP": ipController.text.removeAllWhitespace,
        "port": portController.text.removeAllWhitespace
      };
      SCSpUtil.setMap(SCKey.kProxyMap, map);
      SCToast.showTip('保存成功，请重启APP');
    }
  }

  @override
  dispose() {
    super.dispose();
    ipNode.dispose();
    ipController.dispose();
    portNode.dispose();
    portController.dispose();
  }
}
