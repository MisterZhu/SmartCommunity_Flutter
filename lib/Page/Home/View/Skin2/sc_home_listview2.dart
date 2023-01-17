import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_life_item.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_selected_goods.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_default_value.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Constants/sc_h5.dart';
import '../../../../Constants/sc_type_define.dart';
import '../../../../Network/sc_config.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../GetXController/sc_home_controller.dart';
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

  SCHomeController2 state = Get.find<SCHomeController2>();

  SCHomeListView2({Key? key, this.scrollFunction, required this.dataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    scrollNotify();
    return SmartRefresher(
      onRefresh: () {
        onRefresh();
      },
      onLoading: () {
        onLoad();
      },
      controller: state.refreshController,
      enablePullUp: true,
      header: const SCCustomHeader(),
      child: ListView.separated(
          controller: state.scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            int type = dataList[index]['type'];
            return getCell(type: type);
          },
          separatorBuilder: (BuildContext context, int index) {
            return lineWidget();
          },
          itemCount: dataList.length),
    );
  }

  /// 获取cell
  Widget getCell({required int type}) {
    if (type == SCTypeDefine.SC_HOME_TYPE_BANNER) {
      // banner
      return bannerCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_ALLITEMS) {
      // 应用列表
      return itemsCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_COMMUNITY1) {
      // 园区活动
      return communityCell1();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_COMMUNITY2) {
      // 园区活动2
      return communityCell2();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_LIFE1) {
      // 美好生活
      return lifeCell1();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_LIFE2) {
      // 美好生活
      return lifeCell2();
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
      onTap: (int index) {
        workOrder();
      },
    );
  }

  /// 应用列表-cell
  Widget itemsCell() {
    return SCHomeAllItem(
      itemList: state.allItemsList,
      bgColor: SCColors.color_F5F5F5,
      onTap: (int index) {
        itemDetail(index);
      },
    );
  }

  /// 园区活动cell1
  Widget communityCell1() {
    return SCHomeCommunityActivity(
      cellType: SCHomeCellBottomContentType.noBottomContent,
      activityList: const [
      SCAsset.homeActivity4,
      SCAsset.homeActivity5,
      SCAsset.homeActivity6
    ],tapAction: (index) {
      workOrder();
    },);
  }

  /// 园区活动cell2
  Widget communityCell2() {
    return SCHomeCommunityActivity(
      cellType: SCHomeCellBottomContentType.bottomContent,
      activityList: const [
        SCAsset.homeActivity4,
        SCAsset.homeActivity5,
        SCAsset.homeActivity6
      ],tapAction: (index) {
      workOrder();
    },);
  }

  /// 美好生活
  Widget lifeCell1() {
    return SCHomeLifeItem(
      cellType: SCHomeCellBottomContentType.noBottomContent,
      dataList: [
        SCAsset.homeLife1,
        SCAsset.homeLife2,
        SCAsset.homeLife1,
    ], tapAction: (index) {
      workOrder();
    },);
  }

  /// 美好生活
  Widget lifeCell2() {
    return SCHomeLifeItem(
      cellType: SCHomeCellBottomContentType.bottomContent,
      dataList: [
        SCAsset.homeLife1,
        SCAsset.homeLife2,
        SCAsset.homeLife1,
      ], tapAction: (index) {
      workOrder();
    },);
  }

  /// 精选商品cell
  Widget goodsCell() {
    return SCHomeSelectedGoodsItem(
      tapAction: (index) {
        workOrder();
      },
    );
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
    state.scrollController.addListener(() {
      scrollFunction?.call(state.scrollController.offset);
    });
  }

  /// 加载更多
  Future onLoad() async {}

  /// 刷新
  Future onRefresh() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      state.refreshController.refreshCompleted();
      changeSkin();
    });
  }

  /// 测试数据-工单
  workOrder() {
    String token = SCScaffoldManager.instance.user.token ?? "";
    String userId = SCScaffoldManager.instance.user.id ?? "";
    String userName = Uri.encodeComponent(SCScaffoldManager.instance.user.userName ?? '');
    String phoneNum = SCScaffoldManager.instance.user.mobileNum ?? '';
    int gender = SCScaffoldManager.instance.user.gender ?? 0;
    String city = SCScaffoldManager.instance.city;
    double longitude = SCScaffoldManager.instance.longitude;
    double latitude = SCScaffoldManager.instance.latitude;
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    String workOrderUrl = "${SCConfig.getH5Url(SCH5.workOrderUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    var params = {"title": "工单", "url": workOrderUrl};
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
  }

  /// 测试数据-应用详情
  itemDetail(int index) {
    SCHomeController2 controller = Get.find<SCHomeController2>();
    var data = controller.allItemsList[index];
    String title = data['title'];
    String url = data['subUrl'];
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"title": title, "url": url});
  }

  /// 切换皮肤
  changeSkin() {
    SCHomeController controller = Get.find<SCHomeController>();
    if (controller.skinStyle == 0) {
      controller.changeSkin(style: 1);
    } else {
      controller.changeSkin(style: 0);
    }
  }
}
