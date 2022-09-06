import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Home/View/sc_home_life.dart';
import 'package:smartcommunity/page/Home/View/sc_home_selected_goods.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_type_define.dart';
import '../../../../widgets/Refresh/sc_refresh_footer.dart';
import '../../../../widgets/Refresh/sc_refresh_header.dart';
import '../../GetXController/sc_home_controller2.dart';
import '../sc_home_community_activity.dart';
import '../sc_home_items.dart';
import '../sc_home_swiper.dart';

/// 首页第二套皮肤-listview

class SCHomeListView2 extends StatelessWidget {

  /// listView数据源
  final List dataList;

  /// 滑动回调
  Function(double offset)? scrollFunction;

  ScrollController scrollController = ScrollController();

  SCHomeController2 state = Get.find<SCHomeController2>();

  SCHomeListView2({Key? key, this.scrollFunction, required this.dataList}) : super(key: key);

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
              int type = dataList[index]['type'];
              return getCell(type: type);
            },
            separatorBuilder: (BuildContext context, int index) {
              return lineWidget();
            },
            itemCount: dataList.length));
  }

  /// 获取cell
  Widget getCell({required int type}) {
    if (type == SCTypeDefine.SC_HOME_TYPE_BANNER) {
      // banner
      return bannerCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_ALLITEMS) {
      // 应用列表
      return itemsCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_COMMUNITY) {
      // 园区活动
      return communityCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_LIFE) {
      // 美好生活
      return lifeCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_GOODS) {
      // 精选商品
      return goodsCell();
    } else {
      // 测试
      return testCell();
    }
  }

  /// 分割线
  Widget lineWidget() {
    return const SizedBox(
      height: 8.0,
    );
  }

  /// swiper广告图
  Widget bannerCell() {
    return SCHomeSwiper(
      horizontalPadding: 16.0,
      radius: 4.0,
      imageScale: 686.0 / 232.0,
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

  /// 园区活动cell
  Widget communityCell() {
    return SCHomeCommunityActivity(activityList: const [
      SCAsset.homeActivity4,
      SCAsset.homeActivity5,
      SCAsset.homeActivity6
    ],);
  }

  /// 美好生活
  Widget lifeCell() {
    return const SCHomeLife(dataList: [
      SCAsset.homeLife1,
      SCAsset.homeLife2,
      SCAsset.homeLife1,
    ]);
  }

  /// 精选商品cell
  Widget goodsCell() {
    return SCHomeSelectedGoodsItem();
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
