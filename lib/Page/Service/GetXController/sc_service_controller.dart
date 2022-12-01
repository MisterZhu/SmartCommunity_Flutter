
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Constants/sc_asset.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../../../Skin/Model/sc_user.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Model/sc_service_module_model.dart';

class SCServiceController extends GetxController {

  /// 首页应用是否展开，默认展开
  bool isExpansion = true;

  /// 是否正在编辑，默认不编辑
  bool isEditing = false;

  /// 常用应用列表
  late SCServiceModuleModel regularModuleModel;
  /// 数据
  List<SCServiceModuleModel> moduleList = [];

  /// 皮肤样式,默认第一套
  int skinStyle = 0;

  int currentIndex = 0;

  /// 第二套皮肤的pageController
  PageController pageController = PageController();

  @override
  onInit() {
    super.onInit();
  }

  loadTestData() {
    testData();
  }

  addRegularAppData() {
    var homeTestList = [
      {"icon": {"fileKey": "", "name": SCAsset.iconServiceQrCode}, "id": "1", "name": "业主二维码"},
      {"icon": {"fileKey": "", "name": SCAsset.iconServiceCar}, "id": "2", "name": "公务用车"},
      {"icon": {"fileKey": "", "name": SCAsset.iconServiceCar}, "id": "101", "name": "建信租房"}
    ];
    var regularData = {"module": {"id": "0", "name": "常用应用"}, "applets": homeTestList};
    regularModuleModel = SCServiceModuleModel.fromJson(regularData);
    moduleList.insert(0, regularModuleModel);
  }

  testData() {
    moduleList = [];

    var testList = [
      {"applets": [
        {"icon": {"fileKey": "", "name": SCAsset.iconServiceQrCode},"id": "1","name": "业主二维码"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCar},"id": "2","name": "公务用车"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceSchedule,},"id": "12","name": "工单调度"},
        {"icon": {"fileKey": "", "name": SCAsset.iconServiceDiscount},"id": "13","name": "权益优惠"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceSurrounding},"id": "14","name": "周边楼盘"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceSchedule,},"id": "15","name": "物业缴费"},
      ],"module": {"id": "1", "name": "物业管家"}
      },
      {"applets": [
        {"icon": {"fileKey": "","name": SCAsset.iconServiceIntegral},"id": "21","name": "积分管理哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceReport},"id": "22","name": "报事报修哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServicePay},"id": "23","name": "小区缴费哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceFinance},"id": "24","name": "家庭理财哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "25","name": "社区社群哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "26","name": "智慧社区哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "27","name": "智慧街道哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "28","name": "社区游玩哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "29","name": "智慧出行哦"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "20","name": "智慧预约哦"},
      ],"module": {"id": "2","name": "智慧应用"}
      },
      {"applets": [
        {"icon": {"fileKey": "","name": SCAsset.iconServiceReport},"id": "31","name": "企业周报"},
        {"icon": {"fileKey": "","name": SCAsset.iconServicePay},"id": "32","name": "企业年报"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceFinance},"id": "33","name": "企业周年"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "34","name": "企业工会"}
      ],"module": {"id": "2","name": "企业服务"}
      },
      {"applets": [
        {"icon": {"fileKey": "","name": SCAsset.iconServiceReport},"id": "40","name": "校园宽带"},
        {"icon": {"fileKey": "","name": SCAsset.iconServicePay},"id": "41","name": "校园缴费"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceFinance},"id": "42","name": "校园食堂"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "43","name": "校园停车"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "44","name": "校园借书"}
      ],"module": {"id": "2","name": "校园服务"}
      },
    ];
    moduleList = testList.map((e) => SCServiceModuleModel.fromJson(e)).toList();
    addRegularAppData();
  }

  /// 获取应用列表数据
  loadAppListData() {
    moduleList = [];
    SCUser user = SCScaffoldManager.instance.getUserData();
    String? housingId = user.housingId;
    SCHttpManager.instance.get(
        url: SCUrl.kServiceAppListUrl,
        params: {
          'housingId' : housingId,
        },
        success: (value) {
          List<SCServiceModuleModel> dataList = List<SCServiceModuleModel>.from(value.map((e) => SCServiceModuleModel.fromJson(e)).toList());
          updateModuleList(list: dataList);
        },
        failure: (value) {
          log('appList失败===$value');

        });
  }

  /// 更新数据源
  updateModuleList({required List<SCServiceModuleModel> list}) {
    moduleList = list;
    update();
  }

  /// 更新常用应用展开状态
  updateExpansionStatus() {
    isExpansion = !isExpansion;
    update();
  }

  /// 更新编辑状态
  updateEditStatus() {
    isEditing = !isEditing;
    update();
  }

  /// 移除首页应用
  deleteRegularApp(Applets model) {
    regularModuleModel.applets?.remove(model);
    update();
  }

  /// 添加常用应用
  addRegularApp(Applets model) {
    regularModuleModel.applets?.add(model);
    update();
  }

  /// 切换皮肤
  changeSkin({required int style}) {
    skinStyle = style;
    isEditing = false;
    update();
  }

  updateCurrentIndex({required int index}) {
    currentIndex = index;
    update();
  }


}
