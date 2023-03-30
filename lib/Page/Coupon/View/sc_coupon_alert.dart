import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Coupon/View/sc_coupon_cell.dart';
import '../../../Constants/sc_asset.dart';

/// 优惠券弹窗

class SCCouponAlert extends StatefulWidget {
  SCCouponAlert({Key? key,
    this.getAction,
  }) : super(key: key);

  /// 获取
  final Function(int index)? getAction;

  @override
  SCCouponAlertState createState() => SCCouponAlertState();
}

class SCCouponAlertState extends State<SCCouponAlert> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 394.0 + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleItem(),
          Expanded(child: listView()),
          Container(
            color: SCColors.color_F5F5F5,
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  /// title
  Widget titleItem() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 16.0),
      height: 48.0,
      child: Row(
        children: [
          const Expanded(
            child: Text(
              '店铺优惠券',
              maxLines: 1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_1B1D33),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 48.0,
              child: Image.asset(
                SCAsset.iconCouponClose,
                width: 20.0,
                height: 20.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  Widget listView() {
    return Container(
      color: SCColors.color_F5F5F5,
      child: ListView.separated(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 24.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SCCouponCell(
              status: index,
              name: '店铺优惠券100',
              validity: '有效期至2022-05-10 12:00',
              money: '100',
              condition: '满200可用',
              getAction: () {
                widget.getAction?.call(index);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0,);
          },
          itemCount: 5),
    );
  }

}