/*皮肤管理工具*/

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../Constants/sc_default_value.dart';
import '../../Constants/sc_key.dart';
import '../../Utils/Colors/sc_color_hex.dart';
import '../../Constants/sc_skin_key.dart';
import '../../Constants/sc_skin_value.dart';
import '../../Utils/Router/sc_router_helper.dart';
import '../../Utils/sc_sp_utils.dart';
import '../GetXController/sc_scaffold_controller.dart';
import '../Model/sc_scaffold_model.dart';
import '../Model/sc_user.dart';

class SCScaffoldManager {
  factory SCScaffoldManager() => _instance;

  static SCScaffoldManager get instance => _instance;

  static final SCScaffoldManager _instance = SCScaffoldManager._internal();

  static late SCScaffoldModel _scaffoldModel;

  static late SCUser _user;

  static bool _isLogin = false;

  static late SharedPreferences _preferences;

  static late List _getXTagList;

  SCScaffoldManager._internal() {
    _scaffoldModel = SCScaffoldModel();
    _user = SCUser();
  }

  SCScaffoldModel get scaffoldModel => _scaffoldModel;

  SCUser get user => _user;

  bool get isLogin => _isLogin;

  SharedPreferences get preferences => _preferences;

  List get getXTagList => _getXTagList;

  /// 初始化
  Future initBase() {
    Get.put(SCCustomScaffoldController());
    return SCScaffoldManager.instance.initScaffold();
  }

  /// set user
  set user(SCUser user) {
    // TODO: implement user=
    _user = user;
    cacheUserData(user.toJson());
  }

  /// set user
  set isLogin(bool isLogin) {
    // TODO: implement user=
    _isLogin = isLogin;
    cacheUserIsLogin(isLogin);
  }

  /// 初始化scaffold数据
  Future initScaffold() async {
    _getXTagList = [];
    _preferences = await SharedPreferences.getInstance();

    bool hasScaffoldKey =
    _preferences.containsKey(SkinDefaultKey.scaffold_key);

    /// 引导页key
    bool hasGuideKey = _preferences.containsKey(SCKey.isShowGuide);

    if (hasScaffoldKey) {
      String? scaffolfJsonString =
      _preferences.getString(SkinDefaultKey.scaffold_key);
      var localJson = jsonDecode(scaffolfJsonString ?? '');
      _scaffoldModel = SCScaffoldModel.fromJson(localJson);
      // log('皮肤数据:${SCScaffoldManager.instance.scaffoldModel.toJson()}');
      // log('皮肤已设置完成');
    } else {
      _scaffoldModel = SCScaffoldModel.fromJson(scaffoldJson);
      _preferences.setString(
          SkinDefaultKey.scaffold_key, jsonEncode(scaffoldJson));
      // log('设置皮肤完成');
    }

    final state = Get.find<SCCustomScaffoldController>();
    Color color = SCHexColor(_scaffoldModel.navBackgroundColor ??
        scaffoldJson['navBackgroundColor']);
    state.setPrimaryColor(color);
    state.setTitleColor(
        SCHexColor(_scaffoldModel.titleColor ?? scaffoldJson['titleColor']));

    getUserData();
    return _preferences;
  }

  /// 获取Router的BasePath
  Future<String> getRouterBasePath() async {
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
  void changeNavBackgroundColor(Color color) async {
    _scaffoldModel.navBackgroundColor = SCHexColor.colorToString(color);
    final state = Get.find<SCCustomScaffoldController>();
    state.setPrimaryColor(color);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        SkinDefaultKey.scaffold_key, jsonEncode(_scaffoldModel.toJson()));
  }

  /*修改title颜色*/
  void changeTitleColor(Color color) async {
    _scaffoldModel.titleColor = SCHexColor.colorToString(color);
    final state = Get.find<SCCustomScaffoldController>();
    state.setTitleColor(color);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        SkinDefaultKey.scaffold_key, jsonEncode(_scaffoldModel.toJson()));
  }

  /*缓存用户登录状态*/
  cacheUserIsLogin(bool login) {
    SCSpUtil.setBool(SCKey.kIsLogin, login);
  }

  /*缓存用户信息*/
  cacheUserData(dynamic data) async {
    SCSpUtil.setMap(SCKey.kUserData, data);
  }

  /*退出登录*/
  logout({bool? isAfterTip, Duration? tipDuration}) {
    _user = SCUser();
    _isLogin = false;
    SCSpUtil.remove(SCKey.kIsLogin);
    SCSpUtil.remove(SCKey.kUserData);
    SCHttpManager.instance.updateHeaders(headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'client': SCDefaultValue.client
    });

    bool isAfterTipStatus = isAfterTip ?? false;

    if (isAfterTipStatus == false) {
      SCRouterHelper.codeOffAllPage(9001, null);
    } else {
      Duration duration = tipDuration ?? EasyLoading.instance.displayDuration;
      Future.delayed(duration,() {
        SCRouterHelper.codeOffAllPage(9001, null);
      });
    }
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
      // print('本地数据：${_user.toJson()}');
      return _user;
    }
  }

  /// 获取GetXController-tag
  String getXControllerTag(String pageName) {
    bool isContainPage = false;
    int pageIndex = 0;
    String tag = "$pageName$pageIndex";
    for (int i=0; i<getXTagList.length; i++) {
      var json = getXTagList[i];
      String subPageName = json['pageName'];
      if (subPageName == pageName) {
        isContainPage = true;
        pageIndex = i;
        break;
      }
    }

    if (isContainPage) {/// page已存在
      var json = getXTagList[pageIndex];
      int index = json['index'];
      List tagList = json['tagList'];
      index+=1;
      tag = "$pageName$index";
      tagList.add(tag);
      json['index'] = index;
      json['tagList'] = tagList;
      getXTagList[pageIndex] = json;
    } else {/// page不存在
      var json = {
        "pageName" : pageName,
        "index" : 0,
        "tagList" : [tag]
      };
      getXTagList.add(json);
    }
    return tag;
  }

  /// 删除GetXController-tag
  bool deleteGetXControllerTag(String pageName, String tag) {
    bool success = false;
    bool isContainPage = false;
    int pageIndex = 0;
    for (int i=0; i<getXTagList.length; i++) {
      var json = getXTagList[i];
      String subPageName = json['pageName'];
      if (subPageName == pageName) {
        isContainPage = true;
        pageIndex = i;
        break;
      }
    }

    if (isContainPage) {
      var json = getXTagList[pageIndex];
      int index = json['index'];
      List list = json['tagList'];
      success = list.remove(tag);
      if (success) {
        index -= 1;
      }
      json['tagList'] = list;
      json['index'] = index;
      getXTagList[pageIndex] = json;
    }
    return success;
  }
}
