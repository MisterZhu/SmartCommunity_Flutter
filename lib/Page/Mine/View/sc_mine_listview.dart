import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_h5.dart';
import 'package:smartcommunity/Constants/sc_skin_value.dart';
import 'package:smartcommunity/Constants/sc_type_define.dart';
import 'package:smartcommunity/Page/Mine/Model/sc_property_model.dart';
import 'package:smartcommunity/Page/Mine/View/sc_mine_changeaddress_item.dart';
import 'package:smartcommunity/Page/Mine/View/sc_mine_header.dart';
import 'package:smartcommunity/Page/Mine/View/sc_mine_property_item.dart';
import 'package:smartcommunity/Page/Mine/View/sc_mine_score_item.dart';
import 'package:smartcommunity/Page/Mine/View/sc_mine_service_item.dart';
import 'package:smartcommunity/Page/Mine/View/sc_mine_wallet_item.dart';
import 'package:smartcommunity/Skin/Model/sc_user.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../Network/sc_config.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../../Utils/Toast/sc_toast.dart';

/// 我的-listview

class SCMineListView extends StatelessWidget {
  SCMineListView(
      {Key? key,
      this.scrollFunction,
      required this.dataList,
      this.propertCurrentIndex = 0,
      this.user
      })
      : super(key: key);

  /// listView数据源
  final List dataList;

  /// 我的资产选中index
  final int propertCurrentIndex;

  /// 滑动回调
  Function(double offset)? scrollFunction;

  final SCUser? user;

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
      userName: user?.userName,
      userPic: user?.getHeadPicUrl(),
      settingTap: () {
          SCRouterHelper.pathPage(SCRouterPath.settingPath, null);
      },
      headerTap: () {
          SCRouterHelper.pathPage(SCRouterPath.personalInfoPath, null);
      },
      membershipTap: () {
        workOrder();
      },
    );
  }

  /// 原生调flutter
  nativeToFlutter() {
    MethodChannel channel1 = const MethodChannel('channel1');
    // 接收 ios _channel_1 的调用, 并返回给 ios 一个数据回调
    channel1.setMethodCallHandler((call) {
       // 此处一个 channel 可以调用很多 method,
        if (call.method == 'one') {
          print(call.arguments);
          SCToast.showTip(call.arguments);

        }
        return Future.value('_channel_1: flutter 响应 ios 后, 回调给 ios 的数据 111');
    });

  }

  /// flutter调用原生
  testFlutterToNative() async {
    var futureValue = await runNativeMethod();
    SCToast.showTipWithGravity(msg: futureValue, gravity: ToastGravity.BOTTOM);
  }

  // 调用原生方法
  Future runNativeMethod() async {
    const platform = MethodChannel('flutter_to_native');
    try {
      // 发送消息
      var result = await platform.invokeMethod('test2');
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  /// 切换房号-cell
  Widget changeAddressCell(BuildContext context) {
    String houseName = '';
    String userName = user?.userName ?? '';
    if (userName.isNotEmpty) {
      houseName = "$userName的家庭";
    }
    return SCMineChangeAddressItem(
      houseName: houseName,
      address: user?.spaceName,
      onTap: () {
        SCRouterHelper.pathPage(SCRouterPath.toggleHousesPagePath, null);
      },
    );
  }

  /// 积分、红包-cell
  Widget scoreCell() {
    return SCMineScoreItem(
      onTap: (int index) {
        if (index == 0) {// 积分
          integral();
        } else {// 红包
          redPacket();
        }
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
    String url = "${SCConfig.getH5Url(SCH5.workOrderUrl)}?defCommunityId=$defCommunityId&Authorization=$token&defRoomId=$defRoomId&client=${SCDefaultValue.client}";
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"title" : "工单", "url" : url});
  }

  /// 积分
  integral() {
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    String token = SCScaffoldManager.instance.user.token ?? "";
    String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
    String url = SCConfig.getH5Url(SCH5.integralUrl) + "?" + "defCommunityId=" + defCommunityId + "&Authorization=" + token + "&defRoomId=" + defRoomId + "&client=" + SCDefaultValue.client;
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"title" : "积分", "url" : url});
  }

  /// 红包
  redPacket() {
    String defCommunityId = SCScaffoldManager.instance.user.communityId ?? "";
    String token = SCScaffoldManager.instance.user.token ?? "";
    String defRoomId = SCScaffoldManager.instance.user.spaceId.toString();
    String url = SCConfig.getH5Url(SCH5.workOrderUrl) + "?" + "defCommunityId=" + defCommunityId + "&Authorization=" + token + "&defRoomId=" + defRoomId + "&client=" + SCDefaultValue.client;
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {"title" : "工单", "url" : url});
  }
}
