import 'package:flutter/material.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_select_house_data_controller.dart';
import 'package:smartcommunity/Page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../GetXController/sc_select_house_search_status_controller.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_community_listview
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/18 11:50
/// Description: 选择房号 - 列表

class SCSelectHouseListView extends StatefulWidget {
  SCSelectHouseLogicType? type = SCSelectHouseLogicType.login;
  final String? communityId;

  final SCSelectHouseSearchStatusController searchState;
  final SCSelectHouseDataController selectState;

  SCSelectHouseListView({Key? key,
    required this.selectState,
    required this.searchState,
    this.communityId,
    this.type,
  }) : super(key: key);

  @override
  State<SCSelectHouseListView> createState() => _SCSelectHouseListViewState();
}

class _SCSelectHouseListViewState extends State<SCSelectHouseListView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchState.isShowCancel) {
      List<ScSelectHouseModel> searchResultList = widget.selectState.searchResultList;
      if (searchResultList == null || searchResultList.length == 0) {
        return _emptyView();
      } else {
        return _gridView(widget.selectState.searchResultList);
      }
    } else {
      List<ScSelectHouseModel> dataList = widget.selectState.dataList;
      if (dataList == null || dataList.length == 0) {
        return _emptyView();
      } else {
        return _gridView(widget.selectState.dataList);
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
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8.0),
          color: SCColors.color_FFF0E6,
          //设置四周边框
          border: Border.all(width: 1, color: SCColors.color_FF6C00),
        ),
        child: Center(
          child: Text(
            breakWord(isSearch
                ? '${widget.selectState.searchResultList[index].name}'
                : '${widget.selectState.dataList[index].name}'),
            style: _hasCheckedTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () {
        if (isSearch) {
          List<ScSelectHouseModel> searchResultList = widget.selectState.searchResultList;
          for (int i = 0; i < searchResultList.length; i++) {
            if (i == index) {
              searchResultList[i].isChecked = true;
            } else {
              searchResultList[i].isChecked = false;
            }
          }
          widget.selectState.updateSearchList(list: searchResultList);

          bool? haveChild = searchResultList[index].haveChild;
          if (haveChild!) {
            widget.selectState.loadHouseInfo(
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
          List<ScSelectHouseModel> houseCommunityList = widget.selectState.dataList;
          for (int i = 0; i < houseCommunityList.length; i++) {
            if (i == index) {
              houseCommunityList[i].isChecked = true;
            } else {
              houseCommunityList[i].isChecked = false;
            }
          }
          widget.selectState.updateDataList(list: houseCommunityList);

          bool? haveChild = houseCommunityList[index].haveChild;
          if (haveChild!) {
            widget.selectState.loadHouseInfo(
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
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8.0),
          color: SCColors.color_F7F8FA,
        ),
        child: Center(
          child: Text(
            breakWord(isSearch
                ? '${widget.selectState.searchResultList[index].name}'
                : '${widget.selectState.dataList[index].name}'),
            style: _hasNotCheckedTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () {
        if (isSearch) {
          List<ScSelectHouseModel> searchResultList = widget.selectState.searchResultList;
          for (int i = 0; i < searchResultList.length; i++) {
            if (i == index) {
              searchResultList[i].isChecked = true;
            } else {
              searchResultList[i].isChecked = false;
            }
          }
          widget.selectState.updateSearchList(list: searchResultList);

          bool? haveChild = searchResultList[index].haveChild;
          if (haveChild!) {
            widget.selectState.loadHouseInfo(
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
          List<ScSelectHouseModel> houseCommunityList = widget.selectState.dataList;
          for (int i = 0; i < houseCommunityList.length; i++) {
            if (i == index) {
              houseCommunityList[i].isChecked = true;
            } else {
              houseCommunityList[i].isChecked = false;
            }
          }
          widget.selectState.updateDataList(list: houseCommunityList);

          bool? haveChild = houseCommunityList[index].haveChild;
          if (haveChild!) {
            widget.selectState.loadHouseInfo(
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

    List<ScSelectHouseModel> navigatorList = widget.selectState.navigatorList;
    navigatorList.removeAt(navigatorList.length - 1);
    navigatorList.add(scSelectHouseModel);

    ScSelectHouseModel scSelectHouseModelTemp = ScSelectHouseModel(id: 0, name: "请选择");
    navigatorList.add(scSelectHouseModelTemp);
    widget.selectState.updateNavigatorList(list: navigatorList);
  }

  /// 绑定房号
  void bindHousePage(String houseId, String currentRoomName) {
    /// 从缓存中去取数据
    /// 第一个数据是园区
    List<ScSelectHouseModel> navigatorList = widget.selectState.navigatorList;
    String houseName = '';

    for (int i = 1; i < navigatorList.length - 1; i++) {
      String? name = navigatorList[i].name;
      houseName = houseName + name!;
    }
    houseName = houseName + currentRoomName;

    List valueList = ['${navigatorList[0].name}', houseName, '', ''];

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
