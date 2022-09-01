

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Model/sc_current_house_info_model.dart';
import '../Model/sc_current_house_review_model.dart';

class SCCurrentHouseController extends GetxController {

  int selectIndex = 0;

  List<SCCurrentHouseReviewModel>? reviewList = [];

  List<SCCurrentHouseReviewModel>? notReviewList = [];

  late SCCurrentHouseInfoModel infoModel;

  @override
  onInit() {
    super.onInit();
    var info = {'id': '0',
      'houseNumber': '慧享生活馆-小邑苑-11幢-1单元-101室',
      'houseType': 1,
      'owner': '张三',
      'identity': 1,
      'endDate': '2033-5-11',
    };

    infoModel = SCCurrentHouseInfoModel.fromJson(info);


    var testList = [
      {'id': '0', 'name': '旺旺', 'mobile': '132111111111', 'endDate':'2033-5-11','type':1},
      {'id': '1', 'name': '丽丽', 'mobile': '13312233223', 'endDate':'2033-5-11','type':2},
    ];


    var testList2 = [
      {'id': '0', 'name': '你好', 'mobile': '1331111111', 'endDate':'2033-5-11','type':1},
      {'id': '1', 'name': '未审核', 'mobile': '1341111111', 'endDate':'2033-5-11','type':2},
      {'id': '2', 'name': '周年', 'mobile': '1552111111', 'endDate':'2033-5-11','type':2},
      {'id': '3', 'name': '周一', 'mobile': '1561111111', 'endDate':'2033-5-11','type':1},
      {'id': '4', 'name': '周末', 'mobile': '1581111111', 'endDate':'2033-5-11','type':3},
      {'id': '6', 'name': '周二', 'mobile': '16511111111', 'endDate':'2033-5-11','type':3},
    ];

    reviewList = testList.map((e) => SCCurrentHouseReviewModel.fromJson(e)).toList();

    notReviewList = testList2.map((e) => SCCurrentHouseReviewModel.fromJson(e)).toList();

  }


  /// 更新编辑状态
  updateSelectIndex(int index) {
    selectIndex = index;
    update();
  }

}