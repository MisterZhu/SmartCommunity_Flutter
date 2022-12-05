import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/Login/View/SelectCommunity/sc_community_empty_item.dart';
import 'package:smartcommunity/Page/Login/View/SelectCommunity/sc_community_item.dart';
import 'package:smartcommunity/Utils/Loading/sc_loading_utils.dart';
import '../../../../Constants/sc_asset.dart';
import '../../GetXController/sc_search_community_controller.dart';
import '../../GetXController/sc_select_community_controller.dart';
import '../../Model/sc_community_model.dart';

/// 园区列表

class SCCommunityListView extends StatelessWidget {
  SCCommunityListView({Key? key,
    required this.selectState,
    required this.searchState,
    this.communityList,
    this.type = SCSelectHouseLogicType.login
  }) : super(key: key);

  final List<SCCommunityModel>? communityList;

  SCSelectHouseLogicType type;

  final SCSelectCommunityController selectState;

  final SCSearchCommunityController searchState;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return communityList!.isNotEmpty ? Container(
      color: SCColors.color_FFFFFF,
      child: EasyRefresh(
          header: const CupertinoHeader(
              userWaterDrop: false
          ),
          footer: const CupertinoFooter(

          ),
          onLoad: onLoadMore,
          onRefresh: onRefresh,
          controller: selectState.refreshController,
          child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                SCCommunityModel model = communityList![index];
                return getCell(model: model);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox();
              },
              itemCount: communityList?.length ?? 0)
      ),
    ) : emptyView();
  }

  Widget emptyView() {
    bool showButton = false;
    if (searchState.selectCity != '' && !selectState.isShowResult) {
      showButton = true;
    }

    /// 已选择城市-数据加载失败就显示底部重新获取按钮
    return SCCommunityEmptyItem(
      imageName: SCAsset.iconCommunityNoData,
      content: '暂无可选项目',
      buttonTitle: '重新获取',
      showButton: showButton,
      btnTapAction: () {
        /// 重新加载数据
        selectState.loadCommunityData(isLoadMore: false);
      },);
  }

  Widget getCell({required SCCommunityModel model}) {
    return SCCommunityItem(searchState: searchState, model: model, type: type,);
  }

  Future onRefresh() async{
    selectState.refreshController.finishLoad();
    selectState.loadCommunityData(isLoadMore: false);
  }

  Future onLoadMore() async{
    selectState.loadCommunityData(isLoadMore: true);
  }

  reload() {
    selectState.loadCommunityData(isLoadMore: false);
  }

}