import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_building_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_building_search_status_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_room_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_room_search_status_controller.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_building_model.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_room_model.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_room_listview
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/22 10:02
/// Description: 选择房号 - 房号 列表
class SCSelectHouseRoomListView extends StatefulWidget {
  const SCSelectHouseRoomListView({Key? key}) : super(key: key);

  @override
  State<SCSelectHouseRoomListView> createState() =>
      _SCSelectHouseRoomListViewState();
}

class _SCSelectHouseRoomListViewState
    extends State<SCSelectHouseRoomListView> {
  SCSelectHouseRoomSearchStatusController scSearchStatusController =
      Get.put(SCSelectHouseRoomSearchStatusController());
  SCSelectHouseRoomSearchStatusController scSearchStatusState =
      Get.find<SCSelectHouseRoomSearchStatusController>();

  SCSelectHouseRoomController scSelectHouseRoomController =
      Get.put(SCSelectHouseRoomController());
  SCSelectHouseRoomController sCSelectHouseRoomState =
      Get.find<SCSelectHouseRoomController>();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SCSelectHouseRoomSearchStatusController>(
        builder: (sCSelectHouseState) {
      return GetBuilder<SCSelectHouseRoomController>(builder: (state) {
        return houseList();
      });
    });
  }

  Widget houseList() {
    if (scSearchStatusController.isShowCancel) {
      return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              childAspectRatio: 2.5,
              mainAxisSpacing: 12.0),
          scrollDirection: Axis.vertical,
          itemCount: scSelectHouseRoomController.searchResultList == null
              ? 0
              : scSelectHouseRoomController.searchResultList.length,
          itemBuilder: (context, index) {
            bool? isChecked = scSelectHouseRoomController
                .searchResultList[index].isChecked;
            if (isChecked!) {
              // 选中
              return _hasChecked(true, index);
            } else {
              // 未选中
              return _hasNotChecked(true, index);
            }
          });
    } else {
      return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              childAspectRatio: 2.5,
              mainAxisSpacing: 12.0),
          scrollDirection: Axis.vertical,
          itemCount: scSelectHouseRoomController.houseCommunityList == null
              ? 0
              : scSelectHouseRoomController.houseCommunityList.length,
          itemBuilder: (context, index) {
            bool? isChecked = scSelectHouseRoomController
                .houseCommunityList[index].isChecked;
            if (isChecked!) {
              // 选中
              return _hasChecked(false, index);
            } else {
              // 未选中
              return _hasNotChecked(false, index);
            }
          });
    }
  }

  /// 选中状态
  /// isSearch true 搜索  false 不是
  /// index 下表
  Widget _hasChecked(bool isSearch, int index) {
    return Container(
      padding: EdgeInsets.only(left: 14.0, right: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8.0),
        color: SCColors.color_FFF0E6,
        //设置四周边框
        border: new Border.all(width: 1, color: SCColors.color_FF6C00),
      ),
      child: Center(
        child: Text(
          breakWord(isSearch
              ? '${sCSelectHouseRoomState.searchResultList[index].name}'
              : '${sCSelectHouseRoomState.houseCommunityList[index].name}'),
          style: _hasCheckedTextStyle(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  /// 未选中状态
  Widget _hasNotChecked(bool isSearch, int index) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 14.0, right: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8.0),
          color: SCColors.color_F7F8FA,
        ),
        // child: Text('${state.houseCommunityList[index].name}'),
        child: Center(
          child: Text(
            breakWord(isSearch
                ? '${sCSelectHouseRoomState.searchResultList[index].name}'
                : '${sCSelectHouseRoomState.houseCommunityList[index].name}'),
            style: _hasNotCheckedTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () {
        if (isSearch) {
          List<DemoSCHouseRoomModel> searchResultList =
              sCSelectHouseRoomState.searchResultList;
          for (int i = 0; i < searchResultList.length; i++) {
            if (i == index) {
              searchResultList[i].isChecked = true;
            } else {
              searchResultList[i].isChecked = false;
            }
          }
          sCSelectHouseRoomState.updateSearchList(list: searchResultList);

          // todo 跳转下一步

        } else {
          List<DemoSCHouseRoomModel> houseCommunityList =
              sCSelectHouseRoomState.houseCommunityList;
          for (int i = 0; i < houseCommunityList.length; i++) {
            if (i == index) {
              houseCommunityList[i].isChecked = true;
            } else {
              houseCommunityList[i].isChecked = false;
            }
          }
          sCSelectHouseRoomState.updateRoomList(
              list: houseCommunityList);

         // todo 跳转下一步
        }
      },
    );
  }

  /// 选中字体颜色
  TextStyle _hasCheckedTextStyle() {
    return TextStyle(
      fontSize: SCFonts.f16,
      fontWeight: FontWeight.bold,
      color: SCColors.color_FF6C00,
    );
  }

  /// 未选中字体颜色
  TextStyle _hasNotCheckedTextStyle() {
    return TextStyle(
      fontSize: SCFonts.f16,
      fontWeight: FontWeight.bold,
      color: SCColors.color_1B1C33,
    );
  }

  /// 当文字超限时 用……显示(两行的时候不对齐 需要优化)
  static String breakWord(String text) {
    if (text.isEmpty) {
      return text;
    }
    String breakWord = ' ';
    text.runes.forEach((element) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    });
    return breakWord;
  }
}
