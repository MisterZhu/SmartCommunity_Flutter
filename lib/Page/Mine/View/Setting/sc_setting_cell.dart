import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../../../Constants/sc_type_define.dart';
import '../../GetXController/sc_setting_controller.dart';

/// 设置页面cell

// cell样式
enum SCSettingCellType {
  // 右边是箭头
  arrowType,
  // 右边是标题
  contentType,
  // 右边是标题箭头
  contentArrowType,
  // 右边是图片箭头
  imageArrowType,
  // 右边是开关
  switchType,
  // 右边是标签标题箭头
  tagContentArrowType,
}

class SCSettingCell extends StatelessWidget {

  /// title
  final String? title;

  /// content
  final String? content;

  /// image
  final String imageUrl;

  /// cell样式
  final SCSettingCellType cellType;

  /// 开关index
  final int switchIndex;

  /// tag类型
  final int tagType;

  /// onTap
  final Function? onTap;

  late List tagDataList = [
    {
      'tagType' : SCTypeDefine.realNameVerifyStatusNo,
      'tagText' : '未实名',
      'tagBgColor' : SCColors.color_F2F3F5,
      'tagTextColor' : SCColors.color_8D8E99,},
    {
      'tagType' : SCTypeDefine.realNameVerifyStatusSuccess,
      'tagText' : '已实名',
      'tagBgColor' : SCColors.color_E7F1FF,
      'tagTextColor' : SCColors.color_1677FF,},
    {
      'tagType' : SCTypeDefine.realNameVerifyStatusReview,
      'tagText' : '审核中',
      'tagBgColor' : SCColors.color_FFEBEC,
      'tagTextColor' : SCColors.color_FF1D32,},
    {
      'tagType' : SCTypeDefine.realNameVerifyStatusFailed,
      'tagText' : '未通过',
      'tagBgColor' : SCColors.color_FFEBEC,
      'tagTextColor' : SCColors.color_FF1D32,},
  ];
  
  late var tagData = tagDataList[0];

  SCSettingCell({Key? key,
    this.title = '',
    this.content = '',
    this.imageUrl = SCAsset.iconMineUserDefault,
    this.cellType = SCSettingCellType.arrowType,
    this.switchIndex = 0,
    this.tagType = SCTypeDefine.realNameVerifyStatusNo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cellType == SCSettingCellType.tagContentArrowType) {
      int index = tagDataList.indexWhere((e) => e['tagType'] == tagType);
      if (index >= 0 && index < tagDataList.length) {
        tagData = tagDataList[index];
      }
    }
    return body();
  }

  /// body
  Widget body() {
    return SizedBox(
      height: 44.0,
      child: bodyItem(),
    );
  }

  Widget bodyItem() {
    if (cellType == SCSettingCellType.switchType) {
      return rowItem();
    } else {
      return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap?.call();
          }
        },
        child: rowItem(),
      );
    }
  }

  Widget rowItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: titleWidget()),
          rightWidget(),
        ],
      ),
    );
  }

  /// title
  Widget titleWidget() {
    String titleString = title ?? '';
    return Text(
      titleString, 
      textAlign: TextAlign.left, 
      maxLines: 1, 
      overflow: TextOverflow.ellipsis, 
      style: const TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.w400,
        color: SCColors.color_1B1C33
    ),);
  }

  /// 右边的组件
  Widget rightWidget() {
    if (cellType == SCSettingCellType.contentType) {
      return contentWidget();
    } else if (cellType == SCSettingCellType.contentArrowType) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          contentWidget(),
          arrowIcon()
        ],
      );
    } else if (cellType == SCSettingCellType.imageArrowType) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageWidget(),
          arrowIcon()
        ],
      );
    } else if (cellType == SCSettingCellType.switchType) {
      return switchWidget();
    } else if (cellType == SCSettingCellType.tagContentArrowType) {
      return tagContentWidget();
    }  else {
      return arrowIcon();
    }
  }

  /// content
  Widget contentWidget() {
    String contentString = content ?? '';
    return Text(
      contentString,
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w400,
        color: SCColors.color_5E5E66
    ),);
  }

  Widget imageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SCUtils.imageWidget(url: imageUrl, width: 40.0, height: 40.0, fit: BoxFit.cover),
    );
  }
  
  /// 箭头icon
  Widget arrowIcon() {
    return Image.asset(SCAsset.iconMineDetailGrey, width: 22.0, height: 22.0,);
  }

  /// 开关组件
  Widget switchWidget() {
    return GetBuilder<SCSettingController>(builder: (state) {
      return CupertinoSwitch(
          activeColor: SCColors.color_FF6C00,
          value: state.switchStatusList[switchIndex],
          onChanged: (value) {
            state.updateSwitchStatus(index: switchIndex, enable: value);
          });
    });
  }

  /// 标签组件
  Widget tagContentWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        tagItem(status: tagType),
        const SizedBox(width: 8.0,),
        contentWidget(),
        arrowIcon()
      ],
    );
  }

  /// 审核状态标签, status:0未实名，1已实名，2审核中，3未通过
  Widget tagItem({required int status}) {
    return Container(
      height: 22.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: tagData['tagBgColor'],
          borderRadius: BorderRadius.circular(2.0)
      ),
      child: Text(
      tagData['tagText'],
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: SCFonts.f12,
        fontWeight: FontWeight.w500,
        color: tagData['tagTextColor']),
      )
    );
  }
}