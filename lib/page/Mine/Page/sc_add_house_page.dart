import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';
import '../../../utils/sc_utils.dart';
import '../GetXController/sc_add_house_controller.dart';

/// 切换房屋-page

class SCAddHousePage extends StatefulWidget {
  @override
  SCAddHouseState createState() => SCAddHouseState();
}

class SCAddHouseState extends State<SCAddHousePage> {
  SCAddHouseController state = Get.put(SCAddHouseController());

  List nameList = ['所居住小区', '房号', '家庭/企业', '身份'];
  List valueList = ['慧享生活馆', '绿城科技园1幢1单元101室', '', ''];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleItem(),
        backgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
      ),
      body: body(),
    );
  }

  /// title
  Widget titleItem() {
    return const Text('新增小区地址', style: TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33
    ),);
  }

  /// body
  Widget body() {
    return Container(
        color: SCColors.color_F2F3F5,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTipsItem(),
              Expanded(child: listView()),
              const SizedBox(height: 20.0,),
              bottomTipsItem(),
              bottomBtnItem(),
              Container(
                color: SCColors.color_FFFFFF,
                height: SCUtils().getBottomSafeArea(),
              ),
            ]
        )
    );
  }

  Widget topTipsItem() {
    return Container(
      color: SCColors.color_FFF7D4,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: const Text(
        '请选择正确的小区地址，您可安全、便捷地使用快递代收和各类生活服务',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_1B1C33),
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
        itemBuilder: (BuildContext context, int index) {
          return cellItem(nameList[index], valueList[index], index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 0.5,);
        },
        itemCount: nameList.length);
  }

  Widget cellItem(String name, String value, int index) {
    return GestureDetector(
        onTap: () {
          if (index == 0) {
            /// 选择小区
            log('点击选择小区');
          } else if (index == 1) {
            /// 选择房号
            log('点击选择房号');
          } else if (index == 2) {
            /// 选择家庭/企业
            log('点击选择家庭');
          } else if (index == 3) {
            /// 选择身份
            log('点击选择身份');
          }
        },
        child:Container(
            height: 48,
            color: SCColors.color_FFFFFF,
            padding: const EdgeInsets.symmetric(horizontal: 16.0,),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1C33),
                ),
                const SizedBox(width: 20.0,),
                Expanded(child: Container(
                  color: SCColors.color_FFFFFF,
                  child: Text(
                    value == '' ? '请选择' : value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: SCFonts.f14,
                        fontWeight: FontWeight.w400,
                        color: value == '' ? SCColors.color_B0B1B8 : SCColors.color_5E5E66),
                  ),
                ),
                ),
                Image.asset(SCAsset.iconAddHouseArrow, width: 16.0, height: 16.0,),
              ],
            )
        )
    );
  }

  Widget bottomTipsItem() {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(SCAsset.iconAddHouseTips, width: 12.0, height: 12.0,),
            const SizedBox(width: 6,),
            const Text(
              '提交小区地址后，我们会在一个工作日内核实您的申请',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: SCFonts.f12,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_8D8E99),
            )
          ]
      ),
    );
  }

  /// 底部提交按钮
  Widget bottomBtnItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      width: double.infinity,
      height: 54.0 ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
              color: SCColors.color_FF6C00,
              borderRadius: BorderRadius.circular(4.0)),
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text(
                '确认提交',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_FFFFFF,
                ),
              ),
              onPressed: () {

              }),
        ),
      ),
    );
  }

}