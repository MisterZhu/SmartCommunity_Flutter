import 'package:flutter/widgets.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_search_item.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_current_city_item.dart';

/// 搜索城市header

class SCCitySearchHeader extends StatelessWidget {

  final bool isShowCancel;

  const SCCitySearchHeader({Key? key, this.isShowCancel = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      children: [
        SCCitySearchItem(isShowCancel: isShowCancel,),
        const SCCurrentCityItem(status: SCLocationStatus.success, address: '杭州',)
      ],
    );
  }
}