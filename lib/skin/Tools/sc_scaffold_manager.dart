/*皮肤管理工具*/

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/Colors/sc_color_hex.dart';
import '../../constants/sc_skin_key.dart';
import '../../constants/sc_skin_value.dart';
import '../GetXController/sc_scaffold_controller.dart';
import '../Model/sc_scaffold_model.dart';

class SCScaffoldManager {

  factory SCScaffoldManager() => _getInstance();

  static SCScaffoldManager get instance => _getInstance();

  static late SCScaffoldManager _instance = SCScaffoldManager._internal();

  static late SCScaffoldModel _scaffoldModel;

  SCScaffoldManager._internal() {
    _scaffoldModel = new SCScaffoldModel();
  }

  static SCScaffoldManager _getInstance() {
    if(_instance == null) {
      _instance = new SCScaffoldManager._internal();
    }
    return _instance;
  }

  SCScaffoldModel get scaffoldModel => _scaffoldModel;

  /// 初始化
  void initBase () {
    Get.put(SCCustomScaffoldController());
    SCScaffoldManager.instance.initScaffold();
  }

  /// 初始化scaffold数据
  Future initScaffold() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool hasKey = sharedPreferences.containsKey(SkinDefaultKey.scaffold_key);

    if(hasKey) {
      String? scaffolfJsonString = sharedPreferences.getString(SkinDefaultKey.scaffold_key);
      var localJson = jsonDecode(scaffolfJsonString ?? '');
      _scaffoldModel = new SCScaffoldModel.fromJson(localJson);
      log('皮肤数据:${SCScaffoldManager.instance.scaffoldModel.toJson()}');
      log('皮肤已设置完成');
    }else {
      _scaffoldModel = new SCScaffoldModel.fromJson(scaffoldJson);
      sharedPreferences.setString(SkinDefaultKey.scaffold_key, jsonEncode(scaffoldJson));
      log('设置皮肤完成');
    }

    final state = Get.find<SCCustomScaffoldController>();
    Color color = SCHexColor(_scaffoldModel.navBackgroundColor ?? scaffoldJson['navBackgroundColor']);
    state.setPrimaryColor(color);
    state.setTitleColor(SCHexColor(_scaffoldModel.titleColor ?? scaffoldJson['titleColor']));
    return sharedPreferences;
  }

  /*修改Nav背景颜色*/
  void changeNavBackgroundColor(Color color) async{
    _scaffoldModel.navBackgroundColor = SCHexColor.colorToString(color);
    final state = Get.find<SCCustomScaffoldController>();
    state.setPrimaryColor(color);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SkinDefaultKey.scaffold_key, jsonEncode(_scaffoldModel.toJson()));
  }

  /*修改title颜色*/
  void changeTitleColor(Color color) async {
    _scaffoldModel.titleColor = SCHexColor.colorToString(color);
    final state = Get.find<SCCustomScaffoldController>();
    state.setTitleColor(color);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SkinDefaultKey.scaffold_key, jsonEncode(_scaffoldModel.toJson()));
  }

}