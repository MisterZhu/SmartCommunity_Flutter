import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/Login/Model/sc_community_model.dart';
import 'package:smartcommunity/Page/Login/View/SelectCommunity/sc_community_item.dart';

import '../../../../Constants/sc_colors.dart';
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
          header: const CupertinoHeader(
              userWaterDrop: false
          ),
          footer: const CupertinoFooter(),
          onLoad: onLoadMore,
          onRefresh: onRefresh,
          controller: communityController.refreshController,
          child: ListView.separated(
            padding: EdgeInsets.zero,
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
