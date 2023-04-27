import 'package:smartcommunity/Utils/AliPay/sc_alipay_utils.dart';
import 'package:smartcommunity/Utils/WeChat/sc_wechat_utils.dart';

/// 支付工具类

class SCPayUtils {
  /// 调用支付宝支付
  alipay({required String data, Function(dynamic data)? result}) {
    SCAliPayUtils.aliPay(data: data, result: (value) {
      result?.call(value);
    });
  }

  /// 调用微信支付
  wechatPay({required dynamic params, Function(dynamic data)? result}) {
    String partnerId = params['partnerid'];
    String prepayId = params['prepayid'];
    String packageValue = params['package'];
    String nonceStr = params['noncestr'];
    String sign = params['sign'];
    String appId = params['appId'];
    int timestamp = int.parse(params['timestamp']);
    SCWeChatUtils.wechatPay(
        partnerId: partnerId,
        prepayId: prepayId,
        packageValue: packageValue,
        nonceStr: nonceStr,
        sign: sign,
        timestamp: timestamp,
        appId: appId,
        result: (value) {
          result?.call(value);
        });
  }
}
