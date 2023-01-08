/// 首页皮肤1-GetxController
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Constants/sc_skin_value.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Page/Home/Model/sc_home_news_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../Constants/sc_default_value.dart';
import '../../../Constants/sc_h5.dart';
import '../../../Skin/Model/sc_home_visitor_decoration_model.dart';
// import 'package:image_cropper/image_cropper.dart';

class SCHomeController1 extends GetxController {
  /// banner背景大图比例
  double bannerBGScale = 750.0 / 544.0;

  /// banner比例
  double bannerScale = 686 / 280.0;

  /// 单张运营位比例
  double bannerScale1 = 686 / 172.0;

  /// 2张运营位比例，2等分
  double bannerScale2 = 336 / 252.0;

  /// 4张运营位比例，4等分
  double bannerScale3 = 160 / 160.0;

  /// banner当前index
  int bannerCurrentIndex = 0;

  /// 所有应用
  late List allItemsList;

  /// 所有banner
  List allBannerList = [
    //SCAsset.homeBanner1,
    // SCAsset.homeBanner2,
    // SCAsset.homeBanner3
  ];

  /// 所有banner的背景图片
  List allBannerBGList = [
    //SCAsset.homeBannerBG1,
    // SCAsset.homeBannerBG2,
    // SCAsset.homeBannerBG3
  ];

  /// 活动图片list
  List allActivityImageList = [
    SCAsset.homeActivity3,
    SCAsset.homeActivity1,
    SCAsset.homeActivity2,
    SCAsset.homeActivity3,
    SCAsset.homeActivity1,
    SCAsset.homeActivity2,
    SCAsset.homeActivity3,
    SCAsset.homeActivity1,
    SCAsset.homeActivity2,
  ];

  /// 轮播图滚动速度
  int autoplaySpeed = 2;

  /// 资讯list
  List<SCHomeNewsModel>? allNewsList;

  /// 精选商家cell样式1
  late SCHomeFeatureStyle homeFeatureStyle1;

  /// 精选商家cell样式1
  late SCHomeFeatureStyle homeFeatureStyle2;

  /// swiper-水平间距
  double swiper_horizontalPadding = 16.0;

  /// swiper-圆角
  double swiper_radius = 6.0;

  /// swiper-imageScale
  double swiper_scale = 686.0 / 260.0;

  /// swiper-pagenation默认颜色
  Color swiper_normal_color = Colors.grey;

  /// swiper-pagenation选中颜色
  Color swiper_active_color = Colors.orange;

  /// tab标题数据源
  List tabTitleList = ["第一页", "第二页", "第三页", "第四页", "第五页", "第六页"];

  @override
  void onInit() {
    super.onInit();
    getHomeDecorationData();
    allNewsList = List.from(homeNewsList)
        .map((e) => SCHomeNewsModel.fromJson(e))
        .toList();
    homeFeatureStyle1 = SCHomeFeatureStyle.featureStyle1;
    homeFeatureStyle2 = SCHomeFeatureStyle.featureStyle2;

    /// 新工单
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    String token = SCScaffoldManager.instance.user.token ?? "";
    String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
    String workOrderUrl =
        "${SCConfig.getH5Url(SCH5.workOrderUrl)}?defCommunityId=$defCommunityId&Authorization=$token&defRoomId=$defRoomId&client=${SCDefaultValue.client}";
    allItemsList = [
      {
        "iconUrl": SCAsset.iconItem1, "title": "园区缴费", "subUrl": SCH5.communityPayUrl
      },
      {"iconUrl": SCAsset.iconItem8, "title": "工单", "subUrl": workOrderUrl},
    ];
  }

  /// 修改bannerIndex
  void changeBannerIndex({int index = 0}) {
    bannerCurrentIndex = index;
    update();
  }

  /// 裁剪图片
  void croperImage() {}

  /// 重置数据
  void resetAllData() {
    bannerCurrentIndex = 0;
    update();
  }

  /// 获取首页装修数据
  getHomeDecorationData() {
    //if (SCScaffoldManager.instance.isLogin) {

    // } else {
      SCHomeVisitorDecorationModel visitorDecorationModel = SCScaffoldManager.instance.visitorDecorationModel;
      List<PageDecorationList>? pageList = visitorDecorationModel.pageDecorationList;
      if (pageList != null) {
        for (PageDecorationList page in pageList) {
          if (page.name == '首页') {
            List<ComponentList>? list = page.componentList;
            if (list != null) {
              for (ComponentList component in list) {
                if (component.name == '轮播图') {
                  var info = jsonDecode(component.info ?? '');
                  autoplaySpeed = info['autoplaySpeed'];
                  List? imagesList = info['advertisementImgList'];
                  if (imagesList != null) {
                    for (var imageDic in imagesList) {
                      String fileKey = imageDic['fileKey'];
                      if (fileKey.isNotEmpty) {
                        allBannerList.add(SCConfig.getImageUrl(fileKey));
                        allBannerBGList.add(SCConfig.getImageUrl(fileKey));
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
   // }
  }

  @override
  onClose() {
    super.onClose();
  }
}
