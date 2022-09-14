import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

/// 我的-服务列表cell
class SCMineServiceItem extends StatelessWidget {
  List dataList = [
    {'iconUrl': '', 'title': '我的服务'},
    {'iconUrl': SCAsset.iconMineOrder, 'title': '我的订单'},
    {'iconUrl': SCAsset.iconMineExpress, 'title': '我的快递'},
    {'iconUrl': SCAsset.iconMineInteraction, 'title': '我的互动'},
    {'iconUrl': SCAsset.iconMineAddress, 'title': '我的地址'},
  ];

  /// 点击
  final Function(int index)? onTap;

  SCMineServiceItem({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: listViewItem(),
      ),
    );
  }

  /// listView
  Widget listViewItem() {
    return ListView.separated(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16.0, top: 0, bottom: 0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return titleItem(title: dataList[index]['title']);
          } else {
            return contentItem(
              index: index - 1,
                title: dataList[index]['title'],
                iconUrl: dataList[index]['iconUrl']);
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return separatorItem();
        },
        itemCount: dataList.length);
  }

  /// 标题item
  Widget titleItem({required String title}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w500,
            color: SCColors.color_1B1D33),
      ),
    );
  }

  /// 内容item
  Widget contentItem({required String title, required String iconUrl, required int index}) {
    return GestureDetector(
      onTap: () {
        detailAction(index: index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 40.0,
        child: Row(
          children: [
            Image.asset(
              iconUrl,
              width: 16.0,
              height: 16.0,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 9.0,
            ),
            Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33),
                )),
            const SizedBox(
              width: 9.0,
            ),
            Image.asset(
              SCAsset.iconMineDetailGrey,
              width: 16.0,
              height: 16.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  /// separator
  Widget separatorItem() {
    return const SizedBox();
  }

  /// 详情
  detailAction({required int index}) {
    if (onTap != null) {
      onTap?.call(index);
    }
  }
}
