import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../../Utils/sc_utils.dart';

/// 首页-swiper广告图

class SCHomeSwiper extends StatelessWidget {

  /// 图片list
  final List imageList;

  /// imageScale
  final double imageScale;

  /// 左右边距
  final double horizontalPadding;

  /// 圆角
  final double radius;

  /// pagination默认颜色
  final Color normalColor;

  /// pagination选中颜色
  final Color activeColor;

  /// 图片点击回调
  Function(int index)? onTap;

  SCHomeSwiper(
      {Key? key, this.imageScale = 686.0 / 148.0, required this.imageList, this.onTap, this.horizontalPadding = 16.0, this.radius = 6.0, this.normalColor = Colors.white, this.activeColor = Colors.black12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: AspectRatio(
        aspectRatio: imageScale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Swiper(
            autoplay: true,
            onTap: (index) {
              onTap?.call(index);
            },
            itemBuilder: (BuildContext context, int index) {
              return SCUtils.imageWidget(url: imageList[index], fit: BoxFit.cover);
            },
            itemCount: imageList.length,
            pagination: SwiperPagination(
                margin: const EdgeInsets.only(bottom: 5.0),
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                    size: 5.0,
                    activeSize: 5.0,
                    color: normalColor,
                    activeColor: activeColor
                )
            ),
            onIndexChanged: (index) {

            },
          ),
        ),
      ),
    );
  }
}