
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';

/// 完善资料弹窗
class SCImproveDataAlert extends StatelessWidget {

  SCImproveDataAlert({
    Key? key,
    required this.list,
    this.nameAction,
    this.birthdayAction,
    this.genderAction,
    this.sureAction,
  }) : super(key: key);

  final List list;

  /// 点击确定按钮
  final Function? sureAction;

  /// 点击姓名
  final Function? nameAction;
  /// 点击出生日期
  final Function? birthdayAction;
  /// 点击性别
  final Function? genderAction;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 300.0,
              height: 326.0,
              decoration: BoxDecoration(
                  color: SCColors.color_FFFFFF,
                  borderRadius: BorderRadius.circular(4.0)),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  bgItem(),
                  contentItem(),
                ],
              )
          )
        ],
      ),
    );
  }

  /// 背景图
  Widget bgItem() {
    return Image.asset(
      SCAsset.iconImproveDataBg,
      width: 300.0,
      height: 326.0,
      fit: BoxFit.cover,
    );
  }

  /// 内容
  Widget contentItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headItem(),
        Expanded(child: bottomItem()),
      ]
    );
  }

  /// headItem
  Widget headItem() {
    return Container(
      height: 94.0,
      padding: const EdgeInsets.only(left: 20.0, top: 18.0, bottom: 24.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '尊敬的用户，您好！',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: SCFonts.f18,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_1B1D33),
            ),
            SizedBox(height: 6.0,),
            Text(
              '请完善个人资料，以便获取更优质的服务',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: SCFonts.f12,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_5E5F66),
            )
          ]
      ),
    );
  }

  /// bottomItem
  Widget bottomItem() {
    return Container(
      width: 300.0,
      decoration: BoxDecoration(
      color: SCColors.color_FFFFFF,
      borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: listview()),
          line(),
          sureItem(),
        ]
      )
    );
  }

  Widget listview() {
    return  ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var dic = list[index];
          return cellItem(dic['required'], dic['name'], dic['content']);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: list.length);
  }

  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 21.0, right: 15.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }
  /// cell
  Widget cellItem(bool required, String name, String content) {
    Color contentColor = content == '请输入'  || content == '请选择' ? SCColors.color_B0B1B8 : SCColors.color_5E5F66;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (name == '姓名') {
          nameAction?.call();
        } else if (name == '出生日期') {
          birthdayAction?.call();
        } else if (name == '性别') {
          genderAction?.call();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 13.0, right: 15.0),
        height: 48.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 8.0,
              child: Offstage(
                offstage: !required,
                child: const Text(
                  '*',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_FF4040),
                ),
              ),
            ),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33),
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
                child: Text(
                  content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: contentColor),
                )),
            Image.asset(
              SCAsset.iconMineDetailGrey,
              width: 16.0,
              height: 16.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
  
  /// 确定按钮
  Widget sureItem() {
    return Container(
      height: 88.0,
      padding: const EdgeInsets.only(left: 21.0, right: 21.0, top: 20.0, bottom: 24.0),
      child: SizedBox(
        width: double.infinity,
        height: 44.0,
        child: CupertinoButton(
          onPressed: () {
            sureAction?.call();
          },
          padding: EdgeInsets.zero,
          color: SCColors.color_FF6C00,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          child: const Text(
            '确定',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_FFFFFF),
          ),
        ),
      ),
    );
  }

}
