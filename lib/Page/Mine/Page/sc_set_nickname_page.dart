
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Constants/sc_asset.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Utils/sc_utils.dart';
import '../GetXController/sc_personal_info_controller.dart';

/// 设置昵称page

class SCSetNicknamePage extends StatefulWidget {
  @override
  SCSetNicknamePageState createState() => SCSetNicknamePageState();
}

class SCSetNicknamePageState extends State<SCSetNicknamePage> {

  /// 是否显示删除按钮
  bool isShowPhoneClear = false;

  /// 姓名controller
  TextEditingController nameController = TextEditingController();

  /// 姓名focusNode
  FocusNode nameNode = FocusNode();

  @override
  initState() {
    super.initState();
    nameController.addListener(nameControllerNotify);
    nameNode.addListener(focusChange);
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "设置昵称",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false,///页面不会随着键盘上移
        body: body());
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: (){
      SCUtils().hideKeyboard(context: context);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F5F5F5,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputItem(),
            const SizedBox(height: 8.0,),
            const Text(
              '不超过10个字符',
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_8D8E99
            ),),
          ],
        ),
      )
    );
  }

  /// 输入框
  Widget inputItem() {
    return Container(
      height: 52.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: nameTextField()),
          deleteIcon(),
          line(),
          const SizedBox(width: 12.0,),
          sureItem(),
        ],
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
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: "请输入昵称",
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
          nameController.clear();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      child: Container(
        width: 0.5,
        height: 28.0,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 确定按钮
  Widget sureItem() {
    return SizedBox(
      width: 48.0,
      height: 26.0,
      child: CupertinoButton(
          onPressed: () {
            if (nameController.text.isNotEmpty) {
              SCUtils().hideKeyboard(context: context);
              changNickname();
            } else {
              SCToast.showTip('昵称不能为空');
            }
          },
          padding: EdgeInsets.zero,
          color: SCColors.color_FF6C00,
          borderRadius: const BorderRadius.all(Radius.circular(13.0)),
          child: const Text(
            '保存',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_FFFFFF),
          ),
        ),
    );
  }

  /// 监听聚焦
  focusChange() {
    bool status = false;
    if (nameNode.hasFocus) {
      if (nameController.text.isEmpty) {
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

  /// 监听controller
  nameControllerNotify() {
    bool status = false;

    if (nameController.text.isEmpty) {
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

  /// 修改昵称
  changNickname() {
    var params = {
      "id": SCScaffoldManager.instance.user.id,
      "nickName": nameController.text,
    };
    SCPersonalInfoController state = Get.find<SCPersonalInfoController>();
    state.changeUserInfo(params: params, successHandler: () {
      Navigator.of(context).pop();
    });
  }

  @override
  dispose() {
    super.dispose();
    nameController.dispose();
  }

}