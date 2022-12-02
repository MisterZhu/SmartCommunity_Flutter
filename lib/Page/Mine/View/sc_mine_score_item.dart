import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
import 'package:smartcommunity/Constants/sc_fonts.dart';
import 'package:smartcommunity/Utils/Colors/sc_color_hex.dart';

/// 我的-积分、红包cell

class SCMineScoreItem extends StatelessWidget {
  final Function(int index)? onTap;

  const SCMineScoreItem({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    List data = [
      {
        'title': '我的积分',
        'subTitle': '积分兑好礼',
        'titleColor': '1B1D33',
        'subTitleColor': 'FF6C00',
        'url': SCAsset.iconMineScore
      },
      {
        'title': '我的红包',
        'subTitle': '可用红包12张',
        'titleColor': '1B1D33',
        'subTitleColor': '5E5F66',
        'url': SCAsset.iconMineRedPacket
      }
    ];
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 9.0,
        crossAxisCount: 2,
        shrinkWrap: true,
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return gridItem(
              title: data[index]['title'],
              subTitle: data[index]['subTitle'],
              titleColor: SCHexColor(data[index]['titleColor']),
              subTitleColor: SCHexColor(data[index]['subTitleColor']),
              url: data[index]['url'],
              index: index
          );
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// gridItem
  Widget gridItem(
      {required String title,
      required String subTitle,
      required Color titleColor,
      required Color subTitleColor,
      required String url,
      required int index
      }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap?.call(index);
        }
      },
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.only(left: 12.0, right: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            contentItem(
                title: title,
                subTitle: subTitle,
                titleColor: titleColor,
                subTitleColor: subTitleColor),
            iconItem(url: url),
          ],
        ),
      ),
    );
  }

  /// 内容-item
  Widget contentItem(
      {required String title,
      required String subTitle,
      required Color titleColor,
      required Color subTitleColor}) {
    return Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w500,
            color: titleColor,
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              subTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: subTitleColor,
              ),
            ),
            SizedBox(
              width: 3.0,
            ),
            Image.asset(
              SCAsset.iconMineDetailOrange,
              width: 8.0,
              height: 8.0,
              fit: BoxFit.cover,
              color: subTitleColor,
            ),
          ],
        ),
      ],
    ));
  }

  /// icon-item
  Widget iconItem({required String url}) {
    return Image.asset(
      url,
      width: 39.0,
      height: 39.0,
      fit: BoxFit.cover,
    );
  }
}
