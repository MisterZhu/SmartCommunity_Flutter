import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:fluwx/fluwx.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../Constants/sc_default_value.dart';

/// 微信

class SCWeChatUtils {
  /// 初始化sdk
  static void init() async {
    await registerWxApi(
        appId: SCDefaultValue.kWeChatAppId,
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: SCDefaultValue.kWeChatUniversalLink);
  }

  /// 调起小程序方法
  static Future<bool> jumpMiniProgram(
      {required String username,
      String? path,
      WXMiniProgramType miniProgramType = WXMiniProgramType.RELEASE}) async {
    bool installWechat = await installed();
    if (!installWechat) {
      SCToast.showTip(SCDefaultValue.unInstallWeChatTip);
      return Future.value(false);
    }
    return launchWeChatMiniProgram(
        username: username, path: path, miniProgramType: miniProgramType);
  }

  /// 分享图片到会话
  static void shareBinaryImage(Uint8List source) async {
    bool installWechat = await installed();
    if (!installWechat) {
      SCToast.showTip(SCDefaultValue.unInstallWeChatTip);
      return;
    }
    shareToWeChat(WeChatShareImageModel(WeChatImage.binary(source),
        scene: WeChatScene.SESSION));
  }

  /// 分享图片到会话
  static void shareAssetImage(String source) async {
    bool installWechat = await installed();
    if (!installWechat) {
      SCToast.showTip(SCDefaultValue.unInstallWeChatTip);
      return;
    }
    shareToWeChat(WeChatShareImageModel(WeChatImage.asset(source),
        scene: WeChatScene.SESSION));
  }

  /// 分享图片到会话
  static void shareFileImage(File source) async {
    bool installWechat = await installed();
    if (!installWechat) {
      SCToast.showTip(SCDefaultValue.unInstallWeChatTip);
      return;
    }
    shareToWeChat(WeChatShareImageModel(WeChatImage.file(source),
        scene: WeChatScene.SESSION));
  }

  /// 分享图片到会话
  static void shareNetWorkImage(String source) async {
    bool installWechat = await installed();
    if (!installWechat) {
      SCToast.showTip(SCDefaultValue.unInstallWeChatTip);
      return;
    }
    shareToWeChat(WeChatShareImageModel(WeChatImage.network(source),
        scene: WeChatScene.SESSION));
  }

  /// 分享文字到会话
  static void shareText(String source) async {
    bool installWechat = await installed();
    if (!installWechat) {
      SCToast.showTip(SCDefaultValue.unInstallWeChatTip);
      return;
    }
    shareToWeChat(WeChatShareTextModel(source, scene: WeChatScene.SESSION));
  }

  /// 分享web网页
  static Future shareWeb(
      {required String url,
      String? title,
      String? content,
      WeChatImage? image}) async {
    bool installWechat = await installed();
    if (!installWechat) {
      SCToast.showTip(SCDefaultValue.unInstallWeChatTip);
      return Future.value(false);
    }
    return shareToWeChat(
      WeChatShareWebPageModel(
        url,
        scene: WeChatScene.SESSION,
        title: title ?? '',
        description: content,
        thumbnail: image,
      ),
    );
  }

  /// 是否安装微信
  static Future<bool> installed() async {
    return await isWeChatInstalled;
  }

  /// 微信支付
  static wechatPay({
    required String partnerId, // 商户Id
    required String prepayId, // 预付订单Id
    required String packageValue, // 微信要求的标识字符串
    required String nonceStr, // 随机字符串
    required String sign, // 计算好的签名
    required int timestamp,// 时间戳
    required String appId,// appId
    Function(dynamic data)? result, // 支付结果
  }) async {
    /// 支付状态：0-未知错误,1-成功,2-失败
    int payStatus = 0;
    /// message
    String msg = "";
    bool installWechat = await installed();
    if (!installWechat) {
      SCToast.showTip(SCDefaultValue.unInstallWeChatTip);
      payStatus = 2;
      msg = SCDefaultValue.unInstallWeChatTip;
      result?.call({
        "data": {"result": payStatus, "msg": msg}
      });
      return;
    }
    payWithWeChat(
        appId: appId,
        partnerId: partnerId,
        prepayId: prepayId,
        packageValue: packageValue,
        nonceStr: nonceStr,
        timeStamp: timestamp,
        sign: sign);

    StreamSubscription? wxPay;
    wxPay?.cancel();
    wxPay = weChatResponseEventHandler.listen((event) async {
      wxPay?.cancel();
      if (event.errCode == 0) {
        payStatus = 1;
        msg = SCDefaultValue.paySuccessTip;
      } else {
        payStatus = 2;
        if (event.errStr == null || event.errStr == '' || event.errStr == ' ') {
          msg = SCDefaultValue.payFailureTip;
        } else {
          msg = event.errStr!;
        }
      }
      result?.call({
        "data": {"result": payStatus, "msg": msg}
      });
    });
  }
}
