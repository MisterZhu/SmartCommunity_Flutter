import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_data_controller.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/utils/Router/sc_router_pages.dart';
import 'package:smartcommunity/utils/Router/sc_router_path.dart';
import 'package:smartcommunity/utils/Toast/sc_toast.dart';

import '../../GetXController/sc_select_house_search_status_controller.dart.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_community_listview
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/18 11:50
/// Description: 选择房号 - 列表
class SCSelectHouseListView extends StatefulWidget {
  SCSelectHouseLogicType? type = SCSelectHouseLogicType.login;
  final String? communityId;

  SCSelectHouseListView({Key? key, this.communityId, this.type})
      : super(key: key);

  @override
  State<SCSelectHouseListView> createState() =>
      _SCSelectHouseListViewState();
}

class _SCSelectHouseListViewState
    extends State<SCSelectHouseListView> {
  SCSelectHouseSearchStatusController searchStatusController =
  Get.put(SCSelectHouseSearchStatusController());
  SCSelectHouseSearchStatusController searchStatusState =
  Get.find<SCSelectHouseSearchStatusController>();

  SCSelectHouseDataController dataController =
  Get.put(SCSelectHouseDataController());
  SCSelectHouseDataController dataState =
  Get.find<SCSelectHouseDataController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SCSelectHouseSearchStatusController>(
        builder: (sCSelectHouseState) {
          return GetBuilder<SCSelectHouseDataController>(builder: (state) {
            return houseList();
          });
        });
  }

  Widget houseList() {
    if (searchStatusState.isShowCancel) {
      List<ScSelectHouseModel> searchResultList = dataState.searchResultList;
      if (searchResultList == null || searchResultList.length == 0) {
        return _emptyView();
      } else {
        return _gridView(dataState.searchResultList);
      }
    } else {
      List<ScSelectHouseModel> dataList = dataState.dataList;
      if (dataList == null || dataList.length == 0) {
        return _emptyView();
      } else {
        return _gridView(dataState.dataList);
      }
    }
  }

  Widget _emptyView() {
    return const SizedBox(
      height: 400,
      child: Center(child: Text('暂时没有数据哦~'),),
    );
  }

  /// gridView
  GridView _gridView(List<ScSelectHouseModel> dataList) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            childAspectRatio: 2.5,
            mainAxisSpacing: 12.0),
        scrollDirection: Axis.vertical,
        itemCount: dataList == null ? 0 : dataList.length,
        itemBuilder: (context, index) {
          bool? isChecked = dataList[index].isChecked;
          if (isChecked!) {
            // 选中
            return _hasChecked(false, index);
          } else {
            // 未选中
            return _hasNotChecked(false, index);
          }
        });
  }

  /// 选中状态
  /// isSearch true 搜索  false 不是
  /// index 下标
  Widget _hasChecked(bool isSearch, int index) {
    return GestureDetector(
      child: Container(
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
                ? '${dataState.searchResultList[index].name}'
                : '${dataState.dataList[index].name}'),
            style: _hasCheckedTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () {
        if (isSearch) {
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

          bool? haveChild = searchResultList[index].haveChild;
          if (haveChild!) {
            dataController.loadHouseInfo(
                communityId: widget.communityId!,
                currentId: (searchResultList[index].id).toString(),
                callback: () {
                  handlerNavigatorData((searchResultList[index].id).toString(), (searchResultList[index].name).toString());
                });
          } else {
            int? isAsset = searchResultList[index].isAsset;
            if (isAsset == 1) {
              bindHousePage((searchResultList[index].id).toString(),
                  (searchResultList[index].name).toString());
            } else {
              SCToast.showTip('当前不是资产，无法绑定~');
            }
          }
        } else {
          List<ScSelectHouseModel> houseCommunityList = dataState.dataList;
          for (int i = 0; i < houseCommunityList.length; i++) {
            if (i == index) {
              houseCommunityList[i].isChecked = true;
            } else {
              houseCommunityList[i].isChecked = false;
            }
          }
          dataController.updateDataList(list: houseCommunityList);

          bool? haveChild = houseCommunityList[index].haveChild;
          if (haveChild!) {
            dataController.loadHouseInfo(
                communityId: widget.communityId!,
                currentId: (houseCommunityList[index].id).toString(),
                callback: () {
                  handlerNavigatorData((houseCommunityList[index].id).toString(), (houseCommunityList[index].name).toString());
                });
          } else {
            // isAsset 是否可以是资产 0 否 1 是
            int? isAsset = houseCommunityList[index].isAsset;
            if (isAsset == 1) {
              bindHousePage((houseCommunityList[index].id).toString(),
                  (houseCommunityList[index].name).toString());
            } else {
              SCToast.showTip('当前不是资产，无法绑定~');
            }
          }
        }
      },
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
            breakWord(isSearch
                ? '${dataState.searchResultList[index].name}'
                : '${dataState.dataList[index].name}'),
            style: _hasNotCheckedTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () {
        if (isSearch) {
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

          bool? haveChild = searchResultList[index].haveChild;
          if (haveChild!) {
            dataController.loadHouseInfo(
                communityId: widget.communityId!,
                currentId: (searchResultList[index].id).toString(),
                callback: () {
                  handlerNavigatorData((searchResultList[index].id).toString(), (searchResultList[index].name).toString());
                });
          } else {
            int? isAsset = searchResultList[index].isAsset;
            if (isAsset == 1) {
              bindHousePage((searchResultList[index].id).toString(),
                  (searchResultList[index].name).toString());
            } else {
              SCToast.showTip('当前不是资产，无法绑定~');
            }
          }
        } else {
          List<ScSelectHouseModel> houseCommunityList = dataState.dataList;
          for (int i = 0; i < houseCommunityList.length; i++) {
            if (i == index) {
              houseCommunityList[i].isChecked = true;
            } else {
              houseCommunityList[i].isChecked = false;
            }
          }
          dataController.updateDataList(list: houseCommunityList);

          bool? haveChild = houseCommunityList[index].haveChild;
          if (haveChild!) {
            dataController.loadHouseInfo(
                communityId: widget.communityId!,
                currentId: (houseCommunityList[index].id).toString(),
                callback: () {
                  handlerNavigatorData((houseCommunityList[index].id).toString(), (houseCommunityList[index].name).toString());
                });
          } else {
            // isAsset 是否可以是资产 0 否 1 是
            int? isAsset = houseCommunityList[index].isAsset;
            if (isAsset == 1) {
              bindHousePage((houseCommunityList[index].id).toString(),
                  (houseCommunityList[index].name).toString());
            } else {
              SCToast.showTip('当前不是资产，无法绑定~');
            }
          }
        }
      },
    );
  }

  /// 处理顶部导航栏数据
  handlerNavigatorData(String currentId, String currentName) {
    ScSelectHouseModel scSelectHouseModel = ScSelectHouseModel(
        communityId: currentId, id: int.parse(currentId), name: currentName);

    SCSelectHouseDataController scSelectHouseDataController =
    Get.put(SCSelectHouseDataController());
    List<ScSelectHouseModel> navigatorList =
        scSelectHouseDataController.navigatorList;
    navigatorList.removeAt(navigatorList.length - 1);
    navigatorList.add(scSelectHouseModel);

    ScSelectHouseModel scSelectHouseModelTemp =
    ScSelectHouseModel(id: 0, name: "请选择");
    navigatorList.add(scSelectHouseModelTemp);
    scSelectHouseDataController.updateNavigatorList(list: navigatorList);
  }

  /// 绑定房号
  void bindHousePage(String houseId, String currentRoomName) {
    /// 从缓存中去取数据
    /// 第一个数据是园区
    SCSelectHouseDataController scSelectHouseDataController =
    Get.find<SCSelectHouseDataController>();
    List<ScSelectHouseModel> navigatorList =
        scSelectHouseDataController.navigatorList;
    String houseName = '';

    for (int i = 1; i < navigatorList.length - 1; i++) {
      String? name = navigatorList[i].name;
      houseName = houseName + name!;
    }
    houseName = houseName + currentRoomName;

    List valueList = ['${navigatorList[0].name}', houseName, '', ''];

    print('bindHouse---> ${widget.type}');
    if (widget.type == SCSelectHouseLogicType.login) {
      var params = {
        'communityId': '${navigatorList[0].communityId}',
        'houseId': houseId,
        'valueList': valueList,
        'type': widget.type
      };
      SCRouterHelper.pathPage(SCRouterPath.addHousePagePath, params);
    } else if (widget.type == SCSelectHouseLogicType.addHouse) {
      var params = {
        'houseId': houseId,
        'houseName': houseName,
      };
      SCRouterHelper.back(params);
    }
  }

  /// 选中字体颜色
  TextStyle _hasCheckedTextStyle() {
    return const TextStyle(
      fontSize: SCFonts.f16,
      fontWeight: FontWeight.bold,
      color: SCColors.color_FF6C00,
    );
  }

  /// 未选中字体颜色
  TextStyle _hasNotCheckedTextStyle() {
    return const TextStyle(
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
