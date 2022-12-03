

import 'package:flutter/cupertino.dart';

import 'package:sc_uikit/sc_uikit.dart';

class SCMineHouseTagItem extends StatelessWidget {

  SCMineHouseTagItem({Key? key,
    required this.name,
    required this.bgColor,
    required this.textColor})
      : super(key: key);

  String name;
  Color bgColor;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(2.0)),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w500,
            color: textColor),
      ),
    );
  }
}
