
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';

/// 当前城市item

class SCCurrentCityItem extends StatelessWidget {
  /// 定位状态
  final SCLocationStatus status;

  /// 位置
  final String address;

  const SCCurrentCityItem(
      {Key? key, this.status = SCLocationStatus.notOpen, this.address = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      height: 54.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [leftItem(), rightItem()],
      ),
    );
  }

  /// 左侧-当前定位城市
  Widget leftItem() {
    return const Text(
      '当前定位城市',
      style: TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }

  /// 右侧-城市
  Widget rightItem() {
    if (status == SCLocationStatus.reload) {// 重新定位
      return reloadLocationItem();
    } else if (status == SCLocationStatus.success) {// 定位成功
      return successLocationItem();
    } else { // 未开启定位
      return notOpenLocationItem();
    }
  }

  /// 重新定位Item
  Widget reloadLocationItem() {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            SCAsset.iconLocationReload,
            width: 16.0,
            height: 16.0,
          ),
          const SizedBox(
            width: 4.0,
          ),
          const Text(
            '重新定位',
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33),
          )
        ],
      ),
      onTap: () {
        log('重新定位');
      },
    );
  }

  /// 定位成功item
  Widget successLocationItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          SCAsset.iconLocationCity,
          width: 22.0,
          height: 22.0,
        ),
        const SizedBox(
          width: 8.5,
        ),
        Text(
          address,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33),
        )
      ],
    );
  }

  /// 未开启定位item
  Widget notOpenLocationItem() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
        child: const Text(
          '未开启定位',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_4DA6FF),
        ),
        onPressed: () {});
  }
}
