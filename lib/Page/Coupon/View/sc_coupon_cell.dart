import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Constants/sc_asset.dart';

/// 优惠券cell

class SCCouponCell extends StatelessWidget {
  /// 状态，0显示规则，1显示已使用，2显示已失效，3显示获取按钮，4显示已领取
  final int status;

  /// 名称
  final String? name;

  /// 有效期
  final String? validity;

  /// 金额
  final String? money;

  /// 满减条件
  final String? condition;

  /// 领取
  final Function? getAction;

  /// 规则
  final Function? ruleAction;

  SCCouponCell({
    Key? key,
    required this.status,
    this.name,
    this.validity,
    this.money,
    this.condition,
    this.getAction,
    this.ruleAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
        width: double.infinity,
        height: 70.0,
        decoration: BoxDecoration(
            color: (status == 1 || status == 2) ? SCColors.color_EDEDF0 : SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftItem(),
            lineItem(),
            const SizedBox(width: 9.0,),
            Expanded(child: middleItem()),
            const SizedBox(width: 10.0,),
            rightItem(),
            const SizedBox(width: 12.0,),
          ],
        ));
  }

  Widget leftItem() {
    return Container(
      padding: const EdgeInsets.only(left: 5.0),
      width: 88.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          moneyItem(),
          conditionItem(),
        ],
      ),
    );
  }

  /// 虚线
  Widget lineItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 6,
          width: 12,
          color: Colors.transparent,
          child: Container(
          decoration: const BoxDecoration(
            color: SCColors.color_F2F3F5,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0)),
            ),
          ),
        ),
        Expanded(child: Image.asset(
          SCAsset.iconCouponLine,
          width: 1,
          height: 58.0,
          fit: BoxFit.fill,
        )),
        Container(
          height: 6,
          width: 12,
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: SCColors.color_F2F3F5,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  topRight: Radius.circular(6.0)),
            ),
          ),
        ),
      ],
    );
  }

  /// middleItem
  Widget middleItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nameItem(),
        const SizedBox(height: 6.0,),
        validityItem(),
      ],
    );
  }

  /// 金额
  Widget moneyItem() {
    return RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '¥',
            style: TextStyle(
                fontSize: SCFonts.f16,
                color: (status == 1 || status == 2) ? SCColors.color_8D8E99 : SCColors.color_FF571A,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                  text: money,
                  style: TextStyle(
                      fontSize: SCFonts.f28,
                      color: (status == 1 || status == 2) ? SCColors.color_8D8E99 : SCColors.color_FF571A,
                      fontWeight: FontWeight.w700))
            ]));
  }

  /// condition
  Widget conditionItem() {
    return SizedBox(
      height: 18,
      child: Text(condition ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99)),
    );
  }

  /// 名称
  Widget nameItem() {
    return SizedBox(
      height: 24.0,
      child: Text(name ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: (status == 1 || status == 2) ? SCColors.color_8D8E99 : SCColors.color_1B1D33)),
    );
  }

  /// 有效期
  Widget validityItem() {
    return Text(validity ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99));
  }

  Widget rightItem() {
    if (status == 0) {
      /// 显示规则
      return GestureDetector(
        onTap: () {
          ruleAction?.call();
        },
        child: Container(
          width: 61.0,
          height: 70,
          padding: const EdgeInsets.only(top: 11.0),
          alignment: Alignment.topRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('规则',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: SCFonts.f12,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_5E5F66)),
              const SizedBox(width: 2.0,),
              Image.asset(
                SCAsset.iconCouponRule,
                width: 12.0,
                height: 12.0,
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      );
    } else if (status == 1) {
      /// 显示已使用
      return Container(
        width: 61.0,
        height: 70.0,
        alignment: Alignment.bottomRight,
        child: Image.asset(
          SCAsset.iconCouponUsed,
          width: 52.0,
          height: 49.0,
          fit: BoxFit.fill,
        ),
      );
    } else if (status == 2) {
      /// 显示已失效
      return Container(
        width: 61.0,
        height: 70.0,
        alignment: Alignment.bottomRight,
        child: Image.asset(
          SCAsset.iconCouponExpired,
          width: 52.0,
          height: 49.0,
          fit: BoxFit.fill,
        ),
      );
    } else if (status == 3) {
      /// 显示获取按钮
      return SizedBox(
        width: 50.0,
        height: 22.0,
        child: CupertinoButton(
            minSize: 22.0,
            padding: EdgeInsets.zero,
            color: const Color(0xFF6DAC77),
            borderRadius: BorderRadius.circular(11.0),
            child: const Text(
              '领取',
              style: TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_FFFFFF,
              ),
            ),
            onPressed: () {
              getAction?.call();
            }),
      );
    } else if (status == 4) {
      /// 显示已领取
      return Container(
        width: 61.0,
        height: 70.0,
        alignment: Alignment.bottomRight,
        child: Image.asset(
          SCAsset.iconCouponGot,
          width: 52.0,
          height: 49.0,
          fit: BoxFit.fill,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

}
