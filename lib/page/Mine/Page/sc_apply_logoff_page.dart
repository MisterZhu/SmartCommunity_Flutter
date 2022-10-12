
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';
import '../../../skin/View/sc_custom_scaffold.dart';
import '../../../utils/Router/sc_router_helper.dart';
import '../../../utils/Router/sc_router_path.dart';

/// 申请注销账户page
class SCApplyLogoffPage extends StatefulWidget {

  SCApplyLogoffPageState createState() => SCApplyLogoffPageState();
}

class SCApplyLogoffPageState extends State<SCApplyLogoffPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: "注销账户", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_FFFFFF,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 52.0,),
            titleItem(),
            const SizedBox(height: 20.0,),
            contentItem(),
            const SizedBox(height: 20.0,),
            conditionItem('账户无剩余余额'),
            const SizedBox(height: 12.0,),
            conditionItem('账户未存在办理中的业务（如找回密码、绑定修改手机等）'),
            const SizedBox(height: 52.0,),
            btnItem(),
          ],
      ),)
    );
  }

  Widget titleItem() {
    return const Text(
      '申请注销账户',
      textAlign: TextAlign.left,
      maxLines: 1,
      style: TextStyle(
          fontSize: SCFonts.f20,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1C33),
    );
  }

  Widget contentItem() {
    return const Text(
      '若注销账户，需同时满足以下条件：',
      textAlign: TextAlign.left,
      maxLines: 1,
      style: TextStyle(
          fontSize: SCFonts.f13,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5E66),
    );
  }

  /// 条件item
  Widget conditionItem(String content) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            width: 4.0,
            height: 4.0,
            decoration: BoxDecoration(
                color: SCColors.color_8D8E99,
                borderRadius: BorderRadius.circular(2.0)
            ),
          ),
        ),
        const SizedBox(width: 6.0,),
        Expanded(child: Text(
          content,
          textAlign: TextAlign.left,
          maxLines: 2,
          style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1C33),
        ))
      ],
    );
  }

  /// 下一步按钮
  Widget btnItem() {
    return SizedBox(
      width: double.infinity,
      height: 40.0,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: SCColors.color_FF6C00,
          borderRadius: BorderRadius.circular(4.0),
          child: const Text(
            '下一步',
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_FFFFFF,
            ),
          ),
          onPressed: () {
            SCRouterHelper.pathPage(SCRouterPath.logoffPath, null);
          }),
    );
  }

}