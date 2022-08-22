/// 网络请求
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:smartcommunity/constants/sc_default_value.dart';
import 'package:smartcommunity/network/sc_config.dart';

import '../utils/Loading/sc_loading_utils.dart';

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
      _headers = {'Content-Type': 'application/json; charset=utf-8', 'client' : SCDefaultValue.client};
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
      success?.call(data);
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
      Response response = await _dio!.post(url, queryParameters: params, data: params, options: headers == null ? null : options);
      var data = doResponse(response);
      success?.call(data);
      return data;
    } catch (e) {
      failure?.call(doError(e));
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
      Response response = await _dio!.put(url, queryParameters: params, data: params, options: headers == null ? null : options);
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
      Response response = await _dio!.delete(url, queryParameters: params, data: params, options: headers == null ? null : options);
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
    SCLoadingUtils.hide();
    return response.data;
  } else {
    log('失败：${response.data}');
    return response.data;
  }
}

/// 处理dio请求异常
doError(e) {
  DioError error = e;
  switch(error.response?.statusCode) {
    case 400:
      {

      }
      break;
    case 401:
      {

      }
      break;
    case 403:
      {

      }
      break;
    case 404:
      {

      }
      break;
  }
  log('网络失败1:${error.response}');
  log('网络失败2:${error.response?.statusCode}');
  log('123111:${e.toString()}');
  SCLoadingUtils.hide();
  return e;
}
