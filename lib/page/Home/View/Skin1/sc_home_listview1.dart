/// 首页第一套皮肤-listview
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_type_define.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_item.dart';
import 'package:smartcommunity/page/Home/View/sc_home_banner.dart';
import 'package:smartcommunity/page/Home/View/sc_home_grid_image_group.dart';
import 'package:smartcommunity/page/Home/View/sc_home_grid_image_item.dart';
import 'package:smartcommunity/page/Home/View/sc_home_image_item.dart';
import 'package:smartcommunity/page/Home/View/sc_home_items.dart';
import 'package:smartcommunity/page/Home/View/sc_home_news_item.dart';
import 'package:smartcommunity/page/Home/View/sc_home_swiper.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
import 'package:smartcommunity/widgets/Refresh/sc_custom_header.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_default_value.dart';
import '../../../../constants/sc_h5.dart';
import '../../../../skin/Tools/sc_scaffold_manager.dart';
import '../../../../utils/Router/sc_router_helper.dart';
import '../../GetXController/sc_home_controller2.dart';
import '../sc_home_feature_item.dart';

class SCHomeListView1 extends StatelessWidget {
  SCHomeListView1(
      {Key? key,
      this.scrollFunction,
      required this.dataList,
      required this.bannerList,
      this.bannerBGScale = 750.0 / 544.0,
      this.bannerScale = 686.0 / 280.0,
      this.bannerCurrentIndex = 0,
      this.bannerBackgroundImageUrl = SCAsset.homeBannerBG1})
      : super(key: key);

  /// listView数据源
  final List dataList;

  ScrollController scrollController = ScrollController();

  /// 滑动回调
  Function(double offset)? scrollFunction;

  SCHomeController1 state = Get.find<SCHomeController1>();

  /// banner背景大图比例
  final double bannerBGScale;

  /// banner比例
  final double bannerScale;

  /// banner当前index
  final int bannerCurrentIndex;

  /// banner数据源
  List bannerList;

  /// banner默认背景图
  String bannerBackgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    scrollNotify();
    return SmartRefresher(
      controller: state.refreshController,
      onRefresh: () {
        onRefresh();
      },
      onLoading: () {
        onLoad();
      },
      header: const SCCustomHeader(style: SCCustomHeaderStyle.noNavigation,),
      child: ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            int type = dataList[index]['type'];
            return getCell(type: type);
          },
          separatorBuilder: (BuildContext context, int index) {
            if (dataList[index] == SCTypeDefine.SC_HOME_TYPE_GRID) {
              return const SizedBox();
            } else {
              return lineWidget();
            }
          },
          itemCount: dataList.length),
    );
  }

  Widget getCell({required int type}) {
    if (type == SCTypeDefine.SC_HOME_TYPE_BANNER) {
      // banner
      return bannerCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_ALLITEMS) {
      // 应用列表
      return itemsCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_ACTIVITY) {
      // 活动
      return activityCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_FEATURE) {
      // 精选商家
      return featureCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_NEWS) {
      // 资讯
      return newsCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_IMAGE) {
      // 图片
      return imageCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_SWIPER) {
      // swiper广告图
      return swiperCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_GRID) {
      // 网格图片
      return gridImageCell();
    } else if (type == SCTypeDefine.SC_HOME_TYPE_GRID_GROUP) {
      // 应用列表
      return gridImageGroupCell();
    }  else {
      // 测试
      return testCell();
    }
  }

  /// 监听滑动
  void scrollNotify() {
    scrollController.addListener(() {
      scrollFunction?.call(scrollController.offset);
    });
  }

  /// banner-cell
  Widget bannerCell() {
    return SCHomeBanner(
      bannerBGScale: bannerBGScale,
      bannerScale: bannerScale,
      bannerList: bannerList,
      backgroundImageUrl: bannerBackgroundImageUrl,
      currentIndex: bannerCurrentIndex,
      onTap: (int index) {
        workOrder();
      },
    );
    // return GetBuilder<SCHomeController>(builder: (state) {
    //   String url = state.allBannerBGList.isEmpty
    //       ? SCAsset.homeBannerBG1
    //       : state.allBannerBGList[state.bannerCurrentIndex];
    //   return SCHomeBanner(
    //     bannerBGScale: state.bannerBGScale,
    //     bannerScale: state.bannerScale,
    //     bannerList: state.allBannerList,
    //     backgroundImageUrl: url,
    //     currentIndex: state.bannerCurrentIndex,
    //   );
    // });
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

  /// 活动列表-cell
  Widget activityCell() {
    return SCHomeActivityItem(
      activityList: state.allActivityImageList,
      onTap: (int index) {
        workOrder();
      },
    );
  }

  /// 精选商家-cell
  Widget featureCell() {
    double width = (SCUtils().getScreenWidth() - 64.0) / 2.0;
    return SCHomeFeatureItem(
      maxWidth: width,
      cell1Style: state.homeFeatureStyle1,
      cell2Style: state.homeFeatureStyle2,
      firstTap: (int index) {
        workOrder();
      },
      secondTap: (int index) {
        workOrder();
      },
    );
  }

  /// 资讯-cell
  Widget newsCell() {
    return SCHomeNewsItem(
      newsList: state.allNewsList,
      onTap: (int index) {
        workOrder();
      },
    );
  }

  /// 图片-cell
  Widget imageCell() {
    return SCHomeImageItem(
      onTap: (int index) {},
      imageList: [
        SCAsset.homeGrid5,
        SCAsset.homeGrid5,
      ],
      imageWidth: 336.0,
      imageHeight: 252.0,
      bigImageLeft: false,
    );
  }

  /// 网格图片-cell
  Widget gridImageCell() {
    return SCHomeGridImageItem(
      onTap: (int index) {},
      imageList: [
        SCAsset.homeGrid1,
        SCAsset.homeGrid2,
        SCAsset.homeGrid3,
        SCAsset.homeGrid4,
      ],
      cellType: 2,
      imageWidth: 160.0,
      imageHeight: 160.0,
    );
  }

  Widget gridImageGroupCell() {
    return SCHomeGridImageGroup(
      onTap: (int index) {},
      title: '组件名称',
      imageList: [
        SCAsset.homeGrid5,
        SCAsset.homeBanner2,
        SCAsset.homeBanner3,
        SCAsset.homeGrid5,
      ],
      imageWidth: 324.0,
      imageHeight: 120.0,
    );
  }

  /// swiper广告图
  Widget swiperCell() {
    return SCHomeSwiper(
      horizontalPadding: state.swiper_horizontalPadding,
      radius: state.swiper_radius,
      imageScale: state.swiper_scale,
      imageList: state.allBannerBGList,
      normalColor: state.swiper_normal_color,
      activeColor: state.swiper_active_color,
      onTap: (int index) {
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

  /// 分割线
  Widget lineWidget() {
    return const SizedBox(
      height: 10.0,
    );
  }

  /// 下拉刷新
  Future onRefresh() async {
    print('刷新');
    state.isRefreshing = true;
    state.changeNavigationState(offset: 0.0);
    Future.delayed(const Duration(milliseconds: 1500), () {
      state.refreshController.refreshCompleted();
      Future.delayed(const Duration(milliseconds: 1000), () {
        state.isRefreshing = false;
        state.changeNavigationState(offset: 0.0);
      });
    });

    /// 当网络请求时间超过2秒
    // Future.delayed(Duration(milliseconds: 2000), () {
    //   state.refreshController.finishRefresh(success: true);
    //   Future.delayed(Duration(milliseconds: 800), (){
    //     state.isRefreshing = false;
    //     state.changeNavigationState(offset: 0.0);
    //   });
    // });
    /// 当网络请求时间不超过2秒
    // state.refreshController.finishRefresh(IndicatorResult.success);
    // state.isRefreshing = false;
    // state.changeNavigationState(offset: 0.0);
    // Future.delayed(Duration(milliseconds: 100), () {
    //   state.refreshController.finishRefresh(IndicatorResult.success);
    //   Future.delayed(Duration(milliseconds: 1800), () {
    //     state.isRefreshing = false;
    //     state.changeNavigationState(offset: 0.0);
    //   });
    // });
  }

  /// 上拉加载
  Future onLoad() async {
    print('加载');
    // Future.delayed(const Duration(seconds: 3), () {
    //   state.refreshController.finishLoad(IndicatorResult.noMore);
    // });
  }

  /// 测试数据-工单
  workOrder() {
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    String token = SCScaffoldManager.instance.user.token ?? "";
    String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
    String url = "${SCH5.workOrderUrl}?defCommunityId=$defCommunityId&Authorization=$token&defRoomId=$defRoomId&client=${SCDefaultValue.client}";
    SCRouterHelper.codePage(20000, {"title": "工单", "url": url});
  }

  /// 测试数据-应用详情
  itemDetail(int index) {
    SCHomeController2 controller = Get.find<SCHomeController2>();
    var data = controller.allItemsList[index];
    String title = data['title'];
    String url = data['subUrl'];
    SCRouterHelper.codePage(20000, {"title": title, "url": url});
  }
}
