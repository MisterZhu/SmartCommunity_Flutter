import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Login/GetXController/sc_select_house_search_status_controller.dart';


/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_search_header
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 16:19
/// Description: 选择房号搜索框 - 不可输入
class SCSelectHouseSearchStaticView extends StatelessWidget {

  const SCSelectHouseSearchStaticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 36.0,
          decoration: BoxDecoration(
              color: SCColors.color_F2F3F5,
              borderRadius: BorderRadius.circular(18.0)
          ),
          child: Row(
            children: [
              searchIcon(),
              const SizedBox(width: 10.0,),
              searchView()
            ],
          )
      ),
      onTap: () {
        SCSelectHouseSearchStatusController searchState = Get.find<SCSelectHouseSearchStatusController>();
        searchState.updateSearchStatus(isShowCancel: true);
      },);

  }

  /// 搜索icon
  Widget searchIcon() {
    return Image.asset(SCAsset.iconLocationSearchCity, width: 16.0, height: 16.0,);
  }

  Widget searchView() {
    return const Expanded(child: Text('请输入',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.normal,
          color: SCColors.color_B0B1B8),
    )
    );
  }

}
