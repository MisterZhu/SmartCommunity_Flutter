/// 首页皮肤2-GetxController
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Constants/sc_h5.dart';
import 'package:smartcommunity/Constants/sc_skin_value.dart';
import 'package:smartcommunity/Page/Home/Model/sc_home_news_model.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../../Constants/sc_default_value.dart';
import '../../../Constants/sc_key.dart';
import '../../../Constants/sc_type_define.dart';
import '../../../Network/sc_config.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
// import 'package:image_cropper/image_cropper.dart';

class SCHomeController2 extends GetxController {

  /// 背景图片scale
  double topNavBGImageScale = 782.0 / 384.0;
  /// 背景图片高度
  double topNavBGImageHeight = 168.0 - (SCUtils().getTopSafeArea() > 20 ? 0.0 : 30.0);

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

  /// 资讯list
  List<SCHomeNewsModel>? allNewsList;

  RefreshController refreshController = RefreshController(initialRefresh: false);

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
    allNewsList = List.from(homeNewsList)
        .map((e) => SCHomeNewsModel.fromJson(e))
        .toList();
    listViewData =  [
      /// banner
      {'type': SCTypeDefine.SC_HOME_TYPE_BANNER, 'data': []},

      /// 应用列表
      {'type': SCTypeDefine.SC_HOME_TYPE_ALLITEMS, 'data': []},

      /// 园区活动1
      {'type': SCTypeDefine.SC_HOME_TYPE_COMMUNITY1, 'data': []},
      /// 园区活动2
      {'type': SCTypeDefine.SC_HOME_TYPE_COMMUNITY2, 'data': []},

      /// 热门活动1
      {'type': SCTypeDefine.SC_HOME_TYPE_LIFE1, 'data': []},
      /// 热门活动2
      {'type': SCTypeDefine.SC_HOME_TYPE_LIFE2, 'data': []},
      /// 精选商品
      {'type': SCTypeDefine.SC_HOME_TYPE_GOODS, 'data': []},
    ];
    navigationOffset = 44.0 + SCUtils().getTopSafeArea();
    updateHomeData();
    loadTemplateId();
    navigationOffset = topNavBGImageHeight;
  }


  /// 更新首页数据
  updateHomeData() {
    String token = SCScaffoldManager.instance.user.token ?? "";
    String userId = SCScaffoldManager.instance.user.id ?? "";
    String userName = Uri.encodeComponent(SCScaffoldManager.instance.user.userName ?? '');
    String phoneNum = SCScaffoldManager.instance.user.mobileNum ?? '';
    int gender = SCScaffoldManager.instance.user.gender ?? 0;
    String city = SCScaffoldManager.instance.city;
    double longitude = SCScaffoldManager.instance.longitude;
    double latitude = SCScaffoldManager.instance.latitude;
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";

    String communityPayUrl = "${SCConfig.getH5Url(SCH5.communityPayUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String workOrderUrl = "${SCConfig.getH5Url(SCH5.workOrderUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String questionnaireUrl = "${SCConfig.getH5Url(SCH5.questionnaireUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String frequentlyMobileUrl = "${SCConfig.getH5Url(SCH5.frequentlyMobileUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String mallUrl = "${SCConfig.getH5Url(SCH5.mallUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String broowUrl = "${SCConfig.getH5Url(SCH5.broowUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String doorOutUrl = "${SCConfig.getH5Url(SCH5.doorOutUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";
    String invitationUrl = "${SCConfig.getH5Url(SCH5.invitationUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&defCommunityId=$defCommunityId";

    allItemsList = [
      {"iconUrl": SCAsset.iconItem1, "title": "物业缴费", "subUrl": communityPayUrl, "needHouseId": true},
      {"iconUrl": SCAsset.iconItem8, "title": "工单", "subUrl": workOrderUrl, "needHouseId": true},
      {"iconUrl": SCAsset.iconItem12, "title": "调查问卷", "subUrl": questionnaireUrl, "needHouseId": true},
      {"iconUrl": SCAsset.iconItem11, "title": "常用电话", "subUrl": frequentlyMobileUrl, "needHouseId": true},
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
  loadPageTemplate(String id){
    SCHttpManager.instance.get(
      url:SCUrl.pageTemplate,
      params: {"id":id},
      success: (value){
        log("获取的模版：${value}");
      },
      failure: (err){}
    );
  }

  /// 获取pageTemplateId
  loadTemplateId() {
    SCHttpManager.instance.get(
      url:SCUrl.getTemplateId,
      params: {"id":SCConfig.getTerminalId()},
      success: (value){
        if(value){
          loadPageTemplate(value?.templateId as String);
        }
      },
      failure: (err){}
    );
  }

  /// 获取未读消息数量
  loadUnreadMessageCount() {
    SCHttpManager.instance.get(
        url: SCUrl.kMessageCountUrl,
        params: {'checked': false},
        success: (value) {
          if (value is int) {
            SCScaffoldManager.instance.unreadMessageCount = value;
            var params = {"key" : SCKey.kReloadUnreadMessageCount};
            SCScaffoldManager.instance.eventBus.fire(params);
          }
        },
        failure: (value) {
        });
  }

  @override
  onClose() {
    super.onClose();
    refreshController.dispose();
    scrollController.removeListener(() { });
    scrollController.dispose();
  }

}