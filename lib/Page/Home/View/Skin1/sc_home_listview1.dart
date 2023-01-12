/// 首页第一套皮肤-listview
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_type_define.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/Page/Home/View/Skin1/Data/sc_home_news_repository.dart';
import 'package:smartcommunity/Page/Home/View/Skin1/Common/sc_home_sub_tabview.dart';
import 'package:smartcommunity/Page/Home/View/Skin1/Common/sc_home_tabbar.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_activity_item.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_banner.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_grid_image_group.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_grid_image_item.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_image_item.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_items.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_news_item.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_swiper.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_login_controller.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../../Constants/sc_default_value.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Constants/sc_h5.dart';
import '../../../../Delegate/sc_sticky_tabbar_delegate.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../GetXController/sc_home_controller.dart';
import '../../GetXController/sc_home_controller2.dart';
import '../../GetXController/sc_home_nav1_controller.dart';
import '../sc_home_feature_item.dart';
import 'Common/sc_home_refresh_header.dart';

class SCHomeListView1 extends StatefulWidget {
  SCHomeListView1(
      {Key? key,
      this.scrollFunction,
      required this.dataList,
      required this.bannerList,
      required this.navigationHeight,
      required this.tabTitleList,
      this.bannerBGScale = 750.0 / 544.0,
      this.bannerScale = 686.0 / 280.0,
      this.bannerCurrentIndex = 0,
      this.bannerBackgroundImageUrl = SCAsset.homeBannerBG1})
      : super(key: key);

  /// listView数据源
  final List dataList;

  /// 滑动回调
  Function(double offset)? scrollFunction;

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

  /// 导航栏高度
  final double navigationHeight;

  /// tab数据源
  final List tabTitleList;

  @override
  SCHomeListView1State createState() => SCHomeListView1State();
}

class SCHomeListView1State extends State<SCHomeListView1>
    with SingleTickerProviderStateMixin {
  SCHomeController1 state = Get.find<SCHomeController1>();

  SCHomeNav1Controller nav1State = Get.find<SCHomeNav1Controller>();

  /// tabController
  late final TabController tabController;

  /// 源
  late List<SCHomeNewsRespority> repositoryList = [];

  /// tabView-list
  late List<Widget> tabViewList = [];

  /// tabBar高度
  final tabBarHeight = 44.0;

  final GlobalKey headerKey = GlobalKey();

  ScrollController scrollController = ScrollController();

  @override
  initState() {
    for (String title in widget.tabTitleList) {
      SCHomeNewsRespority respority = SCHomeNewsRespority();
      repositoryList.add(respority);
      SCHomeSubTabView tabView = SCHomeSubTabView(respority);
      tabViewList.add(tabView);
    }
    tabController =
        TabController(length: widget.tabTitleList.length, vsync: this);
    scrollNotify();
    super.initState();
  }

  @override
  dispose() {
    for (SCHomeNewsRespority respority in repositoryList) {
      respority.dispose();
    }
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return listView();
    return PullToRefreshNotification(
        color: Colors.blue,
        onRefresh: onRefresh,
        maxDragOffset: SCUtils().getTopSafeArea() + 40,
        pullBackOnRefresh: false,
        reachToRefreshOffset: SCUtils().getTopSafeArea() + 60,
        child: ExtendedNestedScrollView(
            controller: scrollController,
            physics: const NeverScrollableScrollPhysics(),
            onlyOneScrollInBody: true,
            pinnedHeaderSliverHeightBuilder: () {
              return widget.navigationHeight;
            },
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                pullToRefreshContainer(),
                scrollHeader(),
                stickyTabBar(),
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: tabViewList,
            )));
  }

  /// 下拉刷新容器
  Widget pullToRefreshContainer() {
    return PullToRefreshContainer(
      (PullToRefreshScrollNotificationInfo? info) {
        Future.delayed(const Duration(milliseconds: 1), () {
          double offset = info?.dragOffset ?? 0;
          nav1State.hiddenNav(isHidden: offset > 0);
        });
        return SliverToBoxAdapter(
          child: SCHomeRefreshHeader(headerKey, info, DateTime.now()),
        );
      },
    );
  }

  /// NestedScrollView - header
  Widget scrollHeader() {
    return SliverToBoxAdapter(
      child: listView(),
    );
  }

  /// 吸顶tabBar
  Widget stickyTabBar() {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: SCStickyTabBarDelegate(child: tabBarItem(), height: 44.0));
  }

  /// tabBar
  Widget tabBarItem() {
    return SCHomeTabBar(
        tabController: tabController,
        titleList: widget.tabTitleList,
        height: tabBarHeight,
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int type = widget.dataList[index]['type'];
          return getCell(type: type);
        },
        separatorBuilder: (BuildContext context, int index) {
          if (widget.dataList[index] == SCTypeDefine.SC_HOME_TYPE_GRID) {
            return const SizedBox();
          } else {
            return lineWidget();
          }
        },
        itemCount: widget.dataList.length);
  }

  /// 获取cell
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
    } else {
      // 测试
      return testCell();
    }
  }

  /// 监听滑动
  void scrollNotify() {
    scrollController.addListener(() {
      widget.scrollFunction?.call(scrollController.offset);
    });
  }

  /// banner-cell
  Widget bannerCell() {
    return SCHomeBanner(
      bannerBGScale: widget.bannerBGScale,
      bannerScale: widget.bannerScale,
      bannerList: widget.bannerList,
      backgroundImageUrl: widget.bannerBackgroundImageUrl,
      currentIndex: widget.bannerCurrentIndex,
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
      tabTitleList: widget.tabTitleList,
      tabController: tabController,
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
      imageList: const [
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
      imageList: const [
        SCAsset.homeGrid1,
        SCAsset.homeGrid2,
        SCAsset.homeGrid3,
        SCAsset.homeGrid4,
      ],
      cellType: SCHomeCellBottomContentType.bottomContent,
      imageWidth: 160.0,
      imageHeight: 160.0,
    );
  }

  Widget gridImageGroupCell() {
    return SCHomeGridImageGroup(
      onTap: (int index) {},
      title: '组件名称',
      imageList: const [
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
  Future<bool> onRefresh() async {
    return await Future.delayed(const Duration(milliseconds: 500), () {
      // if (tabController.index == 0) {
      //   SCHomeNewsRespority respority = repositoryList.first;
      //   return respority.refresh(false);
      // }
      return true;
    });
  }

  /// 测试数据-工单
  workOrder() {
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    String token = SCScaffoldManager.instance.user.token ?? "";
    String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
    String url =
        "${SCConfig.getH5Url(SCH5.workOrderUrl)}?defCommunityId=$defCommunityId&Authorization=$token&defRoomId=$defRoomId&client=${SCDefaultValue.client}";
    var params = {"title": "工单", "url": url};
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
  }

  /// 测试数据-应用详情
  itemDetail(int index) {
    var data = state.allItemsList[index];
    String title = data['title'];
    String url = data['subUrl'];
    bool needHouseId = data['needHouseId'];
    if (needHouseId) {
      SCDialogUtils.instance.showMiddleDialog(
        context: context,
        title: "温馨提示",
        content: SCDefaultValue.needHouseId,
        customWidgetButtons: [
          defaultCustomButton(context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
          defaultCustomButton(context,
            text: '确定',
            textColor: SCColors.color_FF6C00,
            fontWeight: FontWeight.w400, onTap: () async {
              myHouse();
            }),
        ],
      );
    } else {
      var params = {"title": title, "url": url};
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
    }
  }

  /// 我的房屋
  myHouse() {
    String token = SCScaffoldManager.instance.user.token ?? "";
    String userId = SCScaffoldManager.instance.user.id ?? "";
    String userName = Uri.encodeComponent(SCScaffoldManager.instance.user.userName ?? '');
    String phoneNum = SCScaffoldManager.instance.user.mobileNum ?? '';
    String url = "${SCConfig.getH5Url(SCH5.myHouseUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent('杭州市')}&latitude=30.25961&longitude=120.13026&gender=1";
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"title" : "我的房屋", "url" : url});
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
