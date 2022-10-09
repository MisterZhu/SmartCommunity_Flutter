
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Mine/View/Setting/sc_logout_cell.dart';
import 'package:smartcommunity/page/Mine/View/Setting/sc_setting_cell.dart';
import 'package:smartcommunity/skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import '../../../Home/GetXController/sc_home_controller.dart';

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
          return getLine(index);
        },
        itemCount: 4);
  }
  
  Widget getCell(int index) {
    if (index == 0) {
      return normalCell();
    } else if(index == 1) {
      return normalCell();
    } else if(index == 2) {
      return logoffCell();
    }  else {
      return logoutCell();
    }
  }
  
  Widget getLine(int index) {
    if (index == 0 || index == 1) {
      return line();
    } else {
      return line10();
    }
  }

  /// cell
  Widget normalCell() {
    return SCSettingCell(title: '切换皮肤',onTap: (){
      SCHomeController state = Get.find<SCHomeController>();
      if (state.skinStyle == 0) {
        state.changeSkin(style: 1);
      } else {
        state.changeSkin(style: 0);
      }
      SCRouterHelper.back(null);
    },);
  }

  /// 注销
  Widget logoffCell() {
    return SCSettingCell(title: '注销账户',onTap: (){
      if (logoff != null) {
        logoff?.call();
      }
    },);
  }

  /// 退出
  Widget logoutCell() {
    return SCLogOutCell(onTap: (){
      SCScaffoldManager.instance.logout();
    },);
  }

  /// line
  Widget line() {
    return const Divider(
      height: 0.5,
      color: SCColors.color_EDEDF0,
    );
  }
  
  Widget line10() {
    return Container(
      height: 10.0,
      width: double.infinity,
      color: SCColors.color_EDEDF0,
    );
  }
}
