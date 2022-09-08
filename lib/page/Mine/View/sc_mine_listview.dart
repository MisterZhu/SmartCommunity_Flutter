import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_skin_value.dart';
import 'package:smartcommunity/constants/sc_type_define.dart';
import 'package:smartcommunity/page/Mine/Model/sc_property_model.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_changeaddress_item.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_header.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_property_item.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_score_item.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_service_item.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_wallet_item.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';

/// 我的-listview

class SCMineListView extends StatelessWidget {
  SCMineListView(
      {Key? key,
      this.scrollFunction,
      required this.dataList,
      this.propertCurrentIndex = 0})
      : super(key: key);

  /// listView数据源
  final List dataList;

  /// 我的资产选中index
  final int propertCurrentIndex;

  /// 滑动回调
  Function(double offset)? scrollFunction;

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    scrollNotify();
    return ListView.separated(
        controller: scrollController,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(type: dataList[index], context: context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return lineWidget();
        },
        itemCount: dataList.length);
  }

  /// 获取cell
  Widget getCell({required int type, required BuildContext context}) {
    if (type == SCTypeDefine.SC_MINE_TYPE_HEADER) {
      // header
      return headerCell();
    } else if (type == SCTypeDefine.SC_MINE_TYPE_CHANGERHOUSE) {
      // 切换房号
      return changeAddressCell(context);
    } else if (type == SCTypeDefine.SC_MINE_TYPE_SCORE) {
      // 积分
      return scoreCell();
    } else if (type == SCTypeDefine.SC_MINE_TYPE_WALLET) {
      // 钱包
      return walletCell();
    } else if (type == SCTypeDefine.SC_MINE_TYPE_PROPERTY) {
      // 资产
      return propertyCell();
    } else if (type == SCTypeDefine.SC_MINE_TYPE_SERVICE) {
      // 服务
      return serviceCell();
    } else {
      // 测试
      return testCell();
    }
  }

  /// header-cell
  Widget headerCell() {
    return SCMineHeaderItem(
      settingTap: (){
        SCRouterHelper.codePage(5003, null);
      },
    );
  }

  /// 切换房号-cell
  Widget changeAddressCell(BuildContext context) {
    return SCMineChangeAddressItem(
      onTap: () {},
    );
  }

  /// 积分、红包-cell
  Widget scoreCell() {
    return SCMineScoreItem();
  }

  /// 我的钱包-cell
  Widget walletCell() {
    return SCMineWalletItem();
  }

  /// 我的资产-cell
  Widget propertyCell() {
    SCPropertyModel model = SCPropertyModel.fromJson(dataMap);
    return SCMinePropertyItem(
      currentIndex: propertCurrentIndex,
      model: model,
    );
  }

  /// 我的服务-cell
  Widget serviceCell() {
    return SCMineServiceItem();
  }

  /// 测试-cell
  Widget testCell() {
    return const SizedBox(
      height: 20.0,
    );
  }

  /// 分割线
  Widget lineWidget() {
    return const SizedBox(
      height: 8.0,
    );
  }

  /// 监听滑动
  void scrollNotify() {
    scrollController.addListener(() {
      scrollFunction?.call(scrollController.offset);
    });
  }
}
