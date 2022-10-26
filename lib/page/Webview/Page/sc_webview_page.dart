import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_key.dart';
import 'package:smartcommunity/skin/View/sc_custom_scaffold.dart';
import 'package:smartcommunity/utils/sc_sp_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/sc_asset.dart';
import '../../../utils/Router/sc_router_helper.dart';
import '../../../utils/sc_string_utils.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_webview_page
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/8 14:40
/// Description: WebView加载
class SCWebViewPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const SCWebViewPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<SCWebViewPage> createState() => _SCWebViewPageState();
}

class _SCWebViewPageState extends State<SCWebViewPage> {
  WebViewController? webViewController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  /// webView title
  String _title = "";

  /// webView url
  String _url = "";

  /// 如果是富文本 则传递richText
  String _richText = "";

  bool _isLocalUrl = false;

  @override
  void initState() {
    super.initState();
    dynamic params = Get.arguments;
    log('webView接收的参数：$params');
    _title =
        StringUtils.isNotNullOrEmpty(params?["title"]) ? params!["title"] : "";
    _url = StringUtils.isNotNullOrEmpty(params?["url"]) ? params!["url"] : "";

    _richText = StringUtils.isNotNullOrEmpty(params?["richText"])
        ? params!["richText"]
        : "";
    _isLocalUrl = params?["isLocalUrl"] ?? false;
  }

  @override
  void dispose() {
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
      leading: _leading(),
      leadingWidth: 100,
      body: _body(),
      centerTitle: true,
      showBackIcon: true,
      showBackgroundImage: false,
      title: _title,
    );
  }

  /// leading
  Widget _leading() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          SizedBox(
              width: 24,
              height: 24,
              child: GestureDetector(
                child: Image.asset(
                  SCAsset.iconNavigationBack,
                  width: 24.0,
                  height: 24.0,
                ),
                onTap: () {
                  goBack();
                },
              )),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
              width: 24,
              height: 24,
              child: GestureDetector(
                child: Image.asset(
                  SCAsset.iconNavigationClose,
                  width: 24.0,
                  height: 24.0,
                ),
                onTap: () {
                  SCRouterHelper.back(null);
                },
              )),
        ],
      ),
    );
  }

  /// body
  Widget _body() {
    return ((StringUtils.isNullOrEmpty(_url) && !_isLocalUrl) ||
            (_isLocalUrl &&
                (StringUtils.isNullOrEmpty(_richText) &&
                    StringUtils.isNullOrEmpty(_url))))
        ? Container(
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text("当前路径为空"),
            ),
          )
        : _isLocalUrl && StringUtils.isNotNullOrEmpty(_richText)
            ? RichText(
                text: TextSpan(text: _richText),
              )
            : WebView(
                initialUrl: _isLocalUrl ? "" : _url,

                /// 是否开启JS
                javascriptMode: JavascriptMode.unrestricted,

                /// 跟H5交互的方法到此处处理
                javascriptChannels: {_jxTokenChannel(context)},

                ///WebView创建
                onWebViewCreated: _onWebViewCreated,

                ///页面开始加载
                onPageStarted: _onPageStarted,

                ///页面加载结束
                onPageFinished: _onPageFinished,

                onProgress: _onProgress,

                ///如果出现错误
                onWebResourceError: (WebResourceError error) =>
                    debugPrint('error:${error.description}'),
              );
  }

  /// webView创建
  void _onWebViewCreated(WebViewController controller) async {
    webViewController = controller;
    if (_isLocalUrl) {
      await _loadHtmlFromAssets();
    }
    _controller.complete(controller);
    webViewController!.clearCache();
  }

  /// webView开始加载
  void _onPageStarted(String url) {
    // EasyLoading.show();
  }

  /// webView加载结束
  void _onPageFinished(String url) async {
    // EasyLoading.dismiss();
  }

  void _onProgress(int progress) {
    print('---> progress $progress');
  }

  _loadHtmlFromAssets() async {
    // String fileHtmlContents = await rootBundle.loadString(_url);
    // webViewController?.loadUrl(Uri.dataFromString(fileHtmlContents,
    //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
    //     .toString());
  }

  // 后退
  goBack() async {
    if (webViewController == null) {
      SCRouterHelper.back(null);
      return;
    }
    bool goBack = await webViewController!.canGoBack();
    if (goBack) {
      webViewController!.goBack();
    } else {
      SCRouterHelper.back(null);
    }
  }

  /// 建信租房token
  JavascriptChannel _jxTokenChannel(BuildContext context) => JavascriptChannel(
      name: '_app_callback_token',
      onMessageReceived: (JavascriptMessage message) {
        String token = jsonDecode(message.message);
        cacheJXToken(token);
      });

  /// 缓存建信租房token
  cacheJXToken(String token) {
    SCSpUtil.setString(SCKey.kJianXinRentingToken, token);
  }
}
