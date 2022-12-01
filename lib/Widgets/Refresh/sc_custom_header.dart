import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Utils/sc_utils.dart';

/// 自定义下拉刷新header

enum SCCustomHeaderStyle {
  // 有导航栏的header
  normal,
  // 没有导航栏的header
  noNavigation
}

class SCCustomHeader extends StatelessWidget {

  final SCCustomHeaderStyle style;

  const SCCustomHeader({
    Key? key,
    this.style = SCCustomHeaderStyle.normal
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (style == SCCustomHeaderStyle.noNavigation) {
      return noNavigationHeader(context);
    } else {
      return normalHeader(context);
    }
  }

  /// 有导航栏的header
  Widget normalHeader(BuildContext context) {
    double radius = 12.0;
    return CustomHeader(
      builder: (context, mode) {
        return Center(
          child: CupertinoActivityIndicator(
            radius: radius,
          ),
        );
      },
    );
  }

  /// 没有导航栏的header
  Widget noNavigationHeader(BuildContext context) {
    double radius = 12.0;
    double verticalPadding = 6.0;
    double height =
        radius + verticalPadding * 2 + SCUtils().getTopSafeArea();
    return CustomHeader(
      height: height,
      builder: (context, mode) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Center(
            child: CupertinoActivityIndicator(
              radius: radius,
            ),
          ),
        );
      },
    );
  }
}
