import 'package:smartcommunity/Utils/AliPay/sc_alipay_utils.dart';
import 'package:smartcommunity/Utils/WeChat/sc_wechat_utils.dart';

/// 支付工具类

class SCPayUtils {
  /// 调用支付宝支付
  alipay({Function(dynamic data)? result}) {
    SCAliPayUtils.aliPay(result: (value) {
      result?.call(value);
    });
  }

  /// 调用微信支付
  wechatPay({Function(dynamic data)? result}) {
    SCWeChatUtils.wechatPay(
        partnerId: '',
        prepayId: '',
        packageValue: '',
        nonceStr: '',
        sign: '',
        result: (value) {
          result?.call(value);
        });
  }
}
