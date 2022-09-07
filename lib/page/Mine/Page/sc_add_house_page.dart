import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/network/sc_http_manager.dart';
import 'package:smartcommunity/network/sc_url.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/sc_user_identity.dart';
import 'package:smartcommunity/skin/Model/sc_user.dart';
import 'package:smartcommunity/skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/utils/Loading/sc_loading_utils.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/utils/Toast/sc_toast.dart';
import 'package:smartcommunity/widgets/Dialog/sc_base_dialog.dart';
import 'package:smartcommunity/widgets/Dialog/sc_bottom_sheet_model.dart';
import 'package:smartcommunity/widgets/Dialog/sc_dialog_utils.dart';

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

  // List nameList = ['所居住小区', '房号', '家庭/企业', '身份'];
  List nameList = ['所居住小区', '房号', '身份'];
  List valueList = [];
  String communityId = '';
  String houseId = '';
  String identityId = '';

  bool isFromLogin = false;

  @override
  initState() {
    super.initState();

    var params = Get.arguments;
    valueList = params['valueList'];
    communityId = params['communityId'];
    houseId = params['houseId'];
    isFromLogin = params['isFromLogin'];

    print('print--> valueList: ${valueList}');
    print('print--> communityId: ${communityId}');
    print('print--> houseId: ${houseId}');
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
    return const Text(
      '新增小区地址',
      style: TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.bold,
          color: SCColors.color_1B1C33),
    );
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
              const SizedBox(
                height: 20.0,
              ),
              bottomTipsItem(),
              bottomBtnItem(),
              Container(
                color: SCColors.color_FFFFFF,
                height: SCUtils().getBottomSafeArea(),
              ),
            ]));
  }

  /// 顶部提示item
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

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
        itemBuilder: (BuildContext context, int index) {
          return cellItem(nameList[index], valueList[index], index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 0.5,
          );
        },
        itemCount: nameList.length);
  }

  /// cell
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
            /// 选择身份
            log('点击选择身份');
            loadResidentUserIdentity();
          }
        },
        child: Container(
            height: 48,
            color: SCColors.color_FFFFFF,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
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
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Container(
                    color: SCColors.color_FFFFFF,
                    child: Text(
                      value == '' ? '请选择' : value,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: SCFonts.f14,
                          fontWeight: FontWeight.w400,
                          color: value == ''
                              ? SCColors.color_B0B1B8
                              : SCColors.color_5E5E66),
                    ),
                  ),
                ),
                Image.asset(
                  SCAsset.iconAddHouseArrow,
                  width: 16.0,
                  height: 16.0,
                ),
              ],
            )));
  }

  /// 底部提示item
  Widget bottomTipsItem() {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              SCAsset.iconAddHouseTips,
              width: 12.0,
              height: 12.0,
            ),
            const SizedBox(
              width: 6,
            ),
            const Text(
              '提交小区地址后，我们会在一个工作日内核实您的申请',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: SCFonts.f12,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_8D8E99),
            )
          ]),
    );
  }

  /// 底部提交按钮
  Widget bottomBtnItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      width: double.infinity,
      height: 54.0,
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
                if (identityId == '') {
                  SCToast.showTip('请选择身份');
                  return;
                }
                showConfirmDialog();
              }),
        ),
      ),
    );
  }

  /// 加载用户身份列表
  loadResidentUserIdentity() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kResidentUserIdentity,
        params: {
          'communityId': communityId,
        },
        success: (value) {
          List<ScUserIdentity> dataList = List<ScUserIdentity>.from(
              value.map((e) => ScUserIdentity.fromJson(e)).toList());

          if (dataList == null || dataList.length == 0) {
            SCToast.showTip('身份信息为空');
            return;
          }

          showIdentityDialog(dataList);
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
        });
  }

  /// 身份底部弹窗
  showIdentityDialog(List<ScUserIdentity> identityList) {
    List<SCBottomSheetModel> dataList = [];
    for (int i = 0; i < identityList.length; i++) {
      SCBottomSheetModel scBottomSheetModel = SCBottomSheetModel(
          title: identityList[i].identity,
          color: SCColors.color_1B1C33,
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400);
      dataList.add(scBottomSheetModel);
    }
    SCDialogUtils.instance.showBottomDialog(
        context: context,
        dataList: dataList,
        isShowCancel: true,
        onTap: (index, context) {
          valueList[2] = identityList[index].identity!;
          identityId = identityList[index].identityId!;
          setState(() {});
        });
  }

  /// 确认弹窗
  showConfirmDialog() {
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      title: '确认提交',
      content: '确认绑定当前房号吗？',
      customWidgetButtons: [
        defaultCustomButton(context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        TextButton(
            onPressed: () {
              commit();
            },
            child: Text('确定',
                style: TextStyle(
                    color: SCColors.color_FF6C00, fontSize: SCFonts.f16)))
      ],
    );
  }

  /// 提交
  commit() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kBindAsset,
        params: {
          'communityId': communityId,
          'identityId': identityId,
          'spaceId': houseId
        },
        success: (value) {
          /// 1.toast 提示成功
          SCToast.showTip('提交成功 我们会尽快为您审核');

          /// 2.存储数据到SCUser
          SCUser scUser = SCScaffoldManager.instance.getUserData();
          scUser.housingId = houseId;
          SCScaffoldManager.instance.cacheUserData(scUser);

          /// 3.栈
          if (isFromLogin) {
            // 如果是从登录进入，就直接进入主页
            SCRouterHelper.codeOffAllPage(10000, null);
          } else {
            // todo
          }
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
        });
  }
}
