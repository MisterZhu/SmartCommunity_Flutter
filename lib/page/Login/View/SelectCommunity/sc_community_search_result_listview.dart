import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/Model/sc_community_model.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_item.dart';

/// 社区搜索结果列表

class SCCommunitySearchResultListView extends StatelessWidget {

  final List<SCCommunityModel>? communityList;

  final Function(SCCommunityModel model)? selectCommunityHandler;

  const SCCommunitySearchResultListView({Key? key, this.communityList, this.selectCommunityHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          SCCommunityModel model = communityList![index];
          return getCell(model: model);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: communityList?.length ?? 0);
  }

  Widget getCell({required SCCommunityModel model}) {
    return SCCommunityItem(model: model,);
  }

}
