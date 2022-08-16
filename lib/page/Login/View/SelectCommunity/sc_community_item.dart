import 'package:flutter/cupertino.dart';

import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';

/// 选择社区列表cell

class SCCommunityItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topItem(),
          const SizedBox(
            height: 6,
          ),
          const Text(
            '文一西路767号',
            textAlign: TextAlign.left,
            style: TextStyle(
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
    );
  }

  Widget topItem() {
    return Container(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            '慧享生活馆',
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33),
          ),
          Text(
            '<500m',
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33),
          ),
        ],
      )
    );
  }
}
