import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../widgets/Refresh/sc_refresh_footer.dart';
import '../../../../widgets/Refresh/sc_refresh_header.dart';
import '../../GetXController/sc_home_controller2.dart';
import '../sc_home_items.dart';
import '../sc_home_swiper.dart';

/// 首页第二套皮肤-listview

class SCHomeListView2 extends StatelessWidget {
  /// 滑动回调
  Function(double offset)? scrollFunction;

  ScrollController scrollController = ScrollController();

  SCHomeController2 state = Get.find<SCHomeController2>();

  SCHomeListView2({Key? key, this.scrollFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    scrollNotify();
    return EasyRefresh(
        onLoad: onLoad,
        onRefresh: onRefresh,
        scrollController: scrollController,
        header: SCRefreshHeader(),
        footer: SCRefreshFooter(),
        child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return swiperCell();
              } else if(index == 1) {
                return itemsCell();
              } else {
                return testCell();
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return lineWidget();
            },
            itemCount: 5));
  }

  /// 分割线
  Widget lineWidget() {
    return const SizedBox(
      height: 8.0,
    );
  }

  /// swiper广告图
  Widget swiperCell() {
    return SCHomeSwiper(
      horizontalPadding: 16.0,
      radius: 4.0,
      imageScale: 686.0 / 168.0,
      imageList: const [
        SCAsset.homeSkin2Banner,
      ],
      normalColor: SCColors.color_FFFFFF,
      activeColor: SCColors.color_FF6C00,
      onTap: (int index) {},
    );
  }

  /// 应用列表-cell
  Widget itemsCell() {
    return SCHomeAllItem(itemList: state.allItemsList);
  }

  /// 测试-cell
  Widget testCell() {
    return Container(
      color: Colors.yellowAccent,
      height: 200,
    );
  }

  /// 监听滑动
  void scrollNotify() {
    scrollController.addListener(() {
      scrollFunction?.call(scrollController.offset);
    });
  }

  Future onLoad() async {}

  Future onRefresh() async {}
}
