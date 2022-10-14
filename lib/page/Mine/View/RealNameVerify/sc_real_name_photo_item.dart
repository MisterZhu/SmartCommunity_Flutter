
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';

/// 实名认证证件照片
class SCRealNamePhotoItem extends StatelessWidget {

  /// 点击图片
  final Function(int index)? tapPhotoAction;

  /// 删除图片
  final Function(int index)? deletePhotoAction;

  late double photoWidth = (SCUtils().getScreenWidth() - 78.0) / 2.0;
  late double photoHeight;
  late double watermarkLeftOffset;
  late double watermarkWidth = 109.0;
  late double watermarkHeight = 57.0;
  late double imageScale = 149.0 / 84.0;
  late double radius = 6.0;

  SCRealNamePhotoItem({
    Key? key,
    this.tapPhotoAction,
    this.deletePhotoAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    photoHeight = photoWidth/imageScale;
    watermarkLeftOffset = (photoWidth - watermarkWidth) / 2.0;
    return body();
  }

  /// body
  Widget body() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleItem(),
            const SizedBox(height: 16.0,),
            photosItem(),
          ],
        )
    );
  }

  Widget titleItem() {
    return Container(
      alignment: Alignment.centerLeft,
      color: SCColors.color_FFFFFF,
      child: const Text('上传身份证',
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w600,
          color: SCColors.color_1B1C33,
        ),),
    );
  }

  Widget photosItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        frontPhotoItem(),
        const SizedBox(width: 13.0,),
        backPhotoItem(),
      ],
    );
  }

  Widget frontPhotoItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        photoWidget(imageUrl: SCAsset.iconRealNameVerifyCardFront, index: 0),
        const SizedBox(height: 12.0,),
        photoTitleItem('身份证头像面'),
      ],
    );
  }

  Widget backPhotoItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        photoWidget(imageUrl: SCAsset.iconRealNameVerifyCardBack, index: 1),
        const SizedBox(height: 12.0,),
        photoTitleItem('身份证国徽面'),
      ],
    );
  }

  Widget photoWidget({required String imageUrl, required int index}) {
    return GestureDetector(
      onTap: () {
        print('点击图片$index');
        if (tapPhotoAction != null) {
          tapPhotoAction?.call(index);
        }
      },
      child: Container(
        width: photoWidth,
        height: photoWidth/imageScale,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(radius)),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned(
                top: 0.0,
                left: 0.0,
                bottom: 0.0,
                right: 0.0,
                child: photoItem(imageUrl: imageUrl, index: index)),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: deleteItem(index)),
            Positioned(
                bottom: 3.0,
                left: watermarkLeftOffset,
                width: watermarkWidth,
                height: watermarkHeight,
                child: watermarkItem()),
          ],
        ),
      ),
    );
  }

  Widget photoItem({required String imageUrl, required int index}) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius)),
        child: AspectRatio(
            aspectRatio: imageScale,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            )
        )
    );
  }

  Widget watermarkItem() {
    return Offstage(
      offstage: false,
      child: Image.asset(
        SCAsset.iconRealNameVerifyCardWatermark,
        fit: BoxFit.cover,),
    );
  }

  Widget deleteItem(int index) {
    return Offstage(
      offstage: false,
      child: Container(
        width: 22,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: SCColors.color_000000.withOpacity(0.4),
            borderRadius: BorderRadius.only(topRight: Radius.circular(radius))),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Image.asset(
              SCAsset.iconRealNameVerifyCardDelete,
              width: 16.0,
              height: 16.0,
              fit: BoxFit.cover),
          onPressed: () {
            print('delete======$index');
            if (deletePhotoAction != null) {
              deletePhotoAction?.call(index);
            }
          },
        ),
      ),
    );
  }

  Widget photoTitleItem(String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: SCFonts.f12,
        fontWeight: FontWeight.w400,
        color: SCColors.color_5E5E67,
      ),);
  }

}