import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';
import '../../../../utils/Colors/sc_color_hex.dart';
import '../../../Guide/Model/sc_privacy_richtext_model.dart';

/// 登录-协议item

class SCLoginAgreement extends StatelessWidget {
  SCLoginAgreement(
      {Key? key,
      this.isAgree = false,
      this.agreementDetailAction,
      this.agreeAction,
      this.userAgreementUrl = '',
      this.privacyPolicyUrl = ''})
      : super(key: key);

  /// 协议富文本
  late List<InlineSpan> richTextList;

  /// 协议富文本类型, 0-间隔,1-image,2-普通文本
  /// 0-间隔(sizeBox)
  static const int richTextType = 0;

  /// 1-图片
  static const int richTextTypeImage = 1;

  /// 2-文本
  static const int richTextTypeText = 2;

  /// 是否同意用户协议和隐私政策
  final bool isAgree;

  /// 用户协议url
  final String? userAgreementUrl;

  /// 隐私政策url
  final String? privacyPolicyUrl;

  /// 协议详情
  final Function(String url)? agreementDetailAction;

  /// 勾选协议
  final Function? agreeAction;

  @override
  Widget build(BuildContext context) {
    initData();
    return body();
  }

  /// 设置数据
  initData() {
    List<dynamic> list = [
      {
        'type': richTextTypeImage,
        'title': '',
        'imageUrl': isAgree ? SCAsset.iconAgree : SCAsset.iconNotAgree,
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_FFFFFF)
      },
      {
        'type': richTextTypeText,
        'title': '点击登录即代表您已阅读并同意',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
      {
        'type': richTextTypeText,
        'title': '用户服务协议',
        'imageUrl': '',
        'url': userAgreementUrl,
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': richTextTypeText,
        'title': '、',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
      {
        'type': richTextTypeText,
        'title': '隐私政策',
        'imageUrl': '',
        'url': privacyPolicyUrl,
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
    ];

    richTextList = list.map((e) {
      SCPrivacyRichTextModel model = SCPrivacyRichTextModel.fromJson(e);
      if (model.type == richTextTypeImage) {
        return selectItem();
      } else {
        return agreementItem(
            title: model.title ?? '',
            url: model.url ?? '',
            color: SCHexColor(model.color ?? ''));
      }
    }).toList();
  }

  /// body
  Widget body() {
    return privacyItem();
  }

  /// 用户协议和隐私政策
  Widget privacyItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(text: "", children: richTextList)),
    );
  }

  /// 勾选框
  WidgetSpan selectItem() {
    return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: GestureDetector(
          child: Container(
              width: 22.0,
              height: 22.0,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                isAgree ? SCAsset.iconAgree : SCAsset.iconNotAgree,
                width: 16,
                height: 16,
              )),
          onTap: () {
            if (agreeAction != null) {
              agreeAction?.call();
            }
          },
        ));
  }

  /// 协议文本
  TextSpan agreementItem(
      {String title = '',
      String url = '',
      Color color = SCColors.color_1B1C33}) {
    return TextSpan(
        text: title,
        style: TextStyle(fontSize: SCFonts.f12, color: color),
        recognizer: TapGestureRecognizer()..onTap = () {});
  }
}
