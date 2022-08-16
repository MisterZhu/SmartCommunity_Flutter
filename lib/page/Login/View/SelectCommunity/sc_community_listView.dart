import 'package:flutter/material.dart';
import 'package:smartcommunity/page/Login/View/SelectCommunity/sc_community_item.dart';
import '../../Model/sc_community_model.dart';

/// 园区列表

class SCCommunityListView extends StatelessWidget {

  const SCCommunityListView({Key? key, this.cmmunityList}) : super(key: key);

  final List<SCCommunityModel>? cmmunityList;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: 5);
  }

  Widget getCell({required int index}) {
    return SCCommunityItem();
  }

}