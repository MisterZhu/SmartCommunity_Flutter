import 'package:flutter/material.dart';

import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';
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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
    return Container();

  }

}