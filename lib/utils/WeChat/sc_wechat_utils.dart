import 'dart:io';
import 'dart:typed_data';

import 'package:fluwx/fluwx.dart';

import '../../constants/sc_default_value.dart';

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
      WXMiniProgramType miniProgramType = WXMiniProgramType.RELEASE}) {
    return launchWeChatMiniProgram(
        username: username, path: path, miniProgramType: miniProgramType);
  }

  /// 分享图片到会话
  static void shareBinaryImage(Uint8List source) {
    shareToWeChat(WeChatShareImageModel(WeChatImage.binary(source),
        scene: WeChatScene.SESSION));
  }

  /// 分享图片到会话
  static void shareAssetImage(String source) {
    shareToWeChat(WeChatShareImageModel(WeChatImage.asset(source),
        scene: WeChatScene.SESSION));
  }

  /// 分享图片到会话
  static void shareFileImage(File source) {
    shareToWeChat(WeChatShareImageModel(WeChatImage.file(source),
        scene: WeChatScene.SESSION));
  }

  /// 分享图片到会话
  static void shareNetWorkImage(String source) {
    shareToWeChat(WeChatShareImageModel(WeChatImage.network(source),
        scene: WeChatScene.SESSION));
  }

  /// 分享文字到会话
  static void shareText(String source) {
    shareToWeChat(WeChatShareTextModel(source, scene: WeChatScene.SESSION));
  }

  /// 分享web网页
  static Future shareWeb(
      {required String url,
      String? title,
      String? content,
      WeChatImage? image}) {
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
}
