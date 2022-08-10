import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_default_value.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

/// 登录logo

class SCLoginLogo extends StatelessWidget {
  const SCLoginLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Padding(
      padding: const EdgeInsets.only(top: 62.5, bottom: 88.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            SCAsset.iconLogo168,
            width: 56.0,
            height: 56.0,
          ),
          const SizedBox(
            height: 14.0,
          ),
          const Text(
            SCDefaultValue.appName,
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.normal,
                color: SCColors.color_1B1C33),
          )
        ],
      ),
    );
  }
}
