import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../../Constants/sc_colors.dart';
import '../../../Constants/sc_fonts.dart';

/// 首页-精选商品item

class SCHomeSelectedGoodsItem extends StatelessWidget {
  /// 大标题
  final String title = '精选商品';

  /// 详情标题
  final String detailTitle = '每日10点开抢';

  /// 商品图片宽度
  final double goodsImageWidth = 79.0;

  /// 商品图片宽度
  final double goodsImageHeight = 73.0;

  /// 标签图片宽度
  final double tagImageWidth = 60.0;

  /// 标签图片宽度
  final double tagImageHeight = 16.0;

  /// 金额文本框高度
  final priceTextHeight = 18.0;

  List dataList = [
    {'imageUrl' : SCAsset.homeGoods1, 'tagImageUrl' : SCAsset.homeGoodsTag3, 'price' : '1580'},
    {'imageUrl' : SCAsset.homeGoods2, 'tagImageUrl' : SCAsset.homeGoodsTag1, 'price' : '128'},
    {'imageUrl' : SCAsset.homeGoods3, 'tagImageUrl' : SCAsset.homeGoodsTag2, 'price' : '568'},
    {'imageUrl' : SCAsset.homeGoods4, 'tagImageUrl' : SCAsset.homeGoodsTag2, 'price' : '456'},
  ];

  /// cell点击事件
  final Function(int index)? tapAction;

  SCHomeSelectedGoodsItem({Key? key, this.tapAction}) : super(key: key);

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
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            titleItem(),
            shoppingListView(),
          ],
        ),
      ),
    );
  }

  /// titleItem
  Widget titleItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      child: SizedBox(
        height: titleHeight(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleWidget(),
            detailWidget(),
          ],
        ),
      ),
    );
  }

  /// 标题widget
  Widget titleWidget() {
    return Text(
      title,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }

  /// 详情widget
  Widget detailWidget() {
    return GestureDetector(
      onTap: () {
        moreDetailAction();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(detailTitle,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: SCFonts.f10,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_8D8E99)),
          const SizedBox(
            width: 2.0,
          ),
          Image.asset(
            SCAsset.iconDropDownGray,
            width: 14.0,
            height: 14.0,
          )
        ],
      ),
    );
  }

  /// 商品listView
  Widget shoppingListView() {
    return SizedBox(
      height: cellHeight(),
      child: StaggeredGridView.countBuilder(
        scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 6.0, right: 0.0, top: 0.0, bottom: 0.0),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 4,
          shrinkWrap: true,
          itemCount: dataList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return shoppingCell(index: index);
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          }),
    );
    return SizedBox(
      height: cellHeight(),
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return shoppingCell(index: index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return separatorLine();
          },
          itemCount: dataList.length),
    );
  }

  /// 商品cell
  Widget shoppingCell({required int index}) {
    var model = dataList[index];
    return GestureDetector(
      onTap: () {
        if (tapAction != null) {
          tapAction?.call(index);
        }
      },
      child: Container(
        width: 76.0,
        color: Colors.white,
        child: Column(
          children: [
            goodsImage(url: model['imageUrl']),
            const SizedBox(
              height: 6.0,
            ),
            goodsTagImage(url: model['tagImageUrl']),
            const SizedBox(
              height: 6.0,
            ),
            goodsPriceText(price: model['price']),
            const SizedBox(
              height: 6.0,
            ),
          ],
        ),
      ),
    );
  }

  /// 商品图片
  Widget goodsImage({required String url}) {
    return Image.asset(url, width: goodsImageWidth, height: goodsImageHeight,);
  }

  /// 商品标签图片
  Widget goodsTagImage({required String url}) {
    return Image.asset(url, width: tagImageWidth, height: tagImageHeight,);
  }

  /// 商品价格text
  Widget goodsPriceText({required String price}) {
    String priceString = '¥ $price';
    return SizedBox(
      height: priceTextHeight,
      child: Align(
        alignment: Alignment.center,
        child: Text(priceString, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w500,
            color: SCColors.color_FA4C41
        ),),
      ),
    );
  }

  /// listView分割线
  Widget separatorLine() {
    return const SizedBox(
      width: 5.0,
    );
  }

  /// 更多详情
  moreDetailAction() {}

  /// 标题文本高度
  double titleHeight() {
    return 22.0;
  }

  /// cell高度
  double cellHeight() {
    return goodsImageHeight + 6.0 + tagImageHeight + 6.0 + priceTextHeight + 6.0;
  }
}
