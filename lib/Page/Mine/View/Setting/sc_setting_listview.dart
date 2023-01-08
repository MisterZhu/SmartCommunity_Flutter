
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/View/Setting/sc_logout_cell.dart';
import 'package:smartcommunity/Page/Mine/View/Setting/sc_setting_cell.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_agreement.dart';
import '../../../../Constants/sc_default_value.dart';
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
          if (index == 1) {
            isLine = false;
          }
          return getLine(isLine);
        },
        itemCount: 3);
  }
  
  Widget getCell(int index) {
    if (index == 0) {
      return SCSettingCell(title: '关于我们', onTap: (){

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
      },);
    } else if (index == 2) {
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

  /// 注销
  Widget logoffCell() {
    return SCSettingCell(title: '注销账户',onTap: (){
      if (logoff != null) {
        logoff?.call();
      }
    },);
  }

  /// 退出登录cell
  Widget logoutCell() {
    return SCLogOutCell(onTap: (){
      logout();
    },);
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
