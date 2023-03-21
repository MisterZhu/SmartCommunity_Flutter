
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import '../../../Constants/sc_asset.dart';

/// 消息cell

class SCMessageCardCell extends StatelessWidget {

  /// 类型
  final int type;

  /// icon
  final String? icon;

  /// 标题
  final String? title;

  /// 时间
  final String? time;

  /// 内容
  final String? content;

  /// 内容描述
  final String? contentDesc;

  /// 内容图标
  final String? contentIcon;

  /// 金额
  final double? money;

  /// 状态描述
  final String? statusDesc;

  /// 底部内容数组
  final List? bottomContentList;

  /// 按钮点击
  final Function? moreBtnTapAction;

  /// 详情
  final Function? detailTapAction;

  SCMessageCardCell({Key? key,
    required this.type,
    this.icon,
    this.title,
    this.time,
    this.content,
    this.contentDesc,
    this.contentIcon,
    this.money,
    this.statusDesc,
    this.bottomContentList,
    this.moreBtnTapAction,
    this.detailTapAction,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return GestureDetector(
      onTap: () {
        detailTapAction?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topView(),
            const SizedBox(
              height: 16.0,
            ),
            middleItem(),
            const SizedBox(
              height: 16.0,
            ),
            bottomItem()
          ],
        )
      ),
    );
  }

  /// middleItem
  Widget middleItem() {
    if (type == 1) {//显示内容描述+价格
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          contentDescItem(),
          const SizedBox(
            height: 6.0,
          ),
          priceItem(),
        ],
      );
    } else if (type == 2) {//显示图片+内容+内容描述
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          contentIconItem(),
          const SizedBox(
            height: 6.0,
          ),
          contentItem(),
          const SizedBox(
            height: 6.0,
          ),
          contentDescItem(),
        ],
      );
    } else {//只显示内容
      return contentItem();
    }
  }

  /// topView
  Widget topView() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(icon ?? SCAsset.iconMessageType, width: 18.0, height: 18.0,),
          const SizedBox(width: 6.0,),
          Expanded(child: Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33)),),
          const SizedBox(width: 20.0,),
          SizedBox(width: 82.0, child: Text(
              time ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_B0B1B8)),),
          GestureDetector(
            onTap: () {
              moreBtnTapAction?.call();
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 24.0,
              height: 22.0,
              alignment: Alignment.centerRight,
              child: Image.asset(SCAsset.iconMessageMore, width: 16.0, height: 16.0,),
            ),
          )
        ],
    );
  }

  /// 价格
  Widget priceItem() {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: Text(
          '¥$money',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SCFonts.f24,
              fontWeight: FontWeight.w500,
              fontFamilyFallback: SCConfig.getPFSCForIOS(),
              color: SCColors.color_1B1D33)),
    );
  }

  /// 内容
  Widget contentItem() {
    return SizedBox(
      width: double.infinity,
      height: 27,
      child: Text(
          content ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SCFonts.f18,
              fontWeight: FontWeight.w500,
              fontFamilyFallback: SCConfig.getPFSCForIOS(),
              color: SCColors.color_1B1D33)),
    );
  }

  /// 内容描述
  Widget contentDescItem() {
    return Text(
        contentDesc ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99));
  }

  /// 内容图片
  Widget contentIconItem() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset(
        contentIcon ?? SCAsset.iconMessageContentDefault,
        width: 79.0,
        height: 79.0,
        fit: BoxFit.fill,),);
  }

  /// bottomItem
  Widget bottomItem() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = bottomContentList?[index];
          return bottomCell(dic['title'] ?? '', dic['content'] ?? '');
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8.0,);
        },
        itemCount: bottomContentList?.length ?? 0);
  }

  /// bottomCell
  Widget bottomCell(String leftText, String rightText) {
    return SizedBox(
      height: 18.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60.0,
              child: Text(
                  leftText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f12,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
            ),
            const SizedBox(width: 8.0,),
            Expanded(child: Text(
                rightText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33)),)
          ]
      ),
    );
  }

}