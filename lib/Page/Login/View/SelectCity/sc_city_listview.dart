import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/sc_colors.dart';
import '../../../../Constants/sc_fonts.dart';
import '../../Model/sc_city_model.dart';

/// 城市列表

class SCCityListView extends StatelessWidget {

  final List<SCCityModel>? cityList;

  final Function(SCCityModel model)? selectCityHandler;

  const SCCityListView({Key? key, this.cityList, this.selectCityHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return AzListView(
      data: cityList ?? [],
      itemCount: cityList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        SCCityModel model = cityList![index];
        return contentItem(context, model);
      },
      padding: EdgeInsets.zero,
      susPosition: Offset.zero,
      susItemHeight: 28.0,
      susItemBuilder: (BuildContext context, int index) {
        SCCityModel model = cityList![index];
        String tag = model.getSuspensionTag();
        return headerItem(context, tag);
      },
      indexBarData: getTagIndexList(cityList),
      indexBarWidth: 24.0,
      indexBarItemHeight: 18.0,
      indexBarMargin: const EdgeInsets.only(bottom: 44),
      indexBarOptions: const IndexBarOptions(
        textStyle: TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w500,
            color: SCColors.color_FF6C00,
        )
      ),
    );
  }

  /// 获取索引列表
  static List<String> getTagIndexList(List<ISuspensionBean>? list) {
    List<String> indexData = [];
    if (list != null && list.isNotEmpty) {
      String? tempTag;
      for (int i = 0, length = list.length; i < length; i++) {
        String tag = list[i].getSuspensionTag();
        if (tempTag != tag) {
          indexData.add(tag);
          tempTag = tag;
        }
      }
    }
    return indexData;
  }

  /// header-字母标题
  Widget headerItem(BuildContext context, String tag, {double susHeight = 40}) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 28.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 24.0),
      color: SCColors.color_FFFFFF,
      child: Container(
        color: SCColors.color_F2F3F5,
        width: double.infinity,
        height: 28.0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          tag,
          maxLines: 1,
          style: const TextStyle(
              fontSize: SCFonts.f12,
              color: SCColors.color_5E5E66,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  /// content-城市
  Widget contentItem(BuildContext context, SCCityModel model,
      {double susHeight = 40}) {
    return GestureDetector(
      onTap: () {
        selectCity(model: model);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 48.0,
              color: SCColors.color_FFFFFF,
              child: Text(
                model.name,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: SCFonts.f16,
                    color: SCColors.color_1B1C33,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 8.0), child: Divider(
              height: 0.5,
              color: SCColors.color_EDEDF0,
            ),)
          ],
        ),
      ),
    );
  }

  /// 选择城市
  selectCity({required SCCityModel model}) {
    if (selectCityHandler != null) {
      selectCityHandler?.call(model);
    }
  }
}