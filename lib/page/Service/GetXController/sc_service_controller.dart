
import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../constants/sc_asset.dart';
import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../skin/Model/sc_user.dart';
import '../../../skin/Tools/sc_scaffold_manager.dart';
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
  int skinStyle = 1;

  int currentIndex = 0;

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
      {"icon": {"fileKey": "", "name": SCAsset.iconServiceCar}, "id": "2", "name": "公务用车"}
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
        {"icon": {"fileKey": "","name": SCAsset.iconServiceSchedule,},"id": "3","name": "工单调度"},
        {"icon": {"fileKey": "", "name": SCAsset.iconServiceDiscount},"id": "4","name": "权益优惠"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceSurrounding},"id": "5","name": "周边楼盘"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceSchedule,},"id": "6","name": "物业缴费"},
      ],"module": {"id": "1", "name": "物业管家"}
      },
      {"applets": [
        {"icon": {"fileKey": "","name": SCAsset.iconServiceIntegral},"id": "61","name": "积分管理1"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceReport},"id": "62","name": "报事报修2"},
        {"icon": {"fileKey": "","name": SCAsset.iconServicePay},"id": "63","name": "小区缴费3"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceFinance},"id": "64","name": "家庭理财4"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "65","name": "社区社群5"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "66","name": "智慧社区6"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "67","name": "智慧街道7"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "7","name": "智慧园区8"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "8","name": "智慧手机9"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "9","name": "智慧游玩11"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "10","name": "智慧出行12"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "11","name": "智慧党群13"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceIntegral},"id": "12","name": "积分管理14"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceReport},"id": "13","name": "报事报修15"},
        {"icon": {"fileKey": "","name": SCAsset.iconServicePay},"id": "14","name": "小区缴费16"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceFinance},"id": "15","name": "家庭理财17"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "16","name": "社区社群18"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "17","name": "智慧社区19"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "18","name": "智慧街道20"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "19","name": "智慧园区21"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "20","name": "智慧手机22"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "21","name": "智慧游玩23"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "22","name": "智慧出行24"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "23","name": "智慧党群25"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceIntegral},"id": "24","name": "积分管理26"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceReport},"id": "25","name": "报事报修27"},
        {"icon": {"fileKey": "","name": SCAsset.iconServicePay},"id": "26","name": "小区缴费28"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceFinance},"id": "27","name": "家庭理财29"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "28","name": "社区社群30"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "29","name": "智慧社区31"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "30","name": "智慧街道32"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "31","name": "智慧园区33"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "32","name": "智慧手机34"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "33","name": "智慧游玩35"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "34","name": "智慧出行36"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "35","name": "智慧党群37"},
      ],"module": {"id": "2","name": "智慧应用"}
      },
      {"applets": [
        {"icon": {"fileKey": "","name": SCAsset.iconServiceReport},"id": "36","name": "企业周报"},
        {"icon": {"fileKey": "","name": SCAsset.iconServicePay},"id": "37","name": "企业年报"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceFinance},"id": "38","name": "企业周年"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "39","name": "企业工会"}
      ],"module": {"id": "2","name": "企业服务"}
      },
      {"applets": [
        {"icon": {"fileKey": "","name": SCAsset.iconServiceReport},"id": "46","name": "校园宽带"},
        {"icon": {"fileKey": "","name": SCAsset.iconServicePay},"id": "47","name": "校园缴费"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceFinance},"id": "48","name": "校园食堂"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "49","name": "校园教师"},
        {"icon": {"fileKey": "","name": SCAsset.iconServiceCommunity},"id": "50","name": "校园借书"}
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
