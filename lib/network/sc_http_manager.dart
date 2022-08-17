/// 网络请求
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:smartcommunity/constants/sc_default_value.dart';
import 'package:smartcommunity/network/sc_config.dart';

class SCHttpManager {
  factory SCHttpManager() => _getInstance();

  static SCHttpManager get instance => _getInstance();

  static SCHttpManager? _instance;

  Dio? _dio;

  BaseOptions? _baseOptions;

  Map<String, dynamic>? _headers;

  Dio? get dio => _dio;

  BaseOptions? get baseOptions => _baseOptions;

  Map<String, dynamic>? get headers => _headers;

  ///通用全局单例，第一次使用时初始化
  SCHttpManager._internal() {
    if (null == _dio) {
      _headers = {'Content-Type': 'application/json; charset=utf-8'};
      _baseOptions = BaseOptions(
        baseUrl: SCConfig.BASE_URL,
        connectTimeout: SCDefaultValue.timeOut,
        receiveTimeout: SCDefaultValue.timeOut,
        sendTimeout: SCDefaultValue.timeOut,
        headers: _headers,
      );

      _dio = Dio();
      _dio!.options = _baseOptions!;
      //
      (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        //抓Https包设置  信任所有https证书
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return null;
      };
      _dio?.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true)); // 日志打印
      // print("options.headers-->" + options.headers.toString());

    }
  }

  /// 更新headers
  static updateHeaders({required Map<String, dynamic> headers}) {
    SCHttpManager.instance._headers = headers;
    SCHttpManager.instance._baseOptions?.headers = headers;
  }

  /// 获取实例
  static SCHttpManager _getInstance() {
    _instance ??= SCHttpManager._internal();
    return _instance!;
  }

  /// 通用的GET请求
  get({required String url,dynamic params, Map<String, dynamic>? headers, Function(dynamic value)? success, Function(dynamic value)? failure}) async {
    Options options = Options(
      headers: headers
    );

    try {
      Response response = await _dio!.get(url, queryParameters: params, options: headers == null ? null : options);
      var data = doResponse(response);
      bool result = data['success'];

      if (result) {
        success?.call(data['data']);
      } else {
        failure?.call(data['data']);
      }

      return data;
    } catch (e) {
      return doError(e);
    } finally {

    }
  }

  /// 通用的POST请求
  post({required String url,dynamic params, Map<String, dynamic>? headers, Function(dynamic value)? success, Function(dynamic value)? failure}) async {
    Options options = Options(
        headers: headers
    );

    try {
      Response response = await _dio!.post(url, queryParameters: params, options: headers == null ? null : options);
      var data = doResponse(response);
      bool result = data['success'];

      if (result) {
        success?.call(data['data']);
      } else {
        failure?.call(data['data']);
      }

      return data;
    } catch (e) {
      return doError(e);
    } finally {

    }
  }

  /// 通用的PUT请求
  put({required String url,dynamic params, Map<String, dynamic>? headers, Function(dynamic value)? success, Function(dynamic value)? failure}) async {
    Options options = Options(
        headers: headers
    );

    try {
      Response response = await _dio!.put(url, queryParameters: params, options: headers == null ? null : options);
      var data = doResponse(response);
      bool result = data['success'];

      if (result) {
        success?.call(data['data']);
      } else {
        failure?.call(data['data']);
      }

      return data;
    } catch (e) {
      return doError(e);
    } finally {

    }
  }

  /// 通用的DELETE请求
  delete({required String url,dynamic params, Map<String, dynamic>? headers, Function(dynamic value)? success, Function(dynamic value)? failure}) async {
    Options options = Options(
        headers: headers
    );

    try {
      Response response = await _dio!.delete(url, queryParameters: params, options: headers == null ? null : options);
      var data = doResponse(response);
      bool result = data['success'];

      if (result) {
        success?.call(data['data']);
      } else {
        failure?.call(data['data']);
      }

      return data;
    } catch (e) {
      return doError(e);
    } finally {

    }
  }
}

/// 处理dio请求成功后,网络数据解包
doResponse(Response response) {
  if (response.statusCode == 200) {
    // 请求成功
    // var code = response.data["code"];
    // var msg = response.data["msg"];
    var status = response.data["status"];

    var data = {'success' : true, 'data' : response.data};

    if (status == 100) {
      return data;
    } else if (status == 401) {
      return data;
    } else if (status == 403) {
      return data;
    } else if (status == 404) {
      return data;
    } else if (status == 500) {
      return data;
    } else {
      return data;
    }
  } else {
    var data = {'success' : false, 'data' : response.data};
    return data;
  }
}

/// 处理dio请求异常
doError(e) {
  return e;
}
