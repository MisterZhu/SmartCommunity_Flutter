import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:smartcommunity/constants/sc_colors.dart';

/// 首页第一套皮肤-加载更多widget

class SCHomeLoadMoreFooter extends StatelessWidget {
  const SCHomeLoadMoreFooter({Key? key, required this.status, required this.isSliver})
      : super(key: key);

  /// 状态
  final IndicatorStatus status;

  /// 是否是sliver
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    return buildIndicator(context, status);
  }

  Widget buildIndicator(BuildContext context, IndicatorStatus status) {
    Widget? widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(right: 5.0),
              height: 15.0,
              width: 15.0,
              child: getIndicator(context),
            ),
          ],
        );
        widget = _setbackground(false, widget, 35.0);
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(right: 0.0),
              height: 30.0,
              width: 30.0,
              child: getIndicator(context),
            ),
          ],
        );
        widget = _setbackground(true, widget, double.infinity);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.error:
        widget = Container(height: 0.0);
        break;

        break;
      case IndicatorStatus.fullScreenError:
        widget = Container(height: 0.0);
        break;
        break;
      case IndicatorStatus.noMoreLoad:
        widget = const Text('到底了');
        widget = _setbackground(false, widget, 35.0);
        break;
      case IndicatorStatus.empty:
        widget = Container(height: 0.0);
        break;
    }
    return widget;
  }

  Widget _setbackground(bool full, Widget widget, double height) {
    widget = Container(
        width: double.infinity,
        height: height,
        child: widget,
        color: Colors.transparent,
        alignment: Alignment.center);
    return widget;
  }

  Widget getIndicator(BuildContext context) {
    return const CupertinoActivityIndicator(
      animating: true,
      radius: 16.0,
      color: SCColors.color_1B1C33,
    );
  }
}
