import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_bottom_tag.dart';
import 'package:smartcommunity/page/Home/View/sc_home_tag_item.dart';

/// 首页-精选item

class SCHomeFeatureItem extends StatelessWidget {
  SCHomeFeatureItem(
      {Key? key,
      this.cell1Style = SCHomeFeatureStyle.featureStyle1,
      this.cell2Style = SCHomeFeatureStyle.featureStyle2,
      this.firstTap,
      this.secondTap
      })
      : super(key: key);

  /// 标题字体大小
  final double titleFont = SCFonts.f14;

  /// 标题字体大小
  final double tagFont = SCFonts.f10;

  /// scale
  final double scale = 1.0;

  /// 第一个cell的style
  final SCHomeFeatureStyle cell1Style;

  /// 第二个cell的style
  final SCHomeFeatureStyle cell2Style;

  /// 第一个cell的点击
  final Function(int index)? firstTap;

  /// 第二个cell的点击
  final Function(int index)? secondTap;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: SCColors.color_F5F5F5,
      ),
      child: StaggeredGridView.countBuilder(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
          mainAxisSpacing: 0,
          crossAxisSpacing: 8,
          crossAxisCount: 2,
          shrinkWrap: true,
          itemCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return getCell(index);
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          }),
    );
  }

  /// 获取cell
  Widget getCell(int index) {
    if (index == 0) {
      if (cell1Style == SCHomeFeatureStyle.featureStyle1) {
        return cellStyle1(index);
      } else {
        return cellStyle2(index);
      }
    } else {
      if (cell2Style == SCHomeFeatureStyle.featureStyle1) {
        return cellStyle1(index);
      } else {
        return cellStyle2(index);
      }
    }
  }

  /// 第一种样式cell
  Widget cellStyle1(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          cellHeaderWidget(
              title: '精选商家',
              tag: '好口碑',
              tagTextColor: Colors.white,
              tagBackgroundColor: SCColors.color_4DA6FF),
          const SizedBox(
            height: 6.0,
          ),
          cellStyle1ImageWidget(url: SCAsset.homeMerchant, onTap: (){
            if (index == 0) {
              if (firstTap != null) {
                firstTap?.call(0);
              }
            } else {
              if (secondTap != null) {
                secondTap?.call(0);
              }
            }
          })
        ],
      ),
    );
  }

  /// 第二种样式cell
  Widget cellStyle2(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          cellHeaderWidget(
              title: '天天特惠价格',
              tag: '今日超低价',
              tagTextColor: Colors.white,
              tagBackgroundColor: SCColors.color_FF6C00),
          const SizedBox(
            height: 6.0,
          ),
          cellStyle2ImageWidget(
              imageList: [SCAsset.homeDiscount1, SCAsset.homeDiscount2], onTap: (int subIndex){
            if (index == 0) {
              if (firstTap != null) {
                firstTap?.call(subIndex);
              }
            } else {
              if (secondTap != null) {
                secondTap?.call(subIndex);
              }
            }
          })
        ],
      ),
    );
  }

  /// cell-通用header
  Widget cellHeaderWidget(
      {String title = '',
      String tag = '',
      Color tagTextColor = Colors.white,
      Color tagBackgroundColor = SCColors.color_4285F4}) {
    return Row(
      children: [
        titleItem(title: title),
        const SizedBox(
          width: 10.0,
        ),
        SCHomeTagItem(
            title: tag,
            height: 16.0,
            tagFont: SCFonts.f10,
            textColor: tagTextColor,
            backgroundColor: tagBackgroundColor)
      ],
    );
  }

  /// 第一种样式cell-image
  Widget cellStyle1ImageWidget({String url = '', Function? onTap}) {
    /// 图片比例
    double imageScale = 311.0 / 156.0;

    return GestureDetector(
      onTap: (){
        if (onTap != null) {
          onTap?.call();
        }
      },
      child: Stack(
        children: [
          AspectRatio(
              aspectRatio: imageScale,
              child: Image.asset(
                url,
                fit: BoxFit.cover,
              )),
          Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Offstage(
                offstage: false,
                child:SCHomeActivityBottomTag(title: '图片底部的标签'))
          ),
        ],
      ),
    );
  }

  /// 第二种样式cell-image
  Widget cellStyle2ImageWidget({List? imageList, Function(int index)? onTap}) {
    /// 图片比例
    double imageScale = 150.0 / 156.0;

    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(0),
        mainAxisSpacing: 0,
        crossAxisSpacing: 6.0,
        crossAxisCount: 2,
        shrinkWrap: true,
        itemCount: imageList?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              onTap?.call(index);
            },
            child: AspectRatio(
                aspectRatio: imageScale,
                child: Image.asset(
                  imageList?[index],
                  fit: BoxFit.cover,
                )),
          );
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// title
  Widget titleItem({String title = ''}) {
    return Expanded(
        child: SizedBox(
      height: titleHeight(),
      child: Text(
        title,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
            fontSize: titleFont * scale,
            fontWeight: FontWeight.w500,
            color: SCColors.color_1B1D33),
      ),
    ));
  }

  /// 标题文本高度
  double titleHeight() {
    return (titleFont + 8) * scale;
  }
}
