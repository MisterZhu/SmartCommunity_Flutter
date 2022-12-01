import 'package:flutter/material.dart';

/// tabbar吸顶

class SCStickyTabBarDelegate extends SliverPersistentHeaderDelegate {

  SCStickyTabBarDelegate({required this.child, required this.height});

  /// child
  final Widget child;

  /// 组件高度
  final double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
