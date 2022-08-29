import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

  SCCommunityListView({Key? key, this.communityList}) : super(key: key);

  final List<SCCommunityModel>? communityList;

  SCSelectCommunityController communityController = Get.find<SCSelectCommunityController>();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_FFFFFF,
      child: EasyRefresh(
          header: ClassicalHeader(
            refreshText: '下拉刷新',
            refreshReadyText: '释放刷新',
            refreshingText: '刷新中...',
            refreshedText: '刷新完成',
            refreshFailedText: '刷新失败',
            noMoreText: '没有更多',
          ),
          footer: ClassicalFooter(
            bgColor: Colors.transparent,
            //  更多信息文字颜色
            infoColor: SCColors.color_1B1C33,
            // 字体颜色
            textColor: SCColors.color_1B1C33,
            // 加载失败时显示的文字
            loadText: '加载失败',
            // 没有更多时显示的文字
            noMoreText: '',
            // 是否显示提示信息
            showInfo: false,
            // 正在加载时的文字
            loadingText: '加载中...',
            // 准备加载时显示的文字
            loadReadyText: '上拉加载更多',
            // 加载完成显示的文字
            loadedText: '加载完成',
          ),
          emptyWidget: communityList!.length > 0 ? null : emptyView(),
          onLoad: onLoadMore,
          onRefresh: onRefresh,
          controller: communityController.refreshController,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              SCCommunityModel model = communityList![index];
              return getCell(model: model);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox();
            },
            itemCount: communityList?.length ?? 0)
      ),
    );

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
    return SCCommunityItem(model: model,);
  }

  Future onRefresh() async{
    communityController.loadCommunityData(isLoadMore: false);
  }

  Future onLoadMore() async{
    communityController.loadCommunityData(isLoadMore: true);
  }

  reload() {
    communityController.loadCommunityData(isLoadMore: false);
  }

}