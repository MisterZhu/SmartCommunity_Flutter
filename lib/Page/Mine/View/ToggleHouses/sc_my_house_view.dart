
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:smartcommunity/Page/Mine/View/ToggleHouses/sc_my_house_item.dart';

import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_colors.dart';
import '../../GetXController/sc_my_house_controller.dart';
import '../../Model/sc_my_house_model.dart';

/// 我的房号页面
class SCMyHouseView extends StatelessWidget {

  /// 切换房号
  Function(SCMyHouseModel model)? changeHouseAction;
  /// 新增房号
  Function? addHouseAction;

  SCMyHouseView({Key? key, this.changeHouseAction, this.addHouseAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      children: [
        Expanded(child: myHouseListView()),
        myRoomNumberBottomItem()
      ],
    );
  }

  /// 我的房号listView
  Widget myHouseListView() {
    return GetBuilder<SCMyHouseController>(builder: (state) {
      return ListView.separated(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
          itemBuilder: (BuildContext context, int index) {
            SCMyHouseModel model = state.dataList[index];
            return SCMyHouseItem(model: model,changeAction: () {
              if (changeHouseAction != null) {
                changeHouseAction?.call(model);
              }
            },);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 0.5,);
          },
          itemCount: state.dataList.length);
    });
  }

  /// 底部新增房号按钮
  Widget myRoomNumberBottomItem() {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(SCAsset.iconMineHouseAdd, width: 14.0, height: 14.0,),
                  const SizedBox(width: 10.0,),
                  const Text(
                    '新增房号',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: SCColors.color_FFFFFF,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                if (addHouseAction != null) {
                  addHouseAction?.call();
                }
              }),
        ),
      ),
    );
  }

}