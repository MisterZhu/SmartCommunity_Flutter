import 'package:flutter/widgets.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/Login/View/SelectCity/sc_city_search_item.dart';
import 'package:smartcommunity/Page/Login/View/SelectCity/sc_current_city_item.dart';

import '../../../../Page/Login/GetXController/sc_search_city_controller.dart';
import '../../../../Page/Login/GetXController/sc_select_city_controller.dart';

/// 搜索城市header

class SCCitySearchHeader extends StatelessWidget {
  /// 是否显示取消按钮
  final bool isShowCancel;
  /// 取消
  final Function? cancelAction;
  /// 文本框内容改变
  final Function(String value)? valueChangedAction;
  /// 定位的城市
  final String? locationCity;
  /// 定位状态，默认未知
  SCLocationStatus locationStatus;

  final SCSelectCityController selectState;
  final SCSearchCityController searchState;

  SCCitySearchHeader(
      { Key? key,
        required this.selectState,
        required this.searchState,
        this.locationStatus = SCLocationStatus.failure,
        this.locationCity = '',
        this.isShowCancel = false,
        this.cancelAction,
        this.valueChangedAction,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      children: [
        SCCitySearchItem(
          selectState: selectState,
          searchState: searchState,
          isShowCancel: isShowCancel,
          cancelAction: (){
          if (cancelAction != null) {
            cancelAction?.call();
          }
        }, valueChangedAction: (String value) {
          if (valueChangedAction != null) {
            valueChangedAction?.call(value);
          }
        },),
        SCCurrentCityItem(locationStatus: locationStatus, city: locationCity ?? '',)
      ],
    );
  }
}