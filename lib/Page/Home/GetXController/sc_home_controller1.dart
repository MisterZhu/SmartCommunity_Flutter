/// 首页皮肤1-GetxController
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
import '../../../Utils/sc_utils.dart';
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
    SCAsset.homeBanner1,
    SCAsset.homeBanner2,
    SCAsset.homeBanner3
  ];

  /// 所有banner的背景图片
  List allBannerBGList = [
    SCAsset.homeBannerBG1,
    SCAsset.homeBannerBG2,
    SCAsset.homeBannerBG3
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
    allNewsList = List.from(homeNewsList).map((e) => SCHomeNewsModel.fromJson(e)).toList();
    homeFeatureStyle1 = SCHomeFeatureStyle.featureStyle1;
    homeFeatureStyle2 = SCHomeFeatureStyle.featureStyle2;

    /// 新工单
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    String token = SCScaffoldManager.instance.user.token ?? "";
    String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
    String workOrderUrl = "${SCConfig.getH5Url(SCH5.workOrderUrl)}?defCommunityId=$defCommunityId&Authorization=$token&defRoomId=$defRoomId&client=${SCDefaultValue.client}";
    allItemsList = [
      {"iconUrl" : SCAsset.iconItem10, "title" : "新工单", "subUrl" : workOrderUrl},
      {"iconUrl" : SCAsset.iconItem1, "title" : "园区缴费", "subUrl" : SCH5.communityPayUrl},
      {"iconUrl" : SCAsset.iconItem2, "title" : "预缴账户", "subUrl" : SCH5.prepayUrl},
      {"iconUrl" : SCAsset.iconItem3, "title" : "项目入驻", "subUrl" : SCH5.projectEnterUrl},
      {"iconUrl" : SCAsset.iconItem4, "title" : "公共缴费", "subUrl" : SCH5.publicPayUrl},
      {"iconUrl" : SCAsset.iconItem5, "title" : "问卷调查", "subUrl" : SCH5.questionnaireSurveyUrl},
      {"iconUrl" : SCAsset.iconItem6, "title" : "访客通行", "subUrl" : SCH5.visitorUrl},
      {"iconUrl" : SCAsset.iconItem7, "title" : "入伙验房", "subUrl" : SCH5.houseInspectionManagementUrl},
      {"iconUrl" : SCAsset.iconItem8, "title" : "园区停车", "subUrl" : SCH5.communityParkUrl},
      {"iconUrl" : SCAsset.iconItem9, "title" : "垃圾分类", "subUrl" : SCH5.garbageSortUrl},
    ];
  }

  /// 修改bannerIndex
  void changeBannerIndex({int index = 0}) {
    bannerCurrentIndex = index;
    update();
  }

  /// 裁剪图片
  void croperImage() {

  }

  /// 重置数据
  void resetAllData() {
    bannerCurrentIndex = 0;
    update();
  }

  @override
  onClose() {
    super.onClose();
  }
}