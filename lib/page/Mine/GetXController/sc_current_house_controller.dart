import 'dart:developer';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smartcommunity/page/Mine/Model/Sc_current_house_info_data_model.dart';
import 'package:smartcommunity/skin/Model/sc_user.dart';
import 'package:smartcommunity/skin/Tools/sc_scaffold_manager.dart';
import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../utils/Loading/sc_loading_utils.dart';
import '../../../utils/Toast/sc_toast.dart';
import '../Model/sc_current_house_info_model.dart';
import '../Model/sc_current_house_review_model.dart';

class SCCurrentHouseController extends GetxController {
  int selectReviewIndex = 0;
  List<SCCurrentHouseReviewModel>? reviewList = [];

  List<SCCurrentHouseReviewModel>? notReviewList = [];

  late ScCurrentHouseInfoDataModel infoModel;

  late bool hadData = false;
  @override
  onInit() {
    super.onInit();
    var info = {
      'id': '0',
      'houseNumber': '慧享生活馆-小邑苑-11幢-1单元-101室',
      'houseType': 1,
      'owner': '张三',
      'identity': 1,
      'endDate': '2033-5-11',
    };

    // infoModel = SCCurrentHouseInfoModel.fromJson(info);

    var testList = [
      {
        'id': '0',
        'name': '旺旺',
        'mobile': '132111111111',
        'endDate': '2033-5-11',
        'type': 1
      },
      {
        'id': '1',
        'name': '丽丽',
        'mobile': '13312233223',
        'endDate': '2033-5-11',
        'type': 2
      },
    ];

    var testList2 = [
      {
        'id': '0',
        'name': '你好',
        'mobile': '1331111111',
        'endDate': '2033-5-11',
        'type': 1
      },
      {
        'id': '1',
        'name': '未审核',
        'mobile': '1341111111',
        'endDate': '2033-5-11',
        'type': 2
      },
      {
        'id': '2',
        'name': '周年',
        'mobile': '1552111111',
        'endDate': '2033-5-11',
        'type': 2
      },
      {
        'id': '3',
        'name': '周一',
        'mobile': '1561111111',
        'endDate': '2033-5-11',
        'type': 1
      },
      {
        'id': '4',
        'name': '周末',
        'mobile': '1581111111',
        'endDate': '2033-5-11',
        'type': 3
      },
      {
        'id': '6',
        'name': '周二',
        'mobile': '16511111111',
        'endDate': '2033-5-11',
        'type': 3
      },
    ];

    reviewList =
        testList.map((e) => SCCurrentHouseReviewModel.fromJson(e)).toList();

    notReviewList =
        testList2.map((e) => SCCurrentHouseReviewModel.fromJson(e)).toList();
  }

  /// 更新点击的按钮index
  updateSelectIndex(int index) {
    selectReviewIndex = index;
    update();
  }

  updateHadData(bool status) {
    hadData = status;
    update();
  }

  loadCurrentHouseData() {
    SCLoadingUtils.show();
    // 取当前房号Id
   SCUser scUser = SCScaffoldManager.instance.getUserData();
   String? housingId = scUser.housingId;
   log('housingId  $housingId');
    var params = {
      'housingId': housingId
    };
    SCHttpManager.instance.get(
        url: SCUrl.kCurrentHouseInfoUrl,
        params: params,
        success: (value) {
          updateHadData(true);
          log('当前房屋详情===$value');
          var json = {
            "adoptMembers": [
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "房东",
                "identityId": "1",
                "name": "小王",
                "phone": "18700001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "代理人",
                "identityId": "2",
                "name": "xiaoli",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "租客",
                "identityId": "3",
                "name": "xiaozhu",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "业主",
                "identityId": "4",
                "name": "xiaozhu",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "家属",
                "identityId": "5",
                "name": "xiaozhu",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "其他",
                "identityId": "6",
                "name": "xiaozhu",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              }
            ],
            "householders": [],
            "housing": {
              "id": "112111271725101",
              "residentId": "112034494947101",
              "communityId": "38f258cd-89c7-11ea-bf80-005056b167dc",
              "communityName": null,
              "spaceId": 110001674,
              "spaceName": "海滨项目->测苑->1幢->1单元->101室",
              "identityId": "107969136049704",
              "identity": "",
              "relation": 9,
              "isPayer": 2,
              "residenceCertificate": {
                "fileKey": null,
                "name": null,
                "suffix": null,
                "size": null,
                "type": 1
              },
              "gmtJoin": null,
              "gmtCheckIn": null,
              "gmtDecorate": null,
              "gmtQuit": null,
              "gmtLiveStart": null,
              "gmtLiveEnd": null,
              "enterprise": null
            },
            "spaceType": "普通住房23",
            "underReviewMembers": [
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "房东",
                "identityId": "1",
                "name": "小王",
                "phone": "18700001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "代理人",
                "identityId": "2",
                "name": "xiaoli",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "租客",
                "identityId": "3",
                "name": "xiaozhu",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "业主",
                "identityId": "4",
                "name": "xiaozhu",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "家属",
                "identityId": "5",
                "name": "xiaozhu",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              },
              {
                "examineStatus": 0,
                "gmtLiveEnd": "2025-01-01",
                "gmtLiveStart": "2022-01-01",
                "housingId": "111",
                "identity": "其他",
                "identityId": "6",
                "name": "xiaozhu",
                "phone": "18710001111",
                "relation": 0,
                "residentId": ""
              }
            ]
          };
          infoModel = ScCurrentHouseInfoDataModel.fromJson(json);
          // infoModel = ScCurrentHouseInfoDataModel.fromJson(value);
        },
        failure: (value) {
          String message = value['message'];
        });
  }

  /// 确认通过
  confirmPass(){
    SCHttpManager.instance.put(
        url: SCUrl.kExaminePass,
        params: {'housingId': ''},
        success: (value) {},
        failure: (value) {
          String message = value['message'];
        });
  }

  /// 确认拒绝
  confirmReject(){
    SCHttpManager.instance.put(
        url: SCUrl.kExamineReject,
        params: {'housingId': ''},
        success: (value) {},
        failure: (value) {
          String message = value['message'];
        });
  }

  /// 解除绑定房号接口
    unBindHouse({required Function(bool success) resultHandler}) {
    SCUser scUser = SCScaffoldManager.instance.getUserData();
    String? housingId = scUser.housingId;
    SCHttpManager.instance.delete(
        url: SCUrl.kUnbindHouseUrl,
        params: {'housingId': housingId},
        success: (value) {
          SCToast.showTip('解绑成功');
          update();
          resultHandler(true);
        },
        failure: (value) {
          String? message = value['message'];
          if (message != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          resultHandler(false);
        });
  }
}
