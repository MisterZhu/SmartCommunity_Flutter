import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';

/// 我的页面-header

class SCMineHeaderItem extends StatelessWidget {
  /// 背景图片比例
  final double backgroundImageScale;

  /// 背景图片url
  final String backgroundImageUrl;

  /// 会员背景图片比例
  final double memberBackgroundImageScale = 686.0 / 103.0;

  /// 用户名
  final String userName = '李莉莉';

  /// 点击设置
  final Function? settingTap;

  /// 点击头像
  final Function? headerTap;

  /// 点击会员
  final Function? membershipTap;

  const SCMineHeaderItem(
      {Key? key,
      this.backgroundImageUrl = SCAsset.iconMineBackground,
      this.backgroundImageScale = 750.0 / 380.0,
      this.settingTap,
      this.headerTap,
      this.membershipTap
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Stack(
      children: [
        backgroundImageItem(),
        contentItem(),
      ],
    );
  }

  /// 背景图片
  Widget backgroundImageItem() {
    return AspectRatio(
      aspectRatio: backgroundImageScale,
      child: Image.asset(
        backgroundImageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  /// content
  Widget contentItem() {
    return Positioned(
      left: 0, right: 0, bottom: 0,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        userInfoItem(),
        const SizedBox(
          height: 20.0,
        ),
        memberInfoBackgroundImageItem(),
      ],
    ));
  }

  /// 用户头像等信息
  Widget userInfoItem() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
      height: 48.0,
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              headerAction();
            },
            child: Image.asset(
              SCAsset.iconMineUserHead,
              width: 48.0,
              height: 48.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          GestureDetector(
            onTap: () {
              headerAction();
            },
            child: LimitedBox(
              maxWidth: 100.0,
              child: Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: SCFonts.f16,
                  color: SCColors.color_1B1D33,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child:SizedBox(),
          ),
          GestureDetector(
            child: Image.asset(
              SCAsset.iconSettingBlack,
              width: 20.0,
              height: 20.0,
              fit: BoxFit.cover,
            ),
            onTap: () {
              settingAction();
            },
          )
        ],
      ),
    );
  }

  /// 会员等信息内容
  Widget memberInfoItem() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
      child: Stack(
        children: [
          memberInfoBackgroundImageItem(),
          memberInfoContentItem(),
        ],
      ),
    );
  }

  /// 会员背景图片
  Widget memberInfoBackgroundImageItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: (){
          membershipAction();
        },
        child: AspectRatio(
          aspectRatio: memberBackgroundImageScale,
          child: Image.asset(
            SCAsset.iconMineMemberBackground,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// 会员信息，这个组件暂时无用，UI切成整张图片了
  Widget memberInfoContentItem() {
    return Positioned(
        left: 14.0,
        right: 14.0,
        top: 0,
        bottom: 0,
        child: Row(
          children: [
            Image.asset(
              SCAsset.iconMineDiamond,
              width: 13.0,
              height: 13.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 6.5,
            ),
            const Text(
              '会员中心',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w600,
                color: SCColors.color_F2E1CF,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Container(
              width: 0.5,
              height: 16.0,
              color: SCColors.color_FCD6AD,
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
              '加入享更多权益',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: SCFonts.f13,
                fontWeight: FontWeight.w400,
                color: SCColors.color_F2E1CF,
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 22.0,
              decoration: BoxDecoration(
                  color: SCColors.color_F2E1CF,
                  borderRadius: BorderRadius.circular(11.0)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('开通会员',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_393123,
                      )),
                  Image.asset(
                    SCAsset.iconMineDetailBlack,
                    width: 7.0,
                    height: 7.0,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            )
          ],
        ));
  }

  /// 点击设置
  settingAction() {
    if (settingTap != null) {
      settingTap?.call();
    }
  }

  /// 点击头像
  headerAction() {
    if (headerTap != null) {
      headerTap?.call();
    }
  }

  /// 点击会员
  membershipAction() {
    if (membershipTap != null) {
      membershipTap?.call();
    }
  }
}
