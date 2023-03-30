
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';


class SCCouponTopItem extends StatelessWidget {

  SCCouponTopItem({
    Key? key,
    required this.tabController,
    required this.titleList,
    required this.height,
    this.descAction
  }) : super(key: key);

  final TabController tabController;

  final List titleList;

  final double height;

  /// 点击优惠券说明
  final Function? descAction;

  List<Tab> tabItemList = [];

  @override
  Widget build(BuildContext context) {
    for (String title in titleList) {
      tabItemList.add(Tab(text: title,));
    }
    return Container(
      padding: const EdgeInsets.only(right: 16.0),
      width: double.infinity,
      height: 44.0,
      color: SCColors.color_FFFFFF,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          tabBarItem(),
          const SizedBox(width: 20.0,),
          Expanded(child: GestureDetector(
            onTap: () {
              descAction?.call();
            },
            child: const Text(
              '优惠券说明',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33,
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget tabBarItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      width: 240.0,
      height: 44.0,
      color: SCColors.color_FFFFFF,
      child: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: TabBar(
                  controller: tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  isScrollable: true, //为false时不能滚动，标题会平分宽度显示，为true时会紧凑排列
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: const Color(0xFF6DAC77),
                  unselectedLabelColor: SCColors.color_5E5E66,
                  labelColor: SCColors.color_1B1C33,
                  indicatorWeight: 2.0,
                  labelStyle:
                  const TextStyle(fontSize: SCFonts.f14, fontWeight: FontWeight.w600),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: SCFonts.f14, fontWeight: FontWeight.w400),
                  tabs: tabItemList
                )),
          )),
    );
  }
}