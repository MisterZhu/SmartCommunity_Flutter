import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_default_value.dart';
import 'package:smartcommunity/constants/sc_h5.dart';
import 'package:smartcommunity/constants/sc_skin_value.dart';
import 'package:smartcommunity/constants/sc_type_define.dart';
import 'package:smartcommunity/page/Mine/Model/sc_property_model.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_changeaddress_item.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_header.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_property_item.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_score_item.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_service_item.dart';
import 'package:smartcommunity/page/Mine/View/sc_mine_wallet_item.dart';
import 'package:smartcommunity/skin/Model/sc_user.dart';
import 'package:smartcommunity/skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/utils/Loading/sc_loading_utils.dart';
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
      headerTap: () {
        workOrder();
      },
      membershipTap: () {
        workOrder();
      },
    );
  }

  /// 切换房号-cell
  Widget changeAddressCell(BuildContext context) {
    return SCMineChangeAddressItem(
      onTap: () {
        SCRouterHelper.codePage(5001, null);
      },
    );
  }

  /// 积分、红包-cell
  Widget scoreCell() {
    return SCMineScoreItem(
      onTap: (int index) {
        workOrder();
      },
    );
  }

  /// 我的钱包-cell
  Widget walletCell() {
    return SCMineWalletItem(
      onTap: () {
        workOrder();
      },
    );
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
    return SCMineServiceItem(
      onTap: (int index) {
        workOrder();
      },
    );
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

  /// 测试数据-工单
  workOrder() {
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    String token = SCScaffoldManager.instance.user.token ?? "";
    String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
    String url = SCH5.workOrderUrl + "?" + "defCommunityId=" + defCommunityId + "&Authorization=" + token + "&defRoomId=" + defRoomId + "&client=" + SCDefaultValue.client;
    SCRouterHelper.codePage(20000, {"title" : "工单", "url" : url});
  }
}
