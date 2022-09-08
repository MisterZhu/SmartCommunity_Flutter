import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
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

  const SCMineHeaderItem(
      {Key? key,
      this.backgroundImageUrl = SCAsset.iconMineBackground,
      this.backgroundImageScale = 750.0 / 380.0})
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        userInfoItem(),
        const SizedBox(
          height: 20.0,
        ),
        memberInfoBackgroundImageItem(),
      ],
    );
  }

  /// 用户头像等信息
  Widget userInfoItem() {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQueryData.fromWindow(window).padding.top + 44.0),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
        height: 48.0,
        child: Row(
          children: [
            Image.asset(
              SCAsset.iconMineUserHead,
              width: 48.0,
              height: 48.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
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
            GestureDetector(
              child: Image.asset(
                SCAsset.iconSettingBlack,
                width: 20.0,
                height: 20.0,
                fit: BoxFit.cover,
              ),
              onTap: () {
                // todo 跳转到设置页面  此处当作测试  跳转到webView  后续修改
                /* Map<String, dynamic> routeParams = {'title': '这是webView',
                  'url':'https://saasprod.4001113900.com:10020/h5new/newUser/index.html#/volunteer/home?companyCode=ss&defCommunityId=fe38ad0a-beaa-11eb-bdca-005056b13afd&appVersion=139&defLatitude=30.28529&mobileType=131&mobileVersion=10&defAreaCode=330106&mobileNo=uuidd5000eda-b8c8-4200-9621-f3b285e83ccb&version=2&defLongitude=120.06839&token=47a2ab63-c82e-46b4-9aa6-6cfd1a27121f&defRoomId=2759511&time=1660196749&defOrgId=2678533&mobileName=HUAWEI TAS-AL00'};
                SCRouterHelper.codePage(20000, routeParams);*/

                // todo wangtao
                var params = {
                  "communityId": "38f258cd-89c7-11ea-bf80-005056b167dc",
                  "communityName": "海滨项目",
                  "type": SCSelectHouseLogicType.addHouse
                };
                SCRouterHelper.codePage(20001, params);
              },
            )
          ],
        ),
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
      child: AspectRatio(
        aspectRatio: memberBackgroundImageScale,
        child: Image.asset(
          SCAsset.iconMineMemberBackground,
          fit: BoxFit.cover,
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
}
