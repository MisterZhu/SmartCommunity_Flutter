import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/page/Login/Model/sc_community_model.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_item.dart';

import '../../../../constants/sc_colors.dart';
import '../../GetXController/sc_select_community_controller.dart';

/// 社区搜索结果列表

class SCCommunitySearchResultListView extends StatelessWidget {

  final List<SCCommunityModel>? communityList;

  final Function(SCCommunityModel model)? selectCommunityHandler;

  final SCSelectHouseLogicType type;

  SCCommunitySearchResultListView({Key? key,
    this.type = SCSelectHouseLogicType.login,
    this.communityList,
    this.selectCommunityHandler}) : super(key: key);

  SCSelectCommunityController communityController = Get.find<SCSelectCommunityController>();

  @override
  Widget build(BuildContext context) {
    return body();
  }

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
          emptyWidget: null,
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

  Widget getCell({required SCCommunityModel model}) {
    return SCCommunityItem(model: model, type: type);
  }

  Future onRefresh() async{
    communityController.loadSearchResultData(isLoadMore: false);
  }

  Future onLoadMore() async{
    communityController.loadSearchResultData(isLoadMore: true);
  }

}
