import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/page/Login/GetXController/sc_city_search_controller.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';
import '../../GetXController/sc_city_controller.dart';

/// 静态搜索框

class SCCitySearchView extends StatelessWidget {

  const SCCitySearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            height: 30.0,
            decoration: BoxDecoration(
                color: SCColors.color_F2F3F5,
                borderRadius: BorderRadius.circular(15.0)
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
         SCCitySearchController searchState = Get.find<SCCitySearchController>();
         searchState.updateSearchStatus(status: true);

         SCSelectCityController state = Get.find<SCSelectCityController>();
         state.updateSearchResult(status: true);
         },);

  }

  /// 搜索icon
  Widget searchIcon() {
    return Image.asset(SCAsset.iconLocationSearchCity, width: 16.0, height: 16.0,);
  }

  Widget searchView() {
    return const Expanded(child: Text('搜索城市',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.normal,
          color: SCColors.color_B0B1B8),
      )
    );
  }

}

