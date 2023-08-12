
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/View/Setting/sc_logout_cell.dart';
import 'package:smartcommunity/Page/Mine/View/Setting/sc_setting_cell.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_agreement.dart';
import '../../../../Constants/sc_default_value.dart';
import '../../../../Constants/sc_h5.dart';
import '../../../../Network/sc_config.dart';
import '../../../../Utils/Device/sc_device_utils.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../Home/GetXController/sc_home_controller.dart';
import '../../GetXController/sc_setting_controller.dart';

/// 设置listview

class SCSettingListView extends StatelessWidget {

  final Function? logoff;

  const SCSettingListView({Key? key, this.logoff}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          bool isLine = true;
          if (index == 2 || index == 3) {
            isLine = false;
          }
          return getLine(isLine);
        },
        itemCount: 5);
  }
  
  Widget getCell(int index) {
    if (index == 0) {
      return SCSettingCell(title: '关于我们', onTap: (){
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"url": SCH5.aboutH5Url, 'title': '关于'});
      },);
    // } else if (index == 1) {
    //   return SCSettingCell(title: '用户协议', onTap: (){
    //     var params = {'title' : '用户协议', 'url' : SCAgreement.userAgreementUrl};
    //     SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
    //   },);
    // } else if (index == 2) {
    //   return SCSettingCell(title: '隐私政策', onTap: (){
    //     var params = {'title' : '隐私政策', 'url' : SCAgreement.privacyProtocolUrl};
    //     SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
    //   },);
    } else if (index == 1) {
      return SCSettingCell(title: '账号管理', onTap: (){
        SCToast.showTip('功能开发中');
      },);
    } else if (index == 2) {
      return SCSettingCell(title: '功能反馈', onTap: (){
        feedBack();
      },);
    } else if (index == 3) {
      return logOffCell();
    }  else if (index == 4) {
      return logoutCell();
    } else {
      return const SizedBox(height: 100.0,);
    }
  }
  
  Widget getLine(bool isLine) {
    if (isLine) {
      return line();
    } else {
      return line10();
    }
  }

  // /// 注销
  // Widget logoffCell() {
  //   return SCSettingCell(title: '注销账户',onTap: (){
  //     unsubscribe();
  //   },);
  // }
  /// 注销cell
  Widget logOffCell() {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(0.0),
          child: const Text(
            "注销",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w500,
                color: SCColors.color_4285F4),
          ),
          onPressed: () {
            unsubscribe();
          }),
    );
  }
  /// 退出登录cell
  Widget logoutCell() {
    return SCLogOutCell(onTap: (){
      logout();
    },);
  }

  /// 注销账户
  unsubscribe() {
    BuildContext? context = Get.context!;
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      title: '注销提示',
      content: SCDefaultValue.logOffTip,
      customWidgetButtons: [
        defaultCustomButton(context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        defaultCustomButton(context,
            text: '确定',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400, onTap: () {
              SCSettingController state = Get.find<SCSettingController>();
              state.logOff(resultHandler: (status) {
                if (status == true) {
                  SCScaffoldManager.instance.logout();
                }
              });
            }),
      ],
    );

  }
  /// 退出登录
  logout() {
    SCSettingController state = Get.find<SCSettingController>();
    state.logout(resultHandler: (status) {
      if (status == true) {
        SCScaffoldManager.instance.logout();
      }
    });
  }
  /// 功能反馈
  feedBack() {
    String token = SCScaffoldManager.instance.user.token ?? "";
    String userId = SCScaffoldManager.instance.user.id ?? "";
    String userName = Uri.encodeComponent(SCScaffoldManager.instance.user.userName ?? '');
    String phoneNum = SCScaffoldManager.instance.user.mobileNum ?? '';
    int gender = SCScaffoldManager.instance.user.gender ?? 0;
    String city = SCScaffoldManager.instance.city;
    double longitude = SCScaffoldManager.instance.longitude;
    double latitude = SCScaffoldManager.instance.latitude;
    print("功能反馈");
    SCDeviceUtils.getDeviceInfo(result: (value){
      String device = value['machine'] + "," + value['systemName'] + "," + value['systemVersion'];
      String terminalName = Uri.encodeComponent(value['appName']);
      String terminalVersion = value['version'];
      device = device.replaceAll(RegExp(r"\s+\b|\b\s"), "");
      String url = "${SCConfig.getH5Url(SCH5.feedBackUrl)}?Authorization=$token&client=${SCDefaultValue.client}&userId=$userId&userName=$userName&phoneNum=$phoneNum&city=${Uri.encodeComponent(city)}&latitude=$latitude&longitude=$longitude&gender=$gender&device=$device&terminalName=$terminalName&terminalVersion=$terminalVersion";
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"title" : "功能反馈", "url" : url});
    });
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }
  
  Widget line10() {
    return Container(
      height: 8.0,
      width: double.infinity,
      color: SCColors.color_F5F5F5,
    );
  }
}
