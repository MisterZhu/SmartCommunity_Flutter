
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Mine/View/Setting/sc_setting_cell.dart';
import 'package:smartcommunity/skin/Tools/sc_scaffold_manager.dart';

/// 设置listview

class SCPersonalInfoListView extends StatelessWidget {

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
          if (index == 5 || index == 6 || index == 7) {
            isLine = false;
          }
          return getLine(isLine);
        },
        itemCount: 9);
  }

  Widget getCell(int index) {
    if (index == 0) {
      return SCSettingCell(title: '头像', onTap: (){

      },);
    } else if (index == 1) {
      return SCSettingCell(
        title: '姓名',
        content: '',
        cellType: SCSettingCellType.contentArrowType,
        onTap: (){

        },
      );
    } else if (index == 2) {
      return SCSettingCell(
        title: '昵称',
        content: SCScaffoldManager.instance.user.nickName,
        cellType: SCSettingCellType.contentArrowType,
        onTap: (){

        },
      );
    } else if (index == 3) {
      String? phone = SCScaffoldManager.instance.user.mobileNum;
      String phoneText = phone?.replaceRange(3, 7, '****') ?? '';
      return SCSettingCell(
        title: '手机号',
        content: phoneText,
        cellType: SCSettingCellType.contentArrowType,
        onTap: (){

        },
      );
    } else if (index == 4) {
      return SCSettingCell(
        title: '性别',
        content: '女',
        cellType: SCSettingCellType.contentArrowType,
        onTap: (){

        },
      );
    } else if (index == 5) {
      return SCSettingCell(
        title: '出生日期',
        content: '请选择',
        cellType: SCSettingCellType.contentArrowType,
        onTap: (){

        },
      );
    } else if (index == 6) {
      return SCSettingCell(title: '个性标签', onTap: (){

      },);
    } else if (index == 7) {
      return SCSettingCell(title: '服务要求', onTap: (){

      },);
    } else if (index == 8) {
      return SCSettingCell(title: '登录密码', onTap: (){

      },);
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
