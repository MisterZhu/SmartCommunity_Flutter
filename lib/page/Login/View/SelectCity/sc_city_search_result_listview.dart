import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Login/Model/sc_city_model.dart';

/// 城市搜索结果item

class SCCitySearchResultListView extends StatelessWidget {

  final List<SCCityModel>? cityList;

  final Function(SCCityModel model)? selectCityHandler;

  const SCCitySearchResultListView({Key? key, this.cityList, this.selectCityHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (BuildContext context, int index) {
          return cell(index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: cityList?.length ?? 0);
  }

  /// 城市cell
  Widget cell({int index= 0}) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [cityItem(index: index), separatorItem()],
        ),
      ),
      onTap: () {

      },
    );
  }

  /// 城市item
  Widget cityItem({int index= 0}) {
    SCCityModel model = cityList![index];
    return Container(
      height: 48.0,
      alignment: Alignment.centerLeft,
      child: Text(
        model.name,
        style: const TextStyle(
            fontSize: SCFonts.f16,
            color: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  /// 分割线
  Widget separatorItem() {
    return const Divider(
      height: 0.5,
      color: SCColors.color_EDEDF0,
    );
  }

  /// 选择城市
  selectCity({int index= 0}) {
    SCCityModel model = cityList![index];
    if (selectCityHandler != null) {
      selectCityHandler?.call(model);
    }
  }
}
