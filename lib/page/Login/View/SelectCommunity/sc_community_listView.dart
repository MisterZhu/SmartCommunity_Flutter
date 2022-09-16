import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_empty_item.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_item.dart';
import 'package:smartcommunity/utils/Loading/sc_loading_utils.dart';
import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../GetXController/sc_search_community_controller.dart';
import '../../GetXController/sc_select_community_controller.dart';
import '../../Model/sc_community_model.dart';

/// 园区列表

class SCCommunityListView extends StatelessWidget {
  SCCommunityListView({Key? key, this.communityList, this.type = SCSelectHouseLogicType.login}) : super(key: key);

  final List<SCCommunityModel>? communityList;

  SCSelectHouseLogicType type;

  SCSelectCommunityController communityController = Get.find<SCSelectCommunityController>();

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
          controller: communityController.refreshController,
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
    SCSearchCommunityController searchState = Get.find<SCSearchCommunityController>();
    SCSelectCommunityController selectState = Get.find<SCSelectCommunityController>();

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
    return SCCommunityItem(model: model,type: type,);
  }

  Future onRefresh() async{
    communityController.refreshController.finishLoad();
    communityController.loadCommunityData(isLoadMore: false);
  }

  Future onLoadMore() async{
    communityController.loadCommunityData(isLoadMore: true);
  }

  reload() {
    communityController.loadCommunityData(isLoadMore: false);
  }

}