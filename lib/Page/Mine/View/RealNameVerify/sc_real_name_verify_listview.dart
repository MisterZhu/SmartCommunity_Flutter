
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/Page/Mine/View/RealNameVerify/sc_real_name_photo_item.dart';
import 'package:smartcommunity/Page/Mine/View/RealNameVerify/sc_real_name_verify_textfield.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../GetXController/sc_real_name_verify_controller.dart';

/// 实名认证listview

class SCRealNameVerifyListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listView(),
        bottomButtonItem(),
      ],
    );
  }

  /// body
  Widget listView() {
    return Expanded(child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const SizedBox(height: 8.0,);
          } else {
            return const SizedBox(height: 16.0,);
          }
        },
        itemCount: 3));
  }

  /// 获取cell
  Widget getCell(int index) {
    if (index == 0) {
      return SCRealNamePhotoItem(
        tapPhotoAction: (index){

        }, deletePhotoAction: (index){

        },);
    } else if (index == 1) {
      return explainItem();
    } else if (index == 2) {
      return SCRealNameVerifyTextField();
    } else {
      return Container();
    }
  }

  /// 说明
  Widget explainItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textItem('说明: 1.身份证影像信息，仅做银行个人信息校验，不用它途；'),
        const SizedBox(height: 4.0,),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: textItem('2.支持jpg、png、jpeg、bmp格式的照片。'),
        )
      ],
    );
  }

  Widget textItem(String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: SCFonts.f12,
        fontWeight: FontWeight.w400,
        color: SCColors.color_8D8E99,
      ),);
  }

  /// 底部按钮
  Widget bottomButtonItem() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: SCUtils().getBottomSafeArea() + 10.0),
      child: SizedBox(
        width: double.infinity,
        height: 48.0,
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            color: SCColors.color_FF6C00,
            borderRadius: BorderRadius.circular(8.0),
            child: const Text(
              '去认证',
              style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w500,
                color: SCColors.color_FFFFFF,
              ),
            ),
            onPressed: () {
              SCRealNameVerifyController state = Get.find<SCRealNameVerifyController>();
              bool nameStatus = SCUtils().checkName(name: state.name, isShowTip: true);
              if (!nameStatus) {
                return;
              }
              bool idcardStatus = SCUtils().checkIDCard(idNumber: state.number, isShowTip: true);
              if (!idcardStatus) {
                return;
              }
            }),
      ),
    );
  }
}