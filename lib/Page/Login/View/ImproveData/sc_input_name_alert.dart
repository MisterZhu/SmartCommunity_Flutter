
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Utils/sc_utils.dart';

/// 输入姓名弹窗

class SCInputNameAlert extends StatefulWidget {

  SCInputNameAlert({
    Key? key,
    this.sureAction,
  }) : super(key: key);

  /// 点击确定按钮
  final Function(String name)? sureAction;

  @override
  SCInputNameAlertState createState() => SCInputNameAlertState();
}

class SCInputNameAlertState extends State<SCInputNameAlert> {

  /// 姓名controller
  TextEditingController nameController = TextEditingController();

  /// 姓名focusNode
  FocusNode nameNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Center(
      child: Container(
        width: 300.0,
        height: 326.0,
        decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            bgItem(),
            Expanded(child: bottomItem()),
          ],
        )
      ),
    );
  }

  /// 背景图
  Widget bgItem() {
    return Container(
      width: 300.0,
      height: 120.0,
      decoration: const BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),),
      alignment: Alignment.center,
      child: Image.asset(
        SCAsset.iconVerifyNameBg,
        width: 130.0,
        height: 115.0,
        fit: BoxFit.cover,
      ),
    );
  }

  /// bottomItem
  Widget bottomItem() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 14.0,),
          const Text(
            '请填写您的真实姓名',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33),
          ),
          const SizedBox(height: 4.0,),
          const Text(
            '姓名验证成功可体验更多优质服务',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66),
          ),
          inputItem(),
          line(),
          sureItem(),
        ]
    );
  }

  /// 输入框
  Widget inputItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Container(
        decoration: BoxDecoration(
            color: SCColors.color_F7F8FA,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: SCColors.color_E3E3E5, width: 0.5)
        ),
        child: nameTextField(),
      ),
    );
  }

  /// 姓名textField
  Widget nameTextField() {
    return TextField(
      controller: nameController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: nameNode,
      textAlign: TextAlign.left,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
        hintText: "请输入姓名",
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

      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 确定按钮
  Widget sureItem() {
    return Container(
      height: 64.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        height: 44.0,
        child: CupertinoButton(
          onPressed: () {
            if (nameController.text.isNotEmpty) {
              SCUtils().hideKeyboard(context: context);
              widget.sureAction?.call(nameController.text);
            } else {
              SCToast.showTip('姓名不能为空');
            }
          },
          padding: EdgeInsets.zero,
          color: SCColors.color_FF6C00,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          child: const Text(
            '确定',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_FFFFFF),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
    nameController.dispose();
  }

}
