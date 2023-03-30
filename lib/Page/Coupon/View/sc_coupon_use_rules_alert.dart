import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Constants/sc_asset.dart';

/// 优惠券使用规则弹窗

class SCCouponUseRulesAlert extends StatelessWidget {
  SCCouponUseRulesAlert({Key? key,
    required this.content,
    this.closeAction
  }) : super(key: key);

  /// 内容
  final String content;

  /// 关闭
  final Function? closeAction;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleItem(),
          contentItem(),
          Container(
            color: SCColors.color_FFFFFF,
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  /// title
  Widget titleItem() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 16.0),
      height: 48.0,
      child: Row(
        children: [
          const Expanded(
            child: Text(
              '使用规则',
              maxLines: 1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_1B1D33),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 48.0,
              child: Image.asset(
                SCAsset.iconCouponClose,
                width: 20.0,
                height: 20.0,
              ),
              onPressed: () {
                closeAction?.call();
              }),
        ],
      ),
    );
  }

  /// contentItem
  Widget contentItem() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 24.0),
      height: 190.0,
      child: SingleChildScrollView(
        //正文
        child: Text(
          content,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66),
        ),
      )
    );
  }

}