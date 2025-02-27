import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SCTabIndicator extends Decoration {
  SCTabIndicator({
    required this.borderSide,
    this.insets = EdgeInsets.zero,
  });

  BorderSide borderSide;
  EdgeInsetsGeometry? insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is SCTabIndicator) {
      return SCTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is SCTabIndicator) {
      return SCTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TmdPainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect? indicator = insets?.resolve(textDirection).deflateRect(rect);
    const lineWidth = 56.0;
    double dx = indicator?.center.dx ?? 0;
    double bottom = indicator?.bottom ?? 0;
    return Rect.fromLTWH(
      dx - lineWidth / 2,
      bottom - borderSide.width,
      lineWidth,
      borderSide.width,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _TmdPainter extends BoxPainter {
  _TmdPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  final SCTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    Size size = configuration.size ?? Size.zero;
    final Rect rect = offset & size;
    final TextDirection textDirection = configuration.textDirection ?? TextDirection.ltr;
    final Rect indicator = decoration
        ._indicatorRectFor(rect, textDirection)
        .deflate(decoration.borderSide.width / 2.0);
    final Paint paint = decoration.borderSide.toPaint()
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}