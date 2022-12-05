import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../../../Constants/sc_asset.dart';
import 'package:sc_uikit/sc_uikit.dart';

class SCCommunityEmptyItem extends StatelessWidget {
  /// 图片
  final String? imageName;
  /// 图片下面的提示文字
  final String? content;
  /// 按钮标题
  final String? buttonTitle;
  /// 是否显示底部按钮
  final bool showButton;
  /// 按钮点击事件
  final Function? btnTapAction;

  SCCommunityEmptyItem(
      {
        Key? key,
        this.imageName = SCAsset.iconCommunityNoData,
        this.content = '',
        this.buttonTitle = '',
        this.showButton = false,
        this.btnTapAction,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_FFFFFF,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 34,),
          Image.asset(
            imageName!,
            width: 144.0,
            height: 144.0,
          ),
          Text(
            content ?? '',
            style: const TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_8D8E99),
          ),
          const SizedBox(height: 44,),
          bottomButtonItem()
        ],
      ),
    );
  }

  Widget bottomButtonItem() {
    if (showButton) {
      return CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            width: 128.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: SCColors.color_FF6C00,
                borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              buttonTitle ?? '重新获取',
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_FFFFFF),
            ),
          ),
          onPressed: () {
            /// 按钮点击
            if (btnTapAction != null) {
              btnTapAction?.call();
            }
          });
    } else {
      return const SizedBox(height: 1,);
    }
  }

}