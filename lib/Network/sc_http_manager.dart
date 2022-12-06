/// 网络请求
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Skin/Model/sc_user.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';

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
      _headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'client': SCDefaultValue.client
      };
      if (SCScaffoldManager.instance.isLogin == true) {
        SCUser user = SCScaffoldManager.instance.getUserData();
        _headers!['Authorization'] = user.token;
      }

      // log('通用全局单例====headers=====$_headers');
      _baseOptions = BaseOptions(
        baseUrl: SCConfig.BASE_URL,
        connectTimeout: SCDefaultValue.timeOut,
        receiveTimeout: SCDefaultValue.timeOut,
        sendTimeout: SCDefaultValue.timeOut,
        headers: _headers,
      );

      _dio = Dio();
      _dio!.options = _baseOptions!;
      (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        //抓Https包设置  信任所有https证书
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return null;
      };
      // _dio?.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true)); // 日志打印
      // print("options.headers-->" + options.headers.toString());

    }
  }

  /// 更新headers
  updateHeaders({required Map<String, dynamic> headers}) {
    SCHttpManager.instance._headers = headers;
    SCHttpManager.instance._baseOptions?.headers = headers;
    SCHttpManager.instance._dio!.options = SCHttpManager.instance._baseOptions!;
  }

  /// 获取实例
  static SCHttpManager _getInstance() {
    _instance ??= SCHttpManager._internal();
    return _instance!;
  }

  /// 通用的GET请求
  get(
      {required String url,
      dynamic params,
      Map<String, dynamic>? headers,
      Function(dynamic value)? success,
      Function(dynamic value)? failure}) async {
    Options options = Options(headers: headers);
    late Response response;
    late Object exception;
    bool status = false;

    try {
      response = await _dio!.get(url,
          queryParameters: params, options: headers == null ? null : options);
      status = true;
    } catch (e) {
      status = false;
      exception = e;
    } finally {
      if (status) {
        var data = doResponse(response);
        success?.call(data);
      } else {
        var data = doError(exception);
        var code = data['code'];
        if (code != 401) {
          failure?.call(data);
        }
      }
    }
  }

  /// 通用的POST请求
  Future post(
      {required String url,
      dynamic params,
      Map<String, dynamic>? headers,
      Function(dynamic value)? success,
      Function(dynamic value)? failure}) async {
    Options options = Options(headers: headers);
    late Response response;
    late Object exception;
    bool status = false;

    try {
      response = await _dio!.post(url,
          queryParameters: params is Map<String, dynamic> ? params : {},
          data: params,
          options: headers == null ? null : options);
      status = true;
    } catch (e) {
      status = false;
      exception = e;
    } finally {
      if (status) {
        var data = doResponse(response);
        checkLogin(url: url, headers: response.headers.map, data: data);
        success?.call(data);
      } else {
        var data = doError(exception);
        var code = data['code'];
        if (code != 401) {
          failure?.call(data);
        }
      }
    }
    return Future(() => status);
  }

  /// 通用的PUT请求
  put(
      {required String url,
      dynamic params,
      Map<String, dynamic>? headers,
      Function(dynamic value)? success,
      Function(dynamic value)? failure}) async {
    Options options = Options(headers: headers);
    late Response response;
    late Object exception;
    bool status = false;

    try {
      response = await _dio!.put(url,
          queryParameters: params,
          data: params,
          options: headers == null ? null : options);
      status = true;
    } catch (e) {
      status = false;
      exception = e;
    } finally {
      if (status) {
        var data = doResponse(response);
        success?.call(data);
      } else {
        var data = doError(exception);
        var code = data['code'];
        if (code != 401) {
          failure?.call(data);
        }
      }
    }
  }

  /// 通用的DELETE请求
  delete(
      {required String url,
      dynamic params,
      Map<String, dynamic>? headers,
      Function(dynamic value)? success,
      Function(dynamic value)? failure}) async {
    Options options = Options(headers: headers);
    late Response response;
    late Object exception;
    bool status = false;

    try {
      response = await _dio!.delete(url,
          queryParameters: params,
          data: params,
          options: headers == null ? null : options);
      status = true;
    } catch (e) {
      status = false;
      exception = e;
    } finally {
      if (status) {
        var data = doResponse(response);
        success?.call(data);
      } else {
        var data = doError(exception);
        var code = data['code'];
        if (code != 401) {
          failure?.call(data);
        }
      }
    }
  }

  /// 校验登录
  checkLogin({required String url, dynamic headers, dynamic data}) {
    if (url == SCUrl.kPhoneCodeLoginUrl) {
      String token = '';

      var list = headers['authorization'];
      if (list != null) {
        int count = list.length;
        if (count > 0) {
          token = list[0];
          _headers!['Authorization'] = token;
          SCHttpManager.instance._baseOptions?.headers = _headers;
        }
      }

      var userData = data['userInfoV'];
      userData['token'] = token;
      if (token != '') {
        SCScaffoldManager.instance.cacheUserIsLogin(true);
      }
      SCScaffoldManager.instance.cacheUserData(userData);
    }
  }
}

/// 处理dio请求成功后,网络数据解包
doResponse(Response response) {
  if (response.statusCode == 200) {
    SCLoadingUtils.hide();
    return response.data;
  } else {
    SCLoadingUtils.hide();
    log('失败：${response.data}');
    return response.data;
  }
}

/// 处理dio请求异常
doError(e) {
  print('报错数据:$e');
  SCLoadingUtils.hide();

  /// 错误码
  int code = 0;

  /// message
  String message = SCDefaultValue.errorMessage;

  if (e is DioError) {
    DioError error = e;

    if (e.error is SocketException) {
      code = 500;
      message = SCDefaultValue.netErrorMessage;
    } else {
      code = error.response?.statusCode ?? 500;
      switch (error.response?.statusCode) {
        case 201:
          {}
          break;

        case 400:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['msg'] ?? SCDefaultValue.errorMessage;
            } else {
              message = error.response?.data.toString() ??
                  SCDefaultValue.errorMessage;
            }
          }
          break;

        case 401:
          {
            /// 登录失效
            accountExpired();
          }
          break;

        case 403:
          {}
          break;

        case 404:
          {}
          break;

        case 500:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['msg'] ?? SCDefaultValue.errorMessage;
            } else {
              message = error.response?.data.toString() ??
                  SCDefaultValue.errorMessage;
            }
          }
          break;
      }
    }
  } else {
    code = 500;
    message = SCDefaultValue.errorMessage;
  }

  var params = {
    'code': code,
    'message': message,
  };
  return params;
}

/// token失效
accountExpired() {
  log('登陆已失效，清空用户数据，刷新本地缓存用户数据');
  SCLoadingUtils.failure(text: SCDefaultValue.accountExpiredMessage);
  SCScaffoldManager.instance.cacheUserIsLogin(false);
  SCScaffoldManager.instance.logout(isAfterTip: true);
}
