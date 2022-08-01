import 'package:flutter/material.dart';

/// 首页-图片item,一张图片、两张图片、三张图片

class SCHomeImageItem extends StatelessWidget {

  /// 图片list,最多三张图片
  final List imageList;

  /// 图片点击回调
  Function(int index)? onTap;

  /// 图片宽度
  final double imageWidth;

  /// 图片高度
  final double imageHeight;

  /// 屏幕宽度
  late double screenWidth;

  /// 三张图片时，大图在左边还是右边，默认左边
  final bool bigImageLeft;

  SCHomeImageItem(
      {Key? key, this.imageWidth = 686.0, this.imageHeight = 148.0, required this.imageList, this.onTap, this.bigImageLeft = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    if (imageList.isEmpty) {// 没有图片
      return const SizedBox();
    } else if (imageList.length == 1) {// 一张图片
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: oneImageWidget(index: 0),
      );
    } else if (imageList.length == 2) { // 两张图片
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: twoImageWidget(),
      );
    }
    else { // 最多三张图片
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: threeImageWidget(),
      );
    }

  }

  /// 图片组件
  Widget imageItem({required int index, required double imageScale, required String url}) {
    return AspectRatio(
      aspectRatio: imageScale,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: GestureDetector(
          onTap: () {
            onTap?.call(index);
          },
          child: Image.asset(
            url,
            fit: BoxFit.cover,
          ),
        )
      ),
    );
  }

  /// 只有一张图片
  Widget oneImageWidget({required int index}) {
    double imageScale = imageWidth / imageHeight;
    return imageItem(index: index, imageScale: imageScale, url: imageList[index]);
  }

  /// 只有两张图片
  Widget twoImageWidget() {
    double imageScale = imageWidth / imageHeight;
    return Row(
      children: [
        Expanded(flex: 1,child: imageItem(index: 0, imageScale: imageScale, url: imageList[0]),),
        const SizedBox(width: 10.0,),
        Expanded(flex: 1,child: imageItem(index: 1, imageScale: imageScale, url: imageList[1]),),
      ],
    );
  }

  /// 只有三张图片
  Widget threeImageWidget() {
    double smallImageScale = imageWidth / imageHeight;
    double realImageWidth = (screenWidth - 32.0 - 10.0) / 2.0;
    double bigImageHeight = (realImageWidth / smallImageScale) * 2 + 10.0;
    double bigImageScale = realImageWidth / bigImageHeight;

    /// 左侧组件
    Widget leftItem;
    /// 右侧组件
    Widget rightItem;

    if (bigImageLeft == true) {
      leftItem = Expanded(flex: 1,child: imageItem(index: 1, imageScale: bigImageScale, url: imageList[0]),);
      rightItem = Expanded(flex: 1,child: Column(
        children: [
          imageItem(index: 1, imageScale: smallImageScale, url: imageList[1]),
          const SizedBox(height: 10.0,),
          imageItem(index: 2, imageScale: smallImageScale, url: imageList[2]),
        ],
      ),);
    } else {
      leftItem = Expanded(flex: 1,child: Column(
        children: [
          imageItem(index: 1, imageScale: smallImageScale, url: imageList[1]),
          const SizedBox(height: 10.0,),
          imageItem(index: 2, imageScale: smallImageScale, url: imageList[2]),
        ],
      ),);
      rightItem = Expanded(flex: 1,child: imageItem(index: 1, imageScale: bigImageScale, url: imageList[0]),);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leftItem,
        const SizedBox(width: 10.0,),
        rightItem,
      ],
    );
  }
}
