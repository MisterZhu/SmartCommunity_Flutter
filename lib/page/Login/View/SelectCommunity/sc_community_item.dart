import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/page/Login/Model/sc_community_model.dart';

import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';
import '../../../../utils/Router/sc_router_helper.dart';
import '../../GetXController/sc_search_community_controller.dart';

/// 选择社区列表cell

class SCCommunityItem extends StatelessWidget {
  final SCCommunityModel model;
  final SCSelectHouseLogicType type;

  const SCCommunityItem({Key? key, required this.model, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      child: Container(
        color: SCColors.color_FFFFFF,
        padding: const EdgeInsets.only(left: 16.0, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            topItem(),
            const SizedBox(
              height: 6,
            ),
            Text(
              model.address ?? '',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_8D8E99),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 0.5,
                color: SCColors.color_EDEDF0)
          ],
        ),
      ),
      onTap: () {
        SCSearchCommunityController state =
            Get.find<SCSearchCommunityController>();
        state.hideKeyboard();

        if (type == SCSelectHouseLogicType.login) {
          /// 去选房号
          var params = {
            'communityId': model.id,
            'communityName': model.name,
            'type': type
          };
          SCRouterHelper.codePage(20001, params);
        } else {
          var params = {
            'communityId': model.id,
            'communityName': model.name,
          };
          SCRouterHelper.back(params);
        }
      },
    );
  }

  Widget topItem() {
    String distance = '';
    if (model.distance != null) {
      distance = '${model.distance}m';
    }
    return Container(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              model.name ?? '',
              style: const TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33),
            ),
            Container(
              padding: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                distance,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33),
              ),
            ),
          ],
        ));
  }
}
