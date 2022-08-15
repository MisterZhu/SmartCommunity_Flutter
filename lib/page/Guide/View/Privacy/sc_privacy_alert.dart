import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_default_value.dart';
import '../../../../constants/sc_fonts.dart';
import '../../../../utils/Colors/sc_color_hex.dart';
import '../../../../utils/sc_utils.dart';
import '../../Model/sc_privacy_richtext_model.dart';

/// 用户协议和隐私政策弹窗

class SCBasicPrivacyAlert extends StatelessWidget {
  SCBasicPrivacyAlert(
      {Key? key,
      this.isAgree = false,
      this.titleString = '',
      this.contentString = '',
      this.cancelAction,
      this.sureAction,
      this.agreementDetailAction,
      this.agreeAction,
      this.userAgreementUrl = '',
      this.privacyPolicyUrl = ''})
      : super(key: key);

  /// 是否同意用户协议和隐私政策
  final bool isAgree;

  /// 标题
  final String titleString;

  /// 正文
  final String contentString;

  /// 取消
  final Function? cancelAction;

  /// 确定
  final Function? sureAction;

  /// 用户协议url
  final String? userAgreementUrl;

  /// 隐私政策url
  final String? privacyPolicyUrl;

  /// 协议详情
  final Function(String url)? agreementDetailAction;

  /// 勾选协议
  final Function? agreeAction;

  /// 协议富文本
  late List<InlineSpan> richTextList;

  /// 协议富文本类型, 0-间隔,1-image,2-普通文本
  /// 0-间隔(sizeBox)
  static const int richTextType = 0;

  /// 1-图片
  static const int richTextTypeImage = 1;

  /// 2-文本
  static const int richTextTypeText = 2;

  @override
  Widget build(BuildContext context) {
    initData();
    return body();
  }

  /// body
  Widget body() {
    /// 弹窗宽度
    double width = 200;

    if (SCUtils().getScreenWidth() > SCDefaultValue.defaultScreenWidth) {
      width = 311.0;
    } else {
      width = SCUtils().getScreenWidth() - 64.0;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
                color: SCColors.color_FFFFFF,
                borderRadius: BorderRadius.circular(6.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleItem(),
                const SizedBox(
                  height: 20.5,
                ),
                contentItem(),
                const SizedBox(
                  height: 14.0,
                ),
                descriptionItem(),
                const SizedBox(
                  height: 18.0,
                ),
                privacyItem(),
                const SizedBox(
                  height: 18.0,
                ),
                lineH(),
                bottomItem(),
              ],
            ),
          )
        ],
      ),
    );
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
        'title': '同意',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
      {
        'type': richTextTypeText,
        'title': '《用户协议》',
        'imageUrl': '',
        'url': userAgreementUrl,
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': richTextTypeText,
        'title': '和',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
      {
        'type': richTextTypeText,
        'title': '《隐私政策》',
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
                width: 22,
                height: 22,
              )),
          onTap: () {
            selectAgreementAction();
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
        style: TextStyle(fontSize: SCFonts.f14, color: color),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            agreementDetail(url: url);
          });
  }

  /// title
  Widget titleItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.5),
      child: Center(
        child: Text(
          titleString,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: SCFonts.f18,
              color: SCColors.color_1B1C33,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// 正文
  Widget contentItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 190.0,
        child: SingleChildScrollView(
          //正文
          child: Text(
            contentString,
            style: const TextStyle(
                fontSize: SCFonts.f14,
                color: SCColors.color_5E5E66,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  /// 描述
  Widget descriptionItem() {
    String title = '邑生活APP用户协议和隐私协议已于202邑生活APP用户协议和隐私协议已于2022';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_1B1D33,
            fontWeight: FontWeight.normal),
      ),
    );
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

  /// 水平分割线
  Widget lineH() {
    return const Divider(
      color: SCColors.color_D7D7DB,
      height: 1,
    );
  }

  /// 垂直分割线
  Widget lineV() {
    return Container(
      width: 0.5,
      height: 44.0,
      color: SCColors.color_D7D7DB,
    );
  }

  /// 同意或取消按钮
  Widget sureOrCancelBtn({required String title, required int index}) {
    return SizedBox.expand(
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: SCFonts.f16,
                color: SCColors.color_1B1C33,
                fontWeight: FontWeight.normal),
          ),
          onPressed: () {
            if (index == 0) {
              // 取消
              cancelBtnAction();
            } else {
              // 同意
              sureBtnAction();
            }
          }),
    );
  }

  /// 底部按钮
  Widget bottomItem() {
    return SizedBox(
      height: 44.0,
      child: Row(
        children: [
          Expanded(flex: 1, child: sureOrCancelBtn(title: '取消', index: 0)),
          lineV(),
          Expanded(flex: 1, child: sureOrCancelBtn(title: '同意并使用', index: 1)),
        ],
      ),
    );
  }

  /// 勾选协议
  selectAgreementAction() {
    if (agreeAction != null) {
      agreeAction?.call();
    }
  }

  /// 协议详情
  agreementDetail({required String url}) {
    if (agreementDetailAction != null) {
      agreementDetailAction?.call(url);
    }
  }

  /// 取消
  cancelBtnAction() {
    if (cancelAction != null) {
      cancelAction?.call();
    }
  }

  /// 同意并使用
  sureBtnAction() {
    if (sureAction != null) {
      sureAction?.call();
    }
  }
}
