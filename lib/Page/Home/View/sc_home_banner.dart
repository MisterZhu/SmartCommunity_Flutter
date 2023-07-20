/// 首页-banner
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/Home/GetXController/sc_home_controller1.dart';

import '../../../Utils/sc_utils.dart';

class SCHomeBanner extends StatelessWidget {
  const SCHomeBanner(
      {Key? key,
      required this.bannerBGScale,
      required this.bannerScale,
      required this.bannerList,
      required this.backgroundImageUrl,
      required this.currentIndex,
      this.onTap
      })
      : super(key: key);

  /// banner背景图片比例
  final double bannerBGScale;

  /// banner图片比例
  final double bannerScale;

  /// bannerList
  final List bannerList;

  /// 背景图片
  final String backgroundImageUrl;

  /// banner当前Index
  final int currentIndex;

  /// 点击回调
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bannerTap();
      },
      child: Stack(

        children: [
          swiperItem(),
          //backgroundImage(),
          bottomRadiusBar(context),
          //banner(context),
        ],
      ),
    );
  }

  /// swiperItem
  Widget swiperItem() {
    return AspectRatio(
      aspectRatio: bannerScale,
      child: Swiper(
        autoplay: true,
        onTap: (index) {
          onTap?.call(index);
        },
        itemBuilder: (BuildContext context, int index) {
          return SCUtils.imageWidget(url: bannerList[index], fit: BoxFit.cover);
        },
        itemCount: bannerList.length,
        pagination: const SwiperPagination(
          margin: EdgeInsets.only(bottom: 20.0),
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
              size: 5.0,
              activeSize: 5.0,
              color: Colors.grey,
              activeColor: Colors.white
          )
        ),
        onIndexChanged: (index) {

        },
      )
    );
  }

  /// 背景图片
  Widget backgroundImage() {
    return AspectRatio(
      aspectRatio: bannerBGScale,
      child: SCUtils.imageWidget(url: backgroundImageUrl, fit: BoxFit.cover),
    );
  }

  /// 底部圆角条
  Widget bottomRadiusBar(BuildContext context) {
    double screenScale = MediaQuery.of(context).size.width / 375.0;
    return Positioned(
        left: 0,
        right: 0,
        bottom: -1,
        child: Container(
          height: 8.0 * screenScale,
          decoration: const BoxDecoration(
              color: SCColors.color_F5F5F5,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
        ));
  }

  /// banner
  Widget banner(BuildContext context) {
    double screenScale = MediaQuery.of(context).size.width / 375.0;
    double width = MediaQuery.of(context).size.width - 32.0 * screenScale;
    double height = width / bannerScale;
    return Positioned(
        left: 16.0 * screenScale,
        right: 16.0 * screenScale,
        bottom: 8.0 * screenScale,
        child: Opacity(
          opacity: 1.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3.0),
            child: SizedBox(
              height: height,
              child: Swiper(
                index: currentIndex,
                autoplay: false,
                itemBuilder: (BuildContext context, int index) {
                  return SCUtils.imageWidget(url: bannerList[index], fit: BoxFit.cover);
                },
                itemCount: bannerList.length,
                onIndexChanged: (index) {
                  changeIndex(index: index);
                },
              ),
            ),
          ),
        ));
  }

  /// swiper切换
  void changeIndex({int? index}) {
    SCHomeController1 state = Get.find<SCHomeController1>();
    state.changeBannerIndex(index: index ?? 0);
  }

  /// banner点击
  bannerTap() {
    if (onTap != null) {
      SCHomeController1 state = Get.find<SCHomeController1>();
      onTap?.call(state.bannerCurrentIndex);
    }
  }
}
