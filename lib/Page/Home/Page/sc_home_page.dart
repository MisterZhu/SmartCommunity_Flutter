import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller2.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_nav1_controller.dart';
import 'package:smartcommunity/Page/Home/View/Skin2/sc_home_navigation2.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_float_login.dart';
import 'package:smartcommunity/Page/Login/Model/SelectCommunity/sc_location_model.dart';
import 'package:smartcommunity/Page/Mine/GetXController/sc_personal_info_controller.dart';
import 'package:smartcommunity/Skin/Model/sc_user.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Skin/Tools/sc_skin_config.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:smartcommunity/Utils/Permission/sc_location_utils.dart';
import 'package:smartcommunity/Utils/Permission/sc_permission_utils.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../Service/GetXController/sc_service_controller.dart';
import '../../Tab/Page/sc_tab_page.dart';
import '../View/Skin1/sc_home_skin1.dart';
import '../View/Skin2/sc_home_skin2.dart';

/// 首页-page

class SCHomePage extends StatefulWidget {
  @override
  SCHomeState createState() => SCHomeState();
}

class SCHomeState extends State<SCHomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  SCHomeController state = Get.put(SCHomeController());
  SCHomeController1 state1 = Get.put(SCHomeController1());
  SCHomeController2 state2 = Get.put(SCHomeController2());
  SCServiceController service = Get.put(SCServiceController());
  SCPersonalInfoController personalInfoController =
      Get.put(SCPersonalInfoController());
  SCHomeNav1Controller nav1State = Get.put(SCHomeNav1Controller());

  /// 通知
  late StreamSubscription notification;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  dispose() {
    super.dispose();
    notification.cancel();
  }

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
    if (SCScaffoldManager.instance.user.communityName != null) {
      state2.communityName = SCScaffoldManager.instance.user.communityName!;
      nav1State.communityName = SCScaffoldManager.instance.user.communityName!;
    }

    /// 获取用户信息
    getUserInfo();

    /// 获取首页数据
    getHomeInfo();

    /// 定位
    location();
    addNotification();
  }

  /// body
  Widget body() {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Container(
            color: SCColors.color_F5F5F5,
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                skin(),
                floatLoginWidget(),
              ],
            ),
          ),
        ));
  }

  /// 皮肤
  Widget skin() {
    return GetBuilder<SCHomeController>(builder: (state) {
      if (state.skinStyle == 0) {
        return skin2();
      } else if (state.skinStyle == 1) {
        return skin2();
      } else {
        return skin2();
      }
    });
  }

  /// skin1
  Widget skin1() {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<SCHomeController1>(builder: (state) {
          return SCHomeSkin1(
            getUserInfoAction: () {
              state1.loadUnreadMessageCount();
              getUserInfo();
            },
          );
        }));
  }

  /// skin2
  Widget skin2() {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<SCHomeController2>(builder: (state) {
          return SCHomeSkin2( getUserInfoAction: () {
            state2.loadUnreadMessageCount();
            state2.loadTemplateId();
            getUserInfo();
          },);
        })
    );
  }


  /// 登录悬浮窗
  Widget floatLoginWidget() {
    return Visibility(
        visible: !SCScaffoldManager.instance.isLogin,
        child: SCHomeFloatLogin(
          onTap: () {
            SCRouterHelper.presentLoginPage();
          },
        ));
  }

  /// 获取用户信息
  getUserInfo() {
    if (SCScaffoldManager.instance.isLogin) {
      personalInfoController.getUserInfo(
          updateAll: false,
          successHandler: () {
            state1.updateHomeData();
            state.update();
          });
    }
  }

  /// 获取首页数据
  getHomeInfo() {
    /// 获取装修数据
    SCSkinConfig.getVisitorDecorationData(successHandler: () {
      state1.updateHomeDecorationData();
    });
  }

  /// 定位
  location() {
    SCPermissionUtils.startLocationWithPrivacyAlert(
        completionHandler: (var result, SCLocationModel? model) {
      int status = result['status'];
      if (status == 1) {
        var data = result['data'];
        double longitude = data['longitude'];
        double latitude = data['latitude'];
        String city = data['city'];
        SCScaffoldManager.instance.longitude = longitude;
        SCScaffoldManager.instance.latitude = latitude;
        SCScaffoldManager.instance.city = city;
      } else {}
    });
  }

  /// 通知
  addNotification() {
    notification = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kReloadUserInfo) {
        getUserInfo();
      } else if (key == SCKey.kReloadUnreadMessageCount) {
        // state.update();
        state2.update();
      } else if (key == SCKey.kRefreshHomeData) {
        state2.refreshHomeData();
      }
    });
  }
}
