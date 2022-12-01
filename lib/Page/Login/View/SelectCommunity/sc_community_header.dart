import 'package:flutter/widgets.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/Login/View/SelectCommunity/sc_community_search_item.dart';
import 'package:smartcommunity/Page/Login/View/SelectCity/sc_current_city_item.dart';

/// 搜索社区header

class SCCommunityHeader extends StatelessWidget {
  /// 是否显示取消按钮
  final bool isShowCancel;
  /// 取消
  final Function? cancelAction;
  /// 搜索
  final Function(String value)? searchAction;
  /// 选择城市
  final Function? selectCityAction;
  /// focusNode
  final FocusNode node;
  /// 定位的城市
  final String? locationCity;
  /// 定位状态，默认未知
  SCLocationStatus locationStatus;
  /// 选择的城市
  final String? selectCity;

  SCCommunityHeader(
      {
        Key? key,
        this.locationStatus = SCLocationStatus.failure,
        this.locationCity = '',
        this.selectCity = '',
        this.isShowCancel = false,
        this.cancelAction,
        this.searchAction,
        this.selectCityAction,
        required this.node,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    String? city = selectCity;
    if (selectCity == '') {
      city = locationCity;
    }
    return Column(
      children: [
        SCCommunitySearchItem(
          selectCity: city ?? '请选择',
          node: node,
          isShowCancel: isShowCancel,
          cancelAction: (){
          if (cancelAction != null) {
            cancelAction?.call();
          }
        }, searchAction: (String value) {
          if (searchAction != null) {
            searchAction?.call(value);
          }
        }, selectCityAction: (){
          if (selectCityAction != null) {
            selectCityAction?.call();
          }
        },),
        SCCurrentCityItem(locationStatus: locationStatus, city: locationCity ?? '',)
      ],
    );
  }
}