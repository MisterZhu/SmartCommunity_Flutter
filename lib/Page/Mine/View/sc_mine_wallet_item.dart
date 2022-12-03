import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/Model/sc_wallet_model.dart';

/// 我的钱包-cell
class SCMineWalletItem extends StatelessWidget {

  /// 数据源
  List list = [
    {'title': '20', 'unit': '万', "type": 0, 'subTitle': 'II类额度'},
    {'title': '5', 'unit': '万', "type": 0, 'subTitle': 'II类额度'},
    {'title': '免手续费', 'unit': '万', "type": 1, 'subTitle': 'II类额度'},
    {'title': '未开通', 'unit': '万', "type": 2, 'subTitle': 'II类额度'}
  ];

  /// 标题
  final String title = '我的钱包';

  /// 进入钱包按钮标题
  final String gotoWalletTitle = '进入钱包';

  /// 点击
  final Function? onTap;

  SCMineWalletItem({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
     bool isDataEmpty = list.isEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          gotoWalletAction();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            children: [
              titleItem(),
              SizedBox(
                height: isDataEmpty ? 0.0 : 16.0,
              ),
              contentItem(),
            ],
          ),
        ),
      ),
    );
  }

  /// title-item
  Widget titleItem() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 12.0), child: Row(
      children: [
        Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w500,
                color: SCColors.color_1B1D33,
              ),
            )),
        const SizedBox(
          width: 10.0,
        ),
        Row(
          children: [
            Text(
              gotoWalletTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66,
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Image.asset(
              SCAsset.iconMineDetailGrey,
              width: 12.0,
              height: 12.0,
              fit: BoxFit.cover,
            ),
          ],
        )
      ],
    ),);
  }

  /// content-item
  Widget contentItem() {
    List<SCWalletModel> dataList =
        List.from(list).map((e) => SCWalletModel.fromJson(e)).toList();

    return StaggeredGridView.countBuilder(
        padding:
            const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 4.0,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: dataList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return gridItem(model: dataList[index]);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// grid-item
  Widget gridItem({required SCWalletModel model}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        gridTitleItem(model: model),
        const SizedBox(
          height: 6.0,
        ),
        gridSubTitleItem(title: model.subTitle ?? ''),
      ],
    );
  }

  /// grid-title
  Widget gridTitleItem({required SCWalletModel model}) {
    if (model.type == 0) {
      // 金额类型
      return gridMoneyTitleItem(model: model);
    } else if (model.type == 1) {
      // 普通文本类型
      return gridNormalTitleItem(model: model, textColor: SCColors.color_1B1D33);
    } else {
      // 普通文本类型
      return gridNormalTitleItem(model: model, textColor: SCColors.color_FF6C00);
    }
  }

  /// grid-title-金额类型
  Widget gridMoneyTitleItem({required SCWalletModel model}) {
    return RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
        text: TextSpan(
            text: model.title,
            style: const TextStyle(
                fontSize: SCFonts.f18,
                color: SCColors.color_1B1D33,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                  text: model.unit,
                  style: const TextStyle(
                      fontSize: SCFonts.f10,
                      color: SCColors.color_1B1D33,
                      fontWeight: FontWeight.w400))
            ]));
  }

  /// grid-title-普通文本类型
  Widget gridNormalTitleItem({required SCWalletModel model, required Color textColor}) {
    return Text(
      model.title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: SCFonts.f15,
          color: textColor,
          fontWeight: FontWeight.w500),
    );
  }

  /// grid-subTitle
  Widget gridSubTitleItem({required String title}) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: SCFonts.f12,
          color: SCColors.color_5E5F66,
          fontWeight: FontWeight.w400),
    );
  }

  /// 进入钱包
  gotoWalletAction() {
    if (onTap != null) {
      onTap?.call();
    }
  }
}
