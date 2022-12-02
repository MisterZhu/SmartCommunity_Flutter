import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Constants/sc_fonts.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_select_house_data_controller.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_select_house_search_status_controller.dart.dart';
import 'package:smartcommunity/Page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/Page/Login/View/SelectHouse/sc_select_house_listview.dart';
import 'package:smartcommunity/Page/Login/View/SelectHouse/sc_select_house_search_dynamic_view.dart';
import 'package:smartcommunity/Page/Login/View/SelectHouse/sc_select_house_search_static_view.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_new_page
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/9/8 15:18
/// Description: 选择房号重构
class SCSelectHousePage extends StatefulWidget {
  const SCSelectHousePage({Key? key}) : super(key: key);

  @override
  State<SCSelectHousePage> createState() => _SCSelectHousePageState();
}

class _SCSelectHousePageState extends State<SCSelectHousePage> {
  late String communityId;
  late String communityName;
  /// 导航list
  List<ScSelectHouseModel> navigatorList = [];
  late SCSelectHouseLogicType type = SCSelectHouseLogicType.login;

  SCSelectHouseDataController scSelectHouseDataController = Get.put(SCSelectHouseDataController());
  SCSelectHouseSearchStatusController state = Get.put(SCSelectHouseSearchStatusController());

  @override
  void initState() {
    super.initState();

    // 获取上个页面的传参 communityId
    var params = Get.arguments;
    if (params != null) {
      communityId = params["communityId"];
      communityName = params["communityName"];
      type = params['type'];
      print('communityId---->  $communityId');
    }

    // 缓存顶部导航栏数据
    ScSelectHouseModel scSelectHouseModel = ScSelectHouseModel(
        communityId: communityId, id: 0, name: communityName);
    navigatorList.add(scSelectHouseModel);

    ScSelectHouseModel scSelectHouseModelTemp =
    ScSelectHouseModel(id: 0, name: "请选择");
    navigatorList.add(scSelectHouseModelTemp);
    scSelectHouseDataController.updateNavigatorList(list: navigatorList);
    scSelectHouseDataController.loadHouseInfo(communityId: communityId, currentId: "");
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        centerTitle: true,
        showBackIcon: true,
        navBackgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        textStyle: _textStyle(),
        title: '选择房号',
        body: _body());
  }

  /// 标题textStyle
  TextStyle _textStyle() {
    return const TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.bold,
        color: SCColors.color_1B1C33);
  }

  /// body
  Widget _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 导航栏
          navigatorBarWidget(),
          // 搜索框
          searchWidget(),
          // 内容
          Expanded(child: contentWidget())
        ],
      ),
    );
  }

  /// 顶部导航栏  慧享服务中心 > 慧享生活馆 > 幢 > 单元
  Widget navigatorBarWidget() {
    return GetBuilder<SCSelectHouseDataController>(builder: (state) {
      return Container(
        height: 54.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.centerLeft,
        // child: Text('慧享服务中心 > 慧享生活馆 > 幢 > 单元'),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _navigatorItem(state.navigatorList[index], index,
                (state.navigatorList.length - 1) == index);
          },
          itemCount: state.navigatorList.length,
        ),
      );
    });
  }

  Widget _navigatorItem(ScSelectHouseModel model, int index, bool isLast) {
    return GestureDetector(
      child: Row(
        children: [
          Visibility(
            visible: index != 0,
            child: Text(
              '>',
              style: TextStyle(color: SCColors.color_8D8E99),
            ),
          ),
          Container(
            padding: index == 0
                ? EdgeInsets.only(left: 0, right: 4)
                : EdgeInsets.only(left: 4, right: 4),
            child: Text(
              '${model.name}',
              style: isLast
                  ? TextStyle(color: SCColors.color_FF6C00)
                  : TextStyle(color: SCColors.color_8D8E99),
            ),
          ),
        ],
      ),
      onTap: () {
        if (isLast) {
          return;
        }
        List<ScSelectHouseModel> newList = [];
        List<ScSelectHouseModel> navigatorList = scSelectHouseDataController.navigatorList;

        navigatorList.removeAt(navigatorList.length - 1);

        for (int i = 0; i < navigatorList.length; i++) {
          if (i <= index) {
            newList.add(navigatorList[i]);
          }
        }

        ScSelectHouseModel scSelectHouseModel =
        ScSelectHouseModel(id: 0, name: "请选择");
        newList.add(scSelectHouseModel);
        scSelectHouseDataController.updateNavigatorList(list: newList);

        if (index == 0) {
          scSelectHouseDataController.loadHouseInfo(communityId: communityId);
        } else {
          String? currentId = newList[index].communityId.toString();
          scSelectHouseDataController.loadHouseInfo(communityId: communityId, currentId: currentId);
        }
      },
    );
  }

  Widget searchWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius:  BorderRadiusDirectional.only(topStart: Radius.circular(8.0), topEnd: Radius.circular(8.0), bottomStart: Radius.zero, bottomEnd: Radius.zero),
          color: SCColors.color_FFFFFF,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        child:
        searchHeader()
      ),
    );
  }

  Widget searchHeader() {
    return GetBuilder<SCSelectHouseSearchStatusController>(
        builder: (state) {
          if (state.isShowCancel) {
            // 搜索中……
            return SCHouseSearchDynamicView(
              isShowCancel: state.isShowCancel,
            );
          } else {
            // 搜索完成
            return SCSelectHouseSearchStaticView();
          }
        });
  }

  /// 列表
  Widget contentWidget() {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Container(
          margin: const EdgeInsets.only(top: 0, left: 16.0, right: 16.0),
          child: DecoratedBox(
            decoration: const BoxDecoration(color: SCColors.color_F2F3F5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius:  BorderRadiusDirectional.only(topStart: Radius.zero, topEnd: Radius.zero, bottomStart: Radius.circular(8.0), bottomEnd: Radius.circular(8.0)),
                    color: SCColors.color_FFFFFF,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 16.0),
                  child: Column(
                    children: [
                      // 列表
                      SCSelectHouseListView(communityId: communityId, type: type,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
