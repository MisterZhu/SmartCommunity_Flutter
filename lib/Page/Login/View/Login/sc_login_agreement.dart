import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_agreement_item.dart';
import '../../../../Constants/sc_asset.dart';

/// 登录-协议item

class SCLoginAgreement extends StatelessWidget {
  SCLoginAgreement(
      {Key? key,
      required this.list,
      this.isAgree = false,
      this.agreementDetailAction,
      this.agreeAction,
      }) : super(key: key);

  final List list;

  /// 是否同意用户协议和隐私政策
  final bool isAgree;

  /// 协议详情
  final Function(String title,String url)? agreementDetailAction;

  /// 勾选协议
  final Function? agreeAction;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        bgImageItem(),
        privacyItem()
      ],
    );
  }

  /// 背景图片
  Widget bgImageItem() {
    double imageScale = 750 / 320.0;
    return AspectRatio(
      aspectRatio: imageScale,
      child: Image.asset(
        SCAsset.iconLoginBottomBg,
        fit: BoxFit.cover,
      ),
    );
  }

  /// 用户协议和隐私政策
  Widget privacyItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectItem(),
          agreementItem()
        ],
      )
    );
  }

  Widget selectItem() {
    return Padding(padding: EdgeInsets.only(top: 0.0),
      child: GestureDetector(
        onTap: () {
          if (agreeAction != null) {
            agreeAction?.call();
          }
        },
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.topCenter,
          color: Colors.transparent,
          child: Image.asset(
            isAgree ? SCAsset.iconAgree : SCAsset.iconNotAgree,
            width: 22.0,
            height: 22.0,
          ),
        ),
      ),
    );
  }

  Widget agreementItem() {
    return Expanded(child: SCAgreementItem(
      list: list,
      isAgree: isAgree,
      agreeAction: () {
        if (agreeAction != null) {
          agreeAction?.call();
        }
      },
      agreementDetailAction: (title, url) {
        if (agreementDetailAction != null && url.isNotEmpty) {
          agreementDetailAction?.call(title, url);
        }
      },
    ));
  }

}
