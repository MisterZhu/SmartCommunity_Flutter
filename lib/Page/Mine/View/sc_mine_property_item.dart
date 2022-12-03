import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/GetXController/sc_mine_controller.dart';
import 'package:smartcommunity/Page/Mine/Model/sc_property_model.dart';

/// 我的-资产cell

class SCMinePropertyItem extends StatelessWidget {
  /// 选中资产类型的index
  int currentIndex;

  SCPropertyModel model;

  SCMinePropertyItem(
      {Key? key, required this.currentIndex, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headerItem(),
            const SizedBox(
              height: 16.0,
            ),
            propertyDetailItem(),
          ],
        ),
      ),
    );
  }

  /// header-Item
  Widget headerItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleItem(),
        const SizedBox(
          width: 10.0,
        ),
        propertyTypeListViewItem(),
      ],
    );
  }

  /// title-item
  Widget titleItem() {
    return SizedBox(
      width: 100.0,
      child: Text(
        model.title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33,
        ),
      ),
    );
  }

  /// 资产类型列表
  Widget propertyTypeListViewItem() {
    int count = 0;
    if (model.data != null) {
      count = model.data!.length;
    } else {
      count = 0;
    }
    ScrollController controller = ScrollController();
    return Expanded(
        child: SizedBox(
      height: 22.0,
      child: ListView.separated(
          reverse: true,
          dragStartBehavior: DragStartBehavior.down,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return propertyTitleItem(index: index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 22.0,
            );
          },
          itemCount: count),
    ));
  }

  /// 资产类型标题-item
  Widget propertyTitleItem({required int index}) {
    int realCurrentIndex = currentIndex;
    int reverseIndex = model.data!.length - index - 1;
    SCPropertyTypeModel typeModel = model.data![reverseIndex];
    double borderWidth = reverseIndex == realCurrentIndex ? 0.5 : 0.0;
    Color borderColor = reverseIndex == realCurrentIndex
        ? SCColors.color_1B1D33
        : Colors.transparent;
    Color textColor = reverseIndex == realCurrentIndex
        ? SCColors.color_1B1D33
        : SCColors.color_5E5F66;

    String? title =  typeModel.title;

    return GestureDetector(
      onTap: () {
        SCMineController state = Get.find<SCMineController>();
        state.changePropertyIndex(index: reverseIndex);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: reverseIndex == realCurrentIndex ? 11.0 : 0.0),
        height: 22.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Text(
          title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SCFonts.f12,
              color: textColor,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  /// 资产详细信息item
  Widget propertyDetailItem() {
    SCPropertyTypeModel typeModel = model.data![currentIndex];
    Widget item;
    if (typeModel.type == 0) {
      item = carItem(model: typeModel);
    } else {
      item = parkingSpaceDetailItem(model: typeModel);
    }
    return Container(
      height: 62.0,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
          color: SCColors.color_F7F8FA,
          borderRadius: BorderRadius.circular(4.0)),
      child: item,
    );
  }

  /// 车辆item
  Widget carItem({required SCPropertyTypeModel model}) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 14.0), child: Row(
      children: [
        carDetailItem(title: model.plateNumber ?? '', subTitle: model.plateNumberDes ?? ''),
        Expanded(child: carDetailItem(title: model.brand ?? '', subTitle: model.brandDes ?? '')),
        carDetailItem(title: model.color ?? '', subTitle: model.colorDes ?? '')
      ],
    ),);
  }

  /// 车辆item-详细信息item
  Widget carDetailItem({required String title, required String subTitle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33
        ),),
        const SizedBox(
          height: 6.0,
        ),
        Text(subTitle, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66
        ),),
      ],
    );
  }

  /// 车位、库房item-详细信息item
  Widget parkingSpaceDetailItem({required SCPropertyTypeModel model}) {
    int count = 0;
    if (model.data != null) {
      count = model.data!.length;
    }
    return SizedBox(
      height: 34.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index){
            String text = model.data![index];
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: SCColors.color_8D8E99, width: 0.5),
              ),
              child: Text(text, textAlign: TextAlign.center, style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33
              ),),
            );
          }, separatorBuilder: (BuildContext context, int index){
        return SizedBox(width: 12.0,);
      }, itemCount: count),
    );
  }
}
