
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Network/sc_http_manager.dart';
import '../../Network/sc_url.dart';
import '../Model/sc_home_visitor_decoration_model.dart';
import '../../Utils/Colors/sc_color_hex.dart';
import '../../Constants/sc_skin_value.dart';
import '../Tools/sc_scaffold_manager.dart';

class SCCustomScaffoldController extends GetxController {
  /*导航栏背景色*/
  Color primaryColor = SCHexColor(SCScaffoldManager.instance.scaffoldModel.navBackgroundColor ?? scaffoldJson['navBackgroundColor']);
  /*title颜色*/
  Color titleColor = SCHexColor(SCScaffoldManager.instance.scaffoldModel.titleColor ?? scaffoldJson['titleColor']);
  /*返回按钮颜色*/
  Color backIconColor = SCHexColor(SCScaffoldManager.instance.scaffoldModel.leadingColor ?? scaffoldJson['leadingColor']);
  /*状态栏颜色,黑色或白色,默认白色*/
  SystemUiOverlayStyle statusBarStyle = SystemUiOverlayStyle.dark;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVisitorDecorationData();
  }

  /*设置导航栏背景色*/
  void setPrimaryColor(Color color) {
    primaryColor = color;
    update();
  }

  /*设置title颜色*/
  void setTitleColor(Color color) {
    titleColor = color;
    update();
  }

  /*设置返回按钮颜色*/
  void setBackIconColor(Color color) {
    backIconColor = color;
    update();
  }

  /*设置状态栏颜色*/
  void setStatusBarStyle(SystemUiOverlayStyle systemUiOverlayStyle) {
    statusBarStyle = systemUiOverlayStyle;
    update();
  }

  /// 游客模式装修API
  getVisitorDecorationData() {
    SCHttpManager.instance.get(
        url: SCUrl.kVisitorDecorationUrl,
        success: (value) {
          //print("游客模式装修成功:$value");
          SCHomeVisitorDecorationModel visitorDecorationModel = SCHomeVisitorDecorationModel.fromJson(value);
          SCScaffoldManager.instance.visitorDecorationModel = visitorDecorationModel;
        },
        failure: (value) {
          print("游客模式装修失败:$value");
        });
  }
}