import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

/// 我的页面-header

class SCMineHeaderItem extends StatelessWidget {
  /// 背景图片比例
  final double backgroundImageScale;

  /// 背景图片url
  final String backgroundImageUrl;

  /// 会员背景图片比例
  final double memberBackgroundImageScale = 686.0 / 103.0;

  /// 用户名
  final String? userName;

  /// 用户头像
  final String? userPic;

  /// 点击设置
  final Function? settingTap;

  /// 点击头像
  final Function? headerTap;

  /// 点击会员
  final Function? membershipTap;

  /// 点击我的房屋
  final Function? myHouseTap;

  /// 点击我的账单
  final Function? myBillTap;

  /// 点击我的优惠券
  final Function? myCoupon;

  /// 点击意见反馈
  final Function? feedback;

  const SCMineHeaderItem(
      {Key? key,
      this.backgroundImageUrl = SCAsset.iconMineBackground,
      this.backgroundImageScale = 375.0 / 200.0,
      this.settingTap,
      this.headerTap,
      this.membershipTap,
      this.userName = "",
      this.userPic,
      this.myHouseTap,
      this.myBillTap,
      this.myCoupon,
      this.feedback,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        backgroundImageItem(),
        contentItem(),
      ],
    );
  }

  /// 背景图片
  Widget backgroundImageItem() {
    return SizedBox(
        width: double.infinity,
        height: getImageHeight(),
        child: AspectRatio(
          aspectRatio: backgroundImageScale,
          child: SCUtils.imageWidget(url: backgroundImageUrl, fit: BoxFit.cover)
        ),
    );
  }

  /// content
  Widget contentItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getImageHeight() - 90.0,
          ),
          userInfoItem(),
          const SizedBox(
            height: 17.0,
          ),
          //memberInfoBackgroundImageItem(),
          serviceItem(),
        ],
      );
  }

  /// 用户头像等信息
  Widget userInfoItem() {
    String name = userName ?? '';
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
      height: 48.0,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              headerAction();
            },
            behavior: HitTestBehavior.opaque,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: SCUtils.imageWidget(
                  url: userPic ?? '',
                  width: 48.0,
                  height: 48.0,
                  fit: BoxFit.cover),
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
                name,
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
          const Expanded(child: SizedBox(),),
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
        onTap: () {
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
            SCUtils.imageWidget(
              url: userPic ?? SCAsset.iconMineUserDefault,
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

  /// serviceItem
  Widget serviceItem() {
    List list = [
      {'icon': SCAsset.iconMyHouse, 'name': '我的房屋'},
      {'icon': SCAsset.iconMyBill, 'name': '我的账单'},
      {'icon': SCAsset.iconMyBill, 'name': '我的优惠券'},
      {'icon': SCAsset.iconMyBill, 'name': '意见反馈'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var dic = list[index];
              return cell(dic['icon'], dic['name'], index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: SCColors.color_FFFFFF,
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  height: 0.5,
                  width: double.infinity,
                  color: SCColors.color_EDEDF0,
                ),
              );
            },
            itemCount: list.length),
      ),
    );
  }

  Widget cell(String icon, String name, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          myHouseTap?.call();
        } else if (index == 1) {
          myBillTap?.call();
        } else if (index == 2) {
          myCoupon?.call();
        } else if (index == 3) {
          feedback?.call();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 54.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 18.0,
              height: 18.0,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w500,
                      color: SCColors.color_1B1D33),
                )),
            const SizedBox(
              width: 9.0,
            ),
            Image.asset(
              SCAsset.iconMineDetailGrey,
              width: 16.0,
              height: 16.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  getImageHeight() {
    return SCUtils().getScreenWidth() / backgroundImageScale;
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
