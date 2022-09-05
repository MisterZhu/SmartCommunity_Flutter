import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/network/sc_http_manager.dart';
import 'package:smartcommunity/network/sc_url.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_data_controller.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/utils/Toast/sc_toast.dart';

import '../../../GetXController/sc_select_house_search_status_controller.dart.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_community_listview
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/18 11:50
/// Description: 选择房号 - 列表
class SCSelectHouseBlockListView extends StatefulWidget {
  const SCSelectHouseBlockListView({Key? key}) : super(key: key);

  @override
  State<SCSelectHouseBlockListView> createState() =>
      _SCSelectHouseBlockListViewState();
}

class _SCSelectHouseBlockListViewState
    extends State<SCSelectHouseBlockListView> {
  SCSelectHouseSearchStatusController searchStatusController = Get.put(SCSelectHouseSearchStatusController());
  SCSelectHouseSearchStatusController searchStatusState = Get.find<SCSelectHouseSearchStatusController>();

  SCSelectHouseDataController dataController = Get.put(SCSelectHouseDataController());
  SCSelectHouseDataController dataState = Get.find<SCSelectHouseDataController>();

  SCSelectHouseController selectHouseController = Get.put(SCSelectHouseController());

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SCSelectHouseSearchStatusController>(builder: (sCSelectHouseState) {
      return GetBuilder<SCSelectHouseDataController>(builder: (state) {
        return houseList();
      });
    });
  }

  Widget houseList() {
    if (searchStatusState.isShowCancel) {
      return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              childAspectRatio: 2.5,
              mainAxisSpacing: 12.0),
          scrollDirection: Axis.vertical,
          itemCount: dataState.searchResultList == null
              ? 0
              : dataState.searchResultList.length,
          itemBuilder: (context, index) {
            bool? isChecked =
                dataState.searchResultList[index].isChecked;
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
          itemCount: dataState.dataList == null
              ? 0
              : dataState.dataList.length,

          itemBuilder: (context, index) {
            bool? isChecked = dataState.dataList[index].isChecked;
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
  /// index 下标
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
          breakWord(isSearch ? '${dataState.searchResultList[index].name}' : '${dataState.dataList[index].name}'),
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
        child: Center(
          child: Text(
            breakWord(isSearch ? '${dataState.searchResultList[index].name}' : '${dataState.dataList[index].name}'),
            style: _hasNotCheckedTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () {
        if(isSearch){
          List<ScSelectHouseModel> searchResultList =
              dataState.searchResultList;
          for (int i = 0; i < searchResultList.length; i++) {
            if (i == index) {
              searchResultList[i].isChecked = true;
            } else {
              searchResultList[i].isChecked = false;
            }
          }
          dataController.updateSearchList(list: searchResultList);

          // todo
          bool? haveChild = searchResultList[index].haveChild;
          if(haveChild!) {
            loadData((searchResultList[index].id).toString());
          } else {
            SCToast.showTip('没有下一级');
          }
        } else{
          List<ScSelectHouseModel> houseCommunityList =
              dataState.dataList;
          for (int i = 0; i < houseCommunityList.length; i++) {
            if (i == index) {
              houseCommunityList[i].isChecked = true;
            } else {
              houseCommunityList[i].isChecked = false;
            }
          }
          dataController.updateDataList(list: houseCommunityList);

          // todo

          bool? haveChild = houseCommunityList[index].haveChild;
          if(haveChild!) {
            loadData((houseCommunityList[index].id).toString());
          } else {
            SCToast.showTip('没有下一级');
          }
        }
      },
    );
  }


  void loadData(String currentId) {
    SCHttpManager.instance.get(
        url: SCUrl.kGetSpaceNodesUrl,
        params: {'communityId': selectHouseController.communityId, 'currentId': currentId},
        success: (value) {
          List<ScSelectHouseModel> dataList =
          List<ScSelectHouseModel>.from(value
              .map((e) => ScSelectHouseModel.fromJson(e))
              .toList());
          print('print--> 获取苑数据===$dataList');

          dataController.updateDataList(
              list: dataList == null ? [] : dataList);
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          dataController.updateDataList(list: []);
        });
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
