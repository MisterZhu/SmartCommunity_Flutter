
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/View/ToggleHouses/sc_current_house_info_item.dart';
import 'package:smartcommunity/Page/Mine/View/ToggleHouses/sc_current_house_review_item.dart';
import '../../../../Skin/Model/sc_user.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../GetXController/sc_current_house_controller.dart';

/// 当前房屋页面
class SCCurrentHouseView extends StatelessWidget {

  Function? unbindHouse;

  SCCurrentHouseView({Key? key, this.unbindHouse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    SCUser scUser = SCScaffoldManager.instance.user;
    String? housingId = scUser.housingId;
    if (housingId != null && housingId != '') {
      return Column(
        children: [
          Expanded(child: currentHouseListView()),
          currentHouseBottomItem()
        ],
      );
    } else {
      return Container();
    }
  }

  /// 当前房屋listView
  Widget currentHouseListView() {
    return GetBuilder<SCCurrentHouseController>(builder: (state) {
      if (state.hadData) {
        return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SCCurrentHouseInfoItem(infoModel: state.infoModel);
              } else {
                return SCCurrentHouseReviewItem(reviewList: state.selectReviewIndex == 0 ? state.infoModel.adoptMembers : state.infoModel.underReviewMembers);
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: 2);
      } else {
        return Container();
      }
    });
  }

  /// 当前房屋底部解除绑定按钮
  Widget currentHouseBottomItem() {
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
                '解除绑定',
                style: TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_FFFFFF,
                ),
              ),
              onPressed: () {
                if (unbindHouse != null) {
                  unbindHouse?.call();
                }
              }),
        ),
      ),
    );
  }

}