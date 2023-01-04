
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller2.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_nav1_controller.dart';
import 'package:smartcommunity/Page/Home/View/Skin2/sc_home_navigation2.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_float_login.dart';
import 'package:smartcommunity/Page/Mine/GetXController/sc_personal_info_controller.dart';
import 'package:smartcommunity/Skin/Model/sc_user.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../Service/GetXController/sc_service_controller.dart';
import '../View/Skin1/sc_home_skin1.dart';
import '../View/Skin2/sc_home_skin2.dart';

/// 首页-page

class SCHomePage extends StatefulWidget {
  @override
  SCHomeState createState() => SCHomeState();
}

class SCHomeState extends State<SCHomePage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  SCHomeController state = Get.put(SCHomeController());
  SCHomeController1 state1 = Get.put(SCHomeController1());
  SCHomeController2 state2 = Get.put(SCHomeController2());
  SCServiceController service = Get.put(SCServiceController());
  SCPersonalInfoController personalInfoController = Get.put(SCPersonalInfoController());
  SCHomeNav1Controller nav1State = Get.put(SCHomeNav1Controller());

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  dispose() {
    super.dispose();
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
        return skin1();
      } else if (state.skinStyle == 1) {
        return skin2();
      } else {
        return skin1();
      }
    });
  }

  /// skin1
  Widget skin1() {
    return SCHomeSkin1();
  }

  /// skin2
  Widget skin2() {
    return SCHomeSkin2();
  }

  /// 登录悬浮窗
  Widget floatLoginWidget() {
    return Visibility(
      visible: !SCScaffoldManager.instance.isLogin,
      child: SCHomeFloatLogin(
        onTap: (){
          SCRouterHelper.presentLoginPage();
      },
    ));
  }

  /// 获取用户信息
  getUserInfo() {
    if (SCScaffoldManager.instance.isLogin) {
      personalInfoController.getUserInfo(updateAll: false, successHandler: (){
        state.update();
      });
    }
  }

  /// 获取首页数据
  getHomeInfo() {
    state1.getHomeInfo();
  }
}
