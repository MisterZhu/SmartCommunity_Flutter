import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/network/sc_http_manager.dart';
import 'package:smartcommunity/network/sc_url.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_block_controller.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_block_search_status_controller.dart.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_controller.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/block/sc_select_house_block_listview.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/block/sc_select_house_search_dynamic_view.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/block/sc_select_house_search_static_view.dart';
import 'package:smartcommunity/utils/Toast/sc_toast.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_community_page_view
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/18 9:56
/// Description: 选择房号-苑
class SCSelectHouseBlockPageView extends StatefulWidget {



  const SCSelectHouseBlockPageView({Key? key}) : super(key: key);

  @override
  State<SCSelectHouseBlockPageView> createState() =>
      _SCSelectHouseBlockPageViewState();
}

class _SCSelectHouseBlockPageViewState
    extends State<SCSelectHouseBlockPageView> {
  SCSelectHouseController selectHouseController =
      Get.find<SCSelectHouseController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Stack(
      children: [
        // 阴影
        Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          width: MediaQuery.of(context).size.width,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(5.0),
            color: SCColors.color_1A1B1C33,
          ),
        ),

        // 内容
        SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: SCColors.color_F2F3F5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(8.0),
                        color: SCColors.color_FFFFFF,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 16.0),
                      child: Column(
                        children: [
                          // 搜索框
                          searchHeader(),

                          const SizedBox(
                            height: 20.0,
                          ),

                          // 列表
                          SCSelectHouseBlockListView()
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }

  Widget searchHeader() {
    return GetBuilder<SCSelectHouseBlockSearchStatusController>(
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
}
