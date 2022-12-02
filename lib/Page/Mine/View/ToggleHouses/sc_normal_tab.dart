/*normal tab*/

import 'package:flutter/cupertino.dart';

class SCNormalTab extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final TextStyle textStyle;

  SCNormalTab({Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: Text(
          text,
          style: textStyle,
        ));
  }
}
