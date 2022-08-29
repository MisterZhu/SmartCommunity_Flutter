import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_select_house_room_search_status_controller.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/room/sc_select_house_room_listview.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/room/sc_select_house_room_search_dynamic_view.dart';
import 'package:smartcommunity/page/Login/View/SelectHouse/room/sc_select_house_room_search_static_view.dart';

import '../../../../../constants/sc_colors.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_community_page_view
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/18 9:56
/// Description: 选择房号-幢
class SCSelectHouseRoomPageView extends StatefulWidget {
  const SCSelectHouseRoomPageView({Key? key}) : super(key: key);

  @override
  State<SCSelectHouseRoomPageView> createState() =>
      _SCSelectHouseRoomPageViewState();
}

class _SCSelectHouseRoomPageViewState
    extends State<SCSelectHouseRoomPageView> {
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
                          SCSelectHouseRoomListView()
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
    return GetBuilder<SCSelectHouseRoomSearchStatusController>(builder: (state) {
      if (state.isShowCancel) {
        // 搜索中……
        return SCHouseRoomSearchDynamicView(
          isShowCancel: state.isShowCancel,
        );
      } else {
        // 搜索完成
        return SCSelectHouseRoomSearchStaticView();
      }
    });
  }

}
