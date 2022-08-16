import 'package:flutter/widgets.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_city_search_item.dart';
import 'package:smartcommunity/page/Login/View/SelectCity/sc_current_city_item.dart';

/// 搜索城市header

class SCCitySearchHeader extends StatelessWidget {

  final bool isShowCancel;

  /// 取消
  final Function? cancelAction;

  /// 文本框内容改变
  final Function(String value)? valueChangedAction;

  const SCCitySearchHeader({Key? key, this.isShowCancel = false, this.cancelAction, this.valueChangedAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      children: [
        SCCitySearchItem(isShowCancel: isShowCancel,cancelAction: (){
          if (cancelAction != null) {
            cancelAction?.call();
          }
        }, valueChangedAction: (String value) {
          if (valueChangedAction != null) {
            valueChangedAction?.call(value);
          }
        },),
        const SCCurrentCityItem(status: SCLocationStatus.success, address: '杭州',)
      ],
    );
  }
}