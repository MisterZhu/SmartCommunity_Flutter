/// 网络请求
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class SCHttpManager {
  factory SCHttpManager() => _getInstance();

  static SCHttpManager get instance => _getInstance();
  static SCHttpManager? _instance;
  Dio? _dio;

  ///通用全局单例，第一次使用时初始化
  SCHttpManager._internal() {
    if (null == _dio) {
      _dio = Dio();
      //
      (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        //抓Https包设置  信任所有https证书
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
      _dio?.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true)); // 日志打印
      // print("options.headers-->" + options.headers.toString());

    }
  }

  Dio? get dio => _dio;

  ///获取实例 并可以重新指定baseurl
  static SCHttpManager _getInstance() {
    _instance ??= SCHttpManager._internal();
    return _instance!;
  }

  ///通用的GET请求
  get(api, {params}) async {
    try {
      Response response = await _dio!.get(api, queryParameters: params);
      return _doResponse(response);
    } catch (e) {
      return _doDioError(e);
    } finally {
    }
  }

  ///通用的POST请求
  post(api, {params}) async {
    try {
      Response response = await _dio!.post(api, data: params);
      return _doResponse(response);
    } catch (e) {
      return _doDioError(e);
    } finally {
    }
  }

  put(api, {params}) async {
    try {
      Response response = await _dio!.put(api, queryParameters: params);
      return _doResponse(response);
    } catch (e) {
      return _doDioError(e);
    } finally {
    }
  }
}

/// 处理 dio 请求成功后  网络数据解包
_doResponse(Response response) {
  if (response.statusCode == 200) {
    // 请求成功
    var code = response.data["code"];
    var msg = response.data["msg"];
    var status = response.data["status"];
    if (status == 100) {
      var data = response.data["data"];
      return data;
    } else if (status == 102) {

    } else {

    }
  }
}

/// 处理 dio 请求异常
_doDioError(e) {
  print('网络失败：${e}');
}
