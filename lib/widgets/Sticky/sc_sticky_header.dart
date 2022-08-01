/// 吸顶组件

import 'package:flutter/material.dart';

import 'sc_sticky_render.dart';

typedef StickyHeaderWidgetBuilder = Widget Function(BuildContext context, double stuckAmount);

class SCStickyHeader extends MultiChildRenderObjectWidget {
  /// Constructs a new [StickyHeader] widget.
  SCStickyHeader({
    Key? key,
    required this.header,
    required this.content,
    this.overlapHeaders: false,
    this.controller,
    this.callback,
  }) : super(
    key: key,
    // Note: The order of the children must be preserved for the RenderObject.
    children: [content, header],
  );

  /// Header to be shown at the top of the parent [Scrollable] content.
  final Widget header;

  /// Content to be shown below the header.
  final Widget content;

  /// If true, the header will overlap the Content.
  final bool overlapHeaders;

  /// Optional [ScrollController] that will be used by the widget instead of the default inherited one.
  final ScrollController? controller;

  /// Optional callback with stickiness value. If you think you need this, then you might want to
  /// consider using [StickyHeaderBuilder] instead.
  final RenderStickyHeaderCallback? callback;

  @override
  SCRenderStickyHeader createRenderObject(BuildContext context) {
    final scrollPosition = controller?.position ?? Scrollable.of(context)!.position;
    return SCRenderStickyHeader(
      scrollPosition: scrollPosition,
      callback: callback,
      overlapHeaders: overlapHeaders,
    );
  }

  @override
  void updateRenderObject(BuildContext context, SCRenderStickyHeader renderObject) {
    final scrollPosition = controller?.position ?? Scrollable.of(context)!.position;
    renderObject
      ..scrollPosition = scrollPosition
      ..callback = callback
      ..overlapHeaders = overlapHeaders;
  }
}