
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

class SCHomeTabBar extends StatelessWidget {

  const SCHomeTabBar({
    Key? key,
    required this.tabController,
    required this.titleList,
    required this.height
  }) : super(key: key);

  final TabController tabController;

  final List titleList;

  final double height;

  @override
  Widget build(BuildContext context) {

    List<Tab> tabItemList = [];
    for (String title in titleList) {
      tabItemList.add(Tab(text: title,));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      height: height,
      child: PreferredSize(
          preferredSize: Size.fromHeight(height),
          child: Material(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: TabBar(
                  controller: tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: SCColors.color_FF6C00,
                  unselectedLabelColor: SCColors.color_8D8E99,
                  labelColor: SCColors.color_1B1D33,
                  indicatorWeight: 3.0,
                  labelStyle:
                  const TextStyle(fontSize: SCFonts.f16, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: SCFonts.f16, fontWeight: FontWeight.w400),
                  tabs: tabItemList,
                )),
          )),
    );
  }
}