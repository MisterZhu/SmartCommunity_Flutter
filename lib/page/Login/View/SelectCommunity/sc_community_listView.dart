import 'package:flutter/material.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_item.dart';
import '../../Model/sc_community_model.dart';

/// 园区列表

class SCCommunityListView extends StatelessWidget {

  const SCCommunityListView({Key? key, this.communityList}) : super(key: key);

  final List<SCCommunityModel>? communityList;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCCommunityModel model = communityList![index];
          return getCell(model: model);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: 5);
  }

  Widget getCell({required SCCommunityModel model}) {
    return SCCommunityItem(model: model,);
  }

}