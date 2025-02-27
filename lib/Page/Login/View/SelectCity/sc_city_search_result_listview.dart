import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Login/Model/sc_city_model.dart';

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
        itemBuilder: (BuildContext context, int index) {
          SCCityModel model = cityList![index];
          return cell(model: model);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: cityList?.length ?? 0);
  }

  /// 城市cell
  Widget cell({required SCCityModel model}) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [cityItem(model: model), separatorItem()],
        ),
      ),
      onTap: () {
        selectCity(model: model);
      },
    );
  }

  /// 城市item
  Widget cityItem({required SCCityModel model}) {
    return Container(
      color: Colors.transparent,
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
  selectCity({required SCCityModel model}) {
    if (selectCityHandler != null) {
      selectCityHandler?.call(model);
    }
  }
}
