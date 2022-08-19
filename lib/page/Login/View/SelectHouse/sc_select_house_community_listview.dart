import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

import '../../GetXController/sc_select_house_controller.dart';
import '../../Model/demo_sc_house_community_model.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_community_listview
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/18 11:50
/// Description: 选择房号 - 苑 列表
class SCSelectHouseCommunityListView extends StatefulWidget {
  const SCSelectHouseCommunityListView({Key? key}) : super(key: key);

  @override
  State<SCSelectHouseCommunityListView> createState() =>
      _SCSelectHouseCommunityListViewState();
}

class _SCSelectHouseCommunityListViewState
    extends State<SCSelectHouseCommunityListView> {
  /// 苑级别的list
  SCSelectHouseController scSelectHouseController =
      Get.put(SCSelectHouseController());
  SCSelectHouseController state = Get.find<SCSelectHouseController>();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SCSelectHouseController>(builder: (state) {
      return houseList();
    });
  }

  Widget houseList() {
    if (state.isShowCancel) {
      // log('加载数据--> ${state.searchResultList}');
      print('加载搜索数据--> ${state.searchResultList}');
      return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              childAspectRatio: 2.5,
              mainAxisSpacing: 12.0),
          scrollDirection: Axis.vertical,
          itemCount:
          state.searchResultList == null ? 0 : state.searchResultList.length,
          itemBuilder: (context, index) {
            bool? isChecked = state.searchResultList[index].isChecked;
            if (isChecked!) {
              // 选中
              return _hasChecked(index);
            } else {
              // 未选中
              return _hasNotChecked(index);
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
          itemCount: state.houseCommunityList == null
              ? 0
              : state.houseCommunityList.length,
          itemBuilder: (context, index) {
            bool? isChecked = state.houseCommunityList[index].isChecked;
            if (isChecked!) {
              // 选中
              return _hasChecked(index);
            } else {
              // 未选中
              return _hasNotChecked(index);
            }
          });
    }
  }


  /// 选中状态
  Widget _hasChecked(int index) {
    return Container(
      padding: EdgeInsets.only(left: 14.0, right: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8.0),
        color: SCColors.color_FFF0E6,
        //设置四周边框
        border: new Border.all(width: 1, color: SCColors.color_FF6C00),
      ),
      // child: Text('${state.houseCommunityList[index].name}'),
      child: Center(
        child: Text(
          breakWord('${state.houseCommunityList[index].name}'),
          style: _hasCheckedTextStyle(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  /// 未选中状态
  Widget _hasNotChecked(int index) {
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
            breakWord('${state.houseCommunityList[index].name}'),
            style: _hasNotCheckedTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () {
        List<DemoSCHouseCommunityModel> houseCommunityList =
            state.houseCommunityList;
        for (int i = 0; i < houseCommunityList.length; i++) {
          if (i == index) {
            houseCommunityList[i].isChecked = true;
          } else {
            houseCommunityList[i].isChecked = false;
          }
        }
        scSelectHouseController.updateHouseCommunityList(houseCommunityList);
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
