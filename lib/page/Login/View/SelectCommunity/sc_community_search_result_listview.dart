import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/Model/sc_community_model.dart';

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
          return cell(index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: communityList?.length ?? 0);
  }

  /// 社区cell
  Widget cell({int index= 0}) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [communityItem(index: index), separatorItem()],
        ),
      ),
      onTap: () {

      },
    );
  }

  /// 社区item
  Widget communityItem({int index= 0}) {
    SCCommunityModel model = communityList![index];
    return Container(
      height: 48.0,
      alignment: Alignment.centerLeft,
      child: Text(
        model.name,
        style: const TextStyle(
            fontSize: SCFonts.f16,
            color: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  /// 分割线
  Widget separatorItem() {
    return const Divider(
      height: 0.5,
      color: SCColors.color_EDEDF0,
    );
  }

  /// 选择社区
  selectCity({int index= 0}) {
    SCCommunityModel model = communityList![index];
    if (selectCommunityHandler != null) {
      selectCommunityHandler?.call(model);
    }
  }
}
