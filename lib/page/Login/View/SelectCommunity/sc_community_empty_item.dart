import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';

class SCCommunityEmptyItem extends StatelessWidget {

  final String? imageName;

  final String? content;
  /// 按钮标题
  final String? buttonTitle;

  final bool showButton;

  /// 取消
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
            imageName ?? 'iconCommunityNoData',
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