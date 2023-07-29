/// 首页皮肤2-GetxController
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Constants/sc_h5.dart';
import 'package:smartcommunity/Constants/sc_skin_value.dart';
import 'package:smartcommunity/Page/Home/Model/sc_home_infor_model.dart';
import 'package:smartcommunity/Page/Home/Model/sc_home_news_model.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../../Constants/sc_default_value.dart';
import '../../../Constants/sc_key.dart';
import '../../../Constants/sc_type_define.dart';
import '../../../Network/sc_config.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../../../Skin/Model/sc_user.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../Mine/Model/sc_house_list_model.dart';
import '../Model/sc_home_promotion_model.dart';
import '../Model/sc_home_template_model.dart';
// import 'package:image_cropper/image_cropper.dart';

class SCHomeController2 extends GetxController {
  /// 背景图片scale
  double topNavBGImageScale = 782.0 / 384.0;

  ///背景图
  String imageUrl = '';

  /// 背景图片高度
  double topNavBGImageHeight =
      168.0 - (SCUtils().getTopSafeArea() > 20 ? 0.0 : 30.0);

  /// 导航栏不透明度
  double opacity = 1.0;

  /// 导航栏默认offset
  double navigationOffset = 64.0;

  /// 导航栏背景颜色,默认白色
  Color navigationBackgroundColor = SCColors.color_FE8947;

  /// 导航栏状态，是否置顶
  bool navigationSticky = false;

  /// 导航栏置顶颜色,默认白色
  Color navigationStickyColor = Colors.white;

  /// 未置顶颜色,默认白色
  Color navigationNormalColor = Colors.white;

  /// 项目名称
  String communityName = "请登录";

  /// 所有应用
  List allItemsList = [];

  /// listView数据
  List listViewData = [];

  //推广list
  List<SCHomePromotionModel> promotionList = [];
  List<String?> promotionListFileKey = [];

  //资讯list
  List<SCHomeInforModel> inforList = [];

  /// info1
  BannerInfo? bannerInfo;

  ///info2
  InfoInfo? inforInfo;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  SCHomeTemplateModel? templateModel;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    /// 新工单
    // String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    // String token = SCScaffoldManager.instance.user.token ?? "";
    // String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
    // String workOrderUrl = "${SCConfig.getH5Url(SCH5.workOrderUrl)}?defCommunityId=$defCommunityId&Authorization=$token&defRoomId=$defRoomId&client=${SCDefaultValue.client}";
    // allItemsList = [
    //   {"iconUrl" : SCAsset.iconItem10, "title" : "新工单", "subUrl" : workOrderUrl},
    //   {"iconUrl" : SCAsset.iconItem1, "title" : "园区缴费", "subUrl" : SCH5.communityPayUrl},
    //   {"iconUrl" : SCAsset.iconItem2, "title" : "预缴账户", "subUrl" : SCH5.prepayUrl},
    //   {"iconUrl" : SCAsset.iconItem3, "title" : "项目入驻", "subUrl" : SCH5.projectEnterUrl},
    //   {"iconUrl" : SCAsset.iconItem4, "title" : "公共缴费", "subUrl" : SCH5.publicPayUrl},
    //   {"iconUrl" : SCAsset.iconItem5, "title" : "问卷调查", "subUrl" : SCH5.questionnaireSurveyUrl},
    //   {"iconUrl" : SCAsset.iconItem6, "title" : "访客通行", "subUrl" : SCH5.visitorUrl},
    //   {"iconUrl" : SCAsset.iconItem7, "title" : "入伙验房", "subUrl" : SCH5.houseInspectionManagementUrl},
    //   {"iconUrl" : SCAsset.iconItem8, "title" : "园区停车", "subUrl" : SCH5.communityParkUrl},
    //   {"iconUrl" : SCAsset.iconItem9, "title" : "垃圾分类", "subUrl" : SCH5.garbageSortUrl},
    // ];

    listViewData = [
      /// banner
      {'type': SCTypeDefine.SC_HOME_TYPE_BANNER, 'data': []},

      /// 应用列表
      {'type': SCTypeDefine.SC_HOME_TYPE_ALLITEMS, 'data': []},

      /// 园区活动1
      {'type': SCTypeDefine.SC_HOME_TYPE_COMMUNITY1, 'data': []},

      // /// 园区活动2
      // {'type': SCTypeDefine.SC_HOME_TYPE_COMMUNITY2, 'data': []},

      // /// 热门活动1
      // {'type': SCTypeDefine.SC_HOME_TYPE_LIFE1, 'data': []},

      // /// 热门活动2
      // {'type': SCTypeDefine.SC_HOME_TYPE_LIFE2, 'data': []},

      // /// 精选商品
      // {'type': SCTypeDefine.SC_HOME_TYPE_GOODS, 'data': []},
    ];
    navigationOffset = 44.0 + SCUtils().getTopSafeArea();
    var iddd = SCScaffoldManager.instance.user.communityId ?? "";
    print("iddd = " + iddd);
    if (iddd.isEmpty) {
      print("获取：communityId" + iddd);

      getCommunityId();
    }

    updateHomeData();
    loadTemplateId();
    /*正式
    推广    13795403737604
    资讯    13751484480401
    测试
    推广     13553016454031
    资讯     13646517987151
    * */
    var params1 = {
      'locationId': SCConfig.locationId,
      'maxCount': 1,
      'communityId': SCScaffoldManager.instance.user.communityId ?? '',
    };
    var params2 = {
      'categoryId': SCConfig.categoryId,
      'maxCount': 10,
      'communityId': SCScaffoldManager.instance.user.communityId ?? '',
    };
    loadInforList(params2);
    loadPromotionList(params1);
    navigationOffset = topNavBGImageHeight;
  }

  refreshHomeData() {
    loadTemplateId();
    updateHomeData();

    var params1 = {
      'locationId': SCConfig.locationId,
      'maxCount': 1,
      'communityId': SCScaffoldManager.instance.user.communityId ?? '',
    };
    var params2 = {
      'categoryId': SCConfig.categoryId,
      'maxCount': 10,
      'communityId': SCScaffoldManager.instance.user.communityId ?? '',
    };
    loadInforList(params2);
    loadPromotionList(params1);
    loadUnreadMessageCount();
  }

  /// 更新首页数据
  updateHomeData() {
    String token = SCScaffoldManager.instance.user.token ?? "";
    String userId = SCScaffoldManager.instance.user.id ?? "";
    String userName =
        Uri.encodeComponent(SCScaffoldManager.instance.user.userName ?? '');
    String phoneNum = SCScaffoldManager.instance.user.mobileNum ?? '';
    int gender = SCScaffoldManager.instance.user.gender ?? 0;
    String city = SCScaffoldManager.instance.city;
    double longitude = SCScaffoldManager.instance.longitude;
    double latitude = SCScaffoldManager.instance.latitude;
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";

    String communityPayUrl =
        "${SCConfig.getH5Url(SCH5.communityPayUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String workOrderUrl =
        "${SCConfig.getH5Url(SCH5.workOrderUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String questionnaireUrl =
        "${SCConfig.getH5Url(SCH5.questionnaireUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String frequentlyMobileUrl =
        "${SCConfig.getH5Url(SCH5.frequentlyMobileUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String mallUrl =
        "${SCConfig.getH5Url(SCH5.mallUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String broowUrl =
        "${SCConfig.getH5Url(SCH5.broowUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String doorOutUrl =
        "${SCConfig.getH5Url(SCH5.doorOutUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String invitationUrl =
        "${SCConfig.getH5Url(SCH5.invitationUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";

    allItemsList = [
      {
        "iconUrl": SCAsset.iconItem1,
        "title": "物业缴费",
        "subUrl": communityPayUrl,
        "needHouseId": true
      },
      {
        "iconUrl": SCAsset.iconItem8,
        "title": "工单",
        "subUrl": workOrderUrl,
        "needHouseId": true
      },
      {
        "iconUrl": SCAsset.iconItem12,
        "title": "调查问卷",
        "subUrl": questionnaireUrl,
        "needHouseId": true
      },
      {
        "iconUrl": SCAsset.iconItem11,
        "title": "常用电话",
        "subUrl": frequentlyMobileUrl,
        "needHouseId": true
      },
      // {"iconUrl": SCAsset.iconItem13, "title": "商城购物", "subUrl": mallUrl, "needHouseId": true},
      // {"iconUrl": SCAsset.iconItem13, "title": "物品借用", "subUrl": broowUrl, "needHouseId": true},
      // {"iconUrl": SCAsset.iconItem15, "title": "物品出门", "subUrl": doorOutUrl, "needHouseId": true},
      // {"iconUrl": SCAsset.iconItem16, "title": "访客邀约", "subUrl": invitationUrl, "needHouseId": true},
    ];
    update();
  }

  /// 修改导航栏透状态
  void changeNavigationState({double offset = 0.0}) {
    if (offset > navigationOffset) {
      opacity = 0.0;
      navigationSticky = true;
    } else {
      opacity = 1.0;
      navigationSticky = false;
    }

    update();
  }

  /// 重置数据
  void resetAllData() {
    opacity = 1.0;
    navigationOffset = 64.0;
    navigationBackgroundColor = SCColors.color_FE8947;
    navigationSticky = false;
    navigationStickyColor = Colors.white;
    navigationNormalColor = Colors.white;
    update();
  }

  /// 修改项目名称
  changeCommunityName({required String name}) {
    if (name.isEmpty) {
      communityName = "请登录";
    } else {
      communityName = name;
    }
    update();
  }

  /// 获取pageTemplate
  loadPageTemplate(String id) {
    SCHttpManager.instance.get(
        url: SCUrl.pageTemplate,
        params: {"id": id},
        success: (value) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
          templateModel = SCHomeTemplateModel.fromJson(value);

          String fileKey = templateModel?.background?.fileKey ??
              ""; //value['background']['fileKey'];
          if (fileKey.isNotEmpty) {
            imageUrl = SCConfig.getImageUrl(fileKey);
          }

          // var info = List.from(
          //         List.from(templateModel?.pageDecorationList ?? [])
          //             .firstWhereOrNull((e) => e.code == 'home')
          //             ?.componentList)
          //     .firstWhereOrNull((e2) => e2.code == 'banner')
          //     ?.info;
          //
          // if (info != null && info.isNotEmpty) {
          //   dynamic binfoJson = jsonDecode(info);
          //   bannerInfo = BannerInfo.fromJson(binfoJson);
          //   var categoryId = bannerInfo?.categoryId;
          //   var maxCount = bannerInfo?.maxCount;
          //   var params = {
          //     'locationId': categoryId ?? 0,
          //     'maxCount': maxCount ?? '',
          //     'communityId': SCScaffoldManager.instance.user.communityId ?? '',
          //   };
          //   loadPromotionList(params);
          // }
          // var info2 = List.from(
          //         List.from(templateModel?.pageDecorationList ?? [])
          //             .firstWhereOrNull((e) => e.code == 'home')
          //             ?.componentList)
          //     .firstWhereOrNull((e2) => e2.code == 'information')
          //     ?.info;
          // if (info2 != null && info2.isNotEmpty) {
          //   dynamic binfoJson = jsonDecode(info2);
          //   inforInfo = InfoInfo.fromJson(binfoJson);
          //   var categoryId = inforInfo?.categoryId;
          //   var maxCount = inforInfo?.maxCount;
          //   var params = {
          //     'categoryId': categoryId ?? 0,
          //     'maxCount': maxCount ?? 0,
          //     'communityId': SCScaffoldManager.instance.user.communityId ?? '',
          //   };
          //   loadInforList(params);
          // }

        },
        failure: (err) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
          if (err['message'] != null) {
            String message = err['message'];
            SCToast.showTip(message);
          }
        });
  }

  /// 获取pageTemplateId
  loadTemplateId() {
    SCHttpManager.instance.get(
        url: SCUrl.getTemplateId,
        params: {"id": SCConfig.getTerminalId},
        success: (value) {
          loadPageTemplate(value?['templateId'] as String);
        },
        failure: (err) {
          if (err['message'] != null) {
            String message = err['message'];
            SCToast.showTip(message);
          }
        });
  }

  /// 推广列表不分页查询
  loadPromotionList(
    dynamic params,
  ) {
    log('11111111111');
    SCHttpManager.instance.post(
        url: SCUrl.getPromotionListUrl,
        params: params,
        success: (value) {

          promotionList = List<SCHomePromotionModel>.from(
              value.map((e) => SCHomePromotionModel.fromJson(e)).toList());
          promotionListFileKey = promotionList?.first?.pictures
                  ?.where((es) => es != null)
                  .map((e) => SCConfig.getImageUrl(e.fileKey!))
                  ?.toList() ??
              [];
          update();
        },
        failure: (err) {

          if (err['message'] != null) {
            String message = err['message'];
            SCToast.showTip(message);
          }
          promotionList = [];
          update();
        });
  }

  /// 资讯列表不分页查询
  loadInforList(
    dynamic params,
  ) {
    SCHttpManager.instance.post(
        url: SCUrl.getInforListUrl,
        params: params,
        success: (value) {
          inforList = List<SCHomeInforModel>.from(
              value.map((e) => SCHomeInforModel.fromJson(e)).toList());
          update();
        },
        failure: (err) {
          if (err['message'] != null) {
            String message = err['message'];
            SCToast.showTip(message);
          }
          inforList = [];
          update();
        });
  }

  /// 获取未读消息数量
  loadUnreadMessageCount() {
    SCHttpManager.instance.get(
        url: SCUrl.kMessageCountUrl,
        params: {'checked': false},
        success: (value) {
          if (value is int) {
            SCScaffoldManager.instance.unreadMessageCount = value;
            var params = {"key": SCKey.kReloadUnreadMessageCount};
            SCScaffoldManager.instance.eventBus.fire(params);
          }
        },
        failure: (value) {});
  }

  /// 获取房号列表，取第一个审核通过的房号为默认房号
  getCommunityId() {
    SCHttpManager.instance.get(
        url: SCUrl.kMyHouseUrl,
        success: (value) {
          List list = List<SCHouseListModel>.from(
              value.map((e) => SCHouseListModel.fromJson(e)).toList());
          for (int i = 0; i < list.length; i++) {
            SCHouseListModel model = list[i];
            if (model.examineStatus == 1) {
              //examineStatus审核状态, 0 审核中, 1 审核通过, 2 审核拒绝
              /// 存储communityId数据到SCUser
              SCUser scUser = SCScaffoldManager.instance.getUserData();
              scUser.communityId = model.communityId;
              scUser.spaceId = model.spaceId;
              SCScaffoldManager.instance.cacheUserData(scUser.toJson());
              refreshHomeData();
            }
          }
        },
        failure: (value) {});
  }

  @override
  onClose() {
    super.onClose();
    refreshController.dispose();
    scrollController.removeListener(() {});
    scrollController.dispose();
  }
}
