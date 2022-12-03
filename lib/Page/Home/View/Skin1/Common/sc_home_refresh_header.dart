
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:sc_uikit/sc_uikit.dart';

double get maxDragOffset => 100;
double hideHeight = maxDragOffset / 2.3;
double refreshHeight = maxDragOffset / 1.5;

class SCHomeRefreshHeader extends StatelessWidget {
  const SCHomeRefreshHeader(
    Key? key,
    this.info,
    this.lastRefreshTime, {
    this.color,
  });

  final PullToRefreshScrollNotificationInfo? info;
  final DateTime? lastRefreshTime;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final PullToRefreshScrollNotificationInfo? _info = info;
    if (_info == null) {
      return Container();
    }

    final double dragOffset = info?.dragOffset ?? 0.0;
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.bottomCenter,
      height: dragOffset,
      color: color ?? Colors.transparent,
      child: const CupertinoActivityIndicator(
        radius: 16,
        activeColor: SCColors.color_1B1C33,
      ),
    );
  }
}
