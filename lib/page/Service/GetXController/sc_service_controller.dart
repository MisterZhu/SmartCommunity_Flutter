
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
  List<Applets> regularAppList = [];
  /// 应用列表
  List<SCServiceModuleModel> appList = [];

  /// 皮肤样式,默认第一套
  int skinStyle = 0;

  @override
  onInit() {
    super.onInit();
    testData();
  }

  addRegularAppData() {
    var homeTestList = [
      {
        "icon": {
          "fileKey": "",
          "name": SCAsset.iconServiceQrCode,
          "size": 0,
          "suffix": "",
          "type": 0
        },
        "id": "1",
        "name": "业主二维码"
      },{
        "icon": {
          "fileKey": "",
          "name": SCAsset.iconServiceCar,
          "size": 0,
          "suffix": "",
          "type": 0
        },
        "id": "2",
        "name": "公务用车"
      }
    ];

    regularAppList = homeTestList.map((e) => Applets.fromJson(e)).toList();

    var regularData = {"module": {"id": "0", "name": "常用应用"}, "applets": []};
    SCServiceModuleModel regularModel = SCServiceModuleModel.fromJson(regularData);
    appList.insert(0, regularModel);

  }

  testData() {
    var testList = [
      {
        "applets": [
          {
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServiceQrCode,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "1",
            "name": "业主二维码"
          },{
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServiceCar,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "2",
            "name": "公务用车"
          },
          {
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServiceSchedule,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "3",
            "name": "工单调度"
          },{
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServiceDiscount,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "4",
            "name": "权益优惠"
          },
          {
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServiceSurrounding,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "5",
            "name": "周边楼盘"
          }
        ],
        "module": {
          "id": "1",
          "name": "物业管家"
        }
      },
      {
        "applets": [
          {
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServiceReport,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "6",
            "name": "报事报修"
          },{
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServicePay,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "7",
            "name": "小区缴费"
          },
          {
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServiceFinance,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "8",
            "name": "家庭理财"
          },
          {
            "icon": {
              "fileKey": "",
              "name": SCAsset.iconServiceCommunity,
              "size": 0,
              "suffix": "",
              "type": 0
            },
            "id": "9",
            "name": "社区社群"
          }
        ],
        "module": {
          "id": "2",
          "name": "智慧应用"
        }
      }
    ];

    appList = testList.map((e) => SCServiceModuleModel.fromJson(e)).toList();
    addRegularAppData();
  }

  /// 获取应用列表数据
  loadAppListData() {
    SCUser user = SCScaffoldManager.instance.getUserData();
    String? housingId = user.housingId;
    SCHttpManager.instance.get(
        url: SCUrl.kServiceAppListUrl,
        params: {
          'housingId' : housingId,
        },
        success: (value) {
          List<SCServiceModuleModel> dataList = List<SCServiceModuleModel>.from(value.map((e) => SCServiceModuleModel.fromJson(e)).toList());
          updateAppList(list: dataList);
        },
        failure: (value) {
          log('appList失败===$value');

        });
  }

  /// 更新数据源
  updateAppList({required List<SCServiceModuleModel> list}) {
    appList = list;
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
    regularAppList.remove(model);
    update();
  }

  /// 添加常用应用
  addRegularApp(Applets model) {
    regularAppList.add(model);
    update();
  }

  /// 切换皮肤
  changeSkin({required int style}) {
    skinStyle = style;
    update();
  }

}
