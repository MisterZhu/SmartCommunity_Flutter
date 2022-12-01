
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
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
          if (index == 3 || index == 7 || index == 11) {
            isLine = false;
          }
          return getLine(isLine);
        },
        itemCount: 14);
  }
  
  Widget getCell(int index) {
    if (index == 0) {
      return SCSettingCell(title: '切换皮肤', onTap: (){
        SCHomeController state = Get.find<SCHomeController>();
        if (state.skinStyle == 0) {
          state.changeSkin(style: 1);
        } else {
          state.changeSkin(style: 0);
        }
        SCRouterHelper.back(null);
      },);
    } else if (index == 1) {
      return logoffCell();
    } else if (index == 2) {
      return SCSettingCell(
        title: '是否接收评论提醒',
        switchIndex: 0,
        cellType: SCSettingCellType.switchType,);
    } else if (index == 3) {
      return SCSettingCell(
        title: '接受新消息通知',
        switchIndex: 1,
        cellType: SCSettingCellType.switchType,);
    } else if (index == 4) {
      return SCSettingCell(
        title: '关于${SCDefaultValue.appName}',
        content: '当前版本：1.1.0',
        cellType: SCSettingCellType.contentArrowType,
        onTap: (){

        },
      );
    } else if (index == 5) {
      return SCSettingCell(title: '隐私政策', onTap: (){
        var params = {'title' : '隐私政策', 'url' : SCAgreement.privacyProtocolUrl};
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
      },);
    } else if (index == 6) {
      return SCSettingCell(title: '个人信息搜集清单', onTap: (){

      },);
    } else if (index == 7) {
      return SCSettingCell(title: '应用权限说明', onTap: (){

      },);
    } else if (index == 8) {
      return SCSettingCell(
        title: '清除缓存',
        content: '12.0KB',
        cellType: SCSettingCellType.contentType,
        onTap: (){

      },);
    } else if (index == 9) {
      return SCSettingCell(title: '帮助', onTap: (){

      },);
    } else if (index == 10) {
      return SCSettingCell(title: '意见反馈', onTap: (){

      },);
    } else if (index == 11) {
      return SCSettingCell(title: '给我们评价', onTap: (){

      },);
    } else if (index == 12) {
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
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }
  
  Widget line10() {
    return Container(
      height: 10.0,
      width: double.infinity,
      color: SCColors.color_F5F5F5,
    );
  }
}
