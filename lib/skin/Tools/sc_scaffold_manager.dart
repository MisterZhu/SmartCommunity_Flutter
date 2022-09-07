/*皮肤管理工具*/

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcommunity/utils/Router/sc_router_path.dart';
import '../../constants/sc_key.dart';
import '../../utils/Colors/sc_color_hex.dart';
import '../../constants/sc_skin_key.dart';
import '../../constants/sc_skin_value.dart';
import '../../utils/sc_sp_utils.dart';
import '../GetXController/sc_scaffold_controller.dart';
import '../Model/sc_scaffold_model.dart';
import '../Model/sc_user.dart';

class SCScaffoldManager {

  factory SCScaffoldManager() => _getInstance();

  static SCScaffoldManager get instance => _getInstance();

  static late SCScaffoldManager _instance = SCScaffoldManager._internal();

  static late SCScaffoldModel _scaffoldModel;

  static late SCUser _user;

  static bool _isLogin = false;

  SCScaffoldManager._internal() {
    _scaffoldModel = SCScaffoldModel();
    _user = SCUser();
  }

  static SCScaffoldManager _getInstance() {
    if(_instance == null) {
      _instance = SCScaffoldManager._internal();
    }
    return _instance;
  }

  SCScaffoldModel get scaffoldModel => _scaffoldModel;

  SCUser get user => _user;

  bool get isLogin => _isLogin;

  /// 初始化
  void initBase () {
    Get.put(SCCustomScaffoldController());
    SCScaffoldManager.instance.initScaffold();
  }

  /// 初始化scaffold数据
  Future initScaffold() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool hasScaffoldKey = sharedPreferences.containsKey(SkinDefaultKey.scaffold_key);

    /// 引导页key
    bool hasGuideKey = sharedPreferences.containsKey(SCKey.isShowGuide);

    if (hasScaffoldKey) {
      String? scaffolfJsonString = sharedPreferences.getString(SkinDefaultKey.scaffold_key);
      var localJson = jsonDecode(scaffolfJsonString ?? '');
      _scaffoldModel = SCScaffoldModel.fromJson(localJson);
      log('皮肤数据:${SCScaffoldManager.instance.scaffoldModel.toJson()}');
      log('皮肤已设置完成');
    } else {
      _scaffoldModel = SCScaffoldModel.fromJson(scaffoldJson);
      sharedPreferences.setString(SkinDefaultKey.scaffold_key, jsonEncode(scaffoldJson));
      log('设置皮肤完成');
    }

    final state = Get.find<SCCustomScaffoldController>();
    Color color = SCHexColor(_scaffoldModel.navBackgroundColor ?? scaffoldJson['navBackgroundColor']);
    state.setPrimaryColor(color);
    state.setTitleColor(SCHexColor(_scaffoldModel.titleColor ?? scaffoldJson['titleColor']));
    return sharedPreferences;
  }

  /// 获取Router的BasePath
  Future<String> getRouterBasePath() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isShowGuide = preferences.getBool(SCKey.isShowGuide) ?? true;
    bool isShowPrivacy = preferences.getBool(SCKey.isShowPrivacyAlert) ?? true;
    String basePath = SCRouterPath.codeLoginPath;

    bool contains = SCSpUtil.containsKey(SCKey.kIsLogin);
    if (contains == true) {
      _isLogin = SCSpUtil.getBool(SCKey.kIsLogin);
    }

    log('SCScaffoldManager--isLogin=====$_isLogin');

    if (isShowGuide == true) {
      basePath = SCRouterPath.guidePath;
    } else {
      if (isShowPrivacy == true) {
        basePath = SCRouterPath.basePrivacyPath;
      } else {
        if (_isLogin) {
          basePath = SCRouterPath.tabPath;
        }
      }
    }
    return Future(() => basePath);
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

  /*缓存用户登录状态*/
  cacheUserIsLogin(bool login) {
    SCSpUtil.setBool(SCKey.kIsLogin, login);
  }

  /*缓存用户信息*/
 cacheUserData(dynamic data) async{
   SCSpUtil.setMap(SCKey.kUserData, data);
 }

  /*清空用户信息*/
 clearUserData() {
   SCSpUtil.remove(SCKey.kUserData);
 }

 /*获取用户信息*/
 getUserData() {
   bool contains = SCSpUtil.containsKey(SCKey.kUserData);
   if (contains == true) {
     var data = SCSpUtil.getMap(SCKey.kUserData);
     _user = SCUser.fromJson(data);
     return _user;
   }
 }

}