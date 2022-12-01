/*带消息框的tab*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/sc_utils.dart';


class SCMessageTab extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final TextStyle textStyle;
  final Color circleColor;
  final Color numberColor;
  final String numberText;

  SCMessageTab({Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.textStyle,
    required this.circleColor,
    required this.numberColor,
    required this.numberText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle numberStyle = TextStyle(
        color: numberColor,
        fontSize: 12.0
    );
    Size numberSize = SCUtils.boundingTextSize(context, numberText, numberStyle);
    double maxWidth = numberSize.width > 10.0 ? numberSize.width + 10.0 : 16;
    double left = numberSize.width > 10.0 ? maxWidth/2.0 + 8.0 : maxWidth/2.0 + 5.0;
    double right = left;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 8.0, right: right ,bottom: 8,left: left ),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle),
          ),
          Positioned(
            top: 2.0,
            right: 0.0,
            child: Container(
              alignment: Alignment.center,
              width: maxWidth,
              height: 16,
              decoration: BoxDecoration(
                  color: circleColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              child: Text(numberText, style: numberStyle,),
            ),
          ),
        ],
      ),
    );
  }
}
