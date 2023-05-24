import 'dart:io';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'http_error.dart';
import 'log_util.dart';

///数据解析回调
typedef JsonParse<T> = T Function(dynamic data);

class HttpManager {
  ///同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  final Map<String, CancelToken> _cancelTokens = <String, CancelToken>{};

  ///超时时间
  static const Duration connectTimeout = Duration(milliseconds: 30000);
  static const Duration receiveTimeout = Duration(milliseconds: 30000);

  /// http request methods
  static const String get = "get";
  static const String post = "post";

  late Dio _client;

  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager() => _instance;

  Dio get client => _client;

  /// 创建 dio 实例对象
  HttpManager._internal() {
    BaseOptions options = BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: {
        "version": "1.0.0",
      },
    );
    _client = Dio(options);
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init(
    String baseUrl, {
    Duration connectTimeout = connectTimeout,
    Duration receiveTimeout = receiveTimeout,
    List<Interceptor>? interceptors,
  }) {
    _client.options = _client.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      _client.interceptors.addAll(interceptors);
    }
  }

  ///GET异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[jsonParse] json解析
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> getAsync<T>(
    String url, {
    Map<String, Object>? queryParameters,
    Map<String, dynamic>? headers,
    JsonParse<T>? jsonParse,
    String? tag,
  }) async {
    return _requestAsync(
      url: url,
      method: get,
      queryParameters: queryParameters,
      headers: headers,
      jsonParse: jsonParse,
      tag: tag,
    );
  }

  ///POST 异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> postAsync<T>(
    String url, {
    Map<String, Object>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
    JsonParse<T>? jsonParse,
    String? tag,
  }) async {
    return _requestAsync(
      url: url,
      method: post,
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      jsonParse: jsonParse,
      tag: tag,
    );
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> _requestAsync<T>({
    required String url,
    required String method,
    Map<String, Object>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
    JsonParse<T>? jsonParse,
    String? tag,
  }) async {
    await _checkNetwork();

    try {
      Options options = Options()
        ..method = method
        ..headers = headers;

      CancelToken? cancelToken;
      if (tag != null) {
        cancelToken = _cancelTokens[tag] ?? CancelToken();
        _cancelTokens[tag] = cancelToken;
      }

      Response<Map<String, dynamic>> response = await _client.request(
        url,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );

      return _handleResponse(response, jsonParse: jsonParse);
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      throw ApiException.dioError(e);
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      throw ApiException(
          ApiException.unknownCode, ApiException.unknownException);
    }
  }

  ///异步下载文件
  ///
  ///[url] 下载地址
  ///[savePath]  文件保存路径
  ///[onReceiveProgress]  文件保存路径
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<String> downloadAsync(
    String url, {
    required String savePath,
    ProgressCallback? onReceiveProgress,
    Map<String, Object>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
    String? tag,
  }) async {
    await _checkNetwork();

    try {
      Options options = Options()..headers = headers;

      CancelToken? cancelToken;
      if (tag != null) {
        cancelToken = _cancelTokens[tag] ?? CancelToken();
        _cancelTokens[tag] = cancelToken;
      }

      Response<dynamic> response = await _client.download(url, savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken);

      return _handleResponse<String>(response, downDonePath: savePath);
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      throw ApiException.dioError(e);
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      throw ApiException(
          ApiException.unknownCode, ApiException.unknownException);
    }
  }

  ///上传文件
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> uploadAsync<T>(
    String url, {
    required FormData data,
    ProgressCallback? onSendProgress,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    String? tag,
  }) async {
    await _checkNetwork();

    Options options = Options()
      ..method = "post"
      ..headers = headers;

    try {
      CancelToken? cancelToken;
      if (tag != null) {
        cancelToken = _cancelTokens[tag] ?? CancelToken();
        _cancelTokens[tag] = cancelToken;
      }

      Response response = await _client.request(url,
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);

      return _handleResponse(response);
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      throw ApiException.dioError(e);
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      throw ApiException(
          ApiException.unknownCode, ApiException.unknownException);
    }
  }

  Future<void> _checkNetwork() async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      LogUtil.v("请求网络异常，请稍后重试！");
      throw ApiException(ApiException.unknownCode, "网络异常，请稍后重试！");
    }
  }

  T _handleResponse<T>(Response response,
      {JsonParse<T>? jsonParse, String? downDonePath}) {
    if (response.statusCode == HttpStatus.ok) {
      if (jsonParse != null) {
        return jsonParse(response.data);
      } else {
        if (downDonePath != null) return downDonePath as T;
        return response.data as T;
      }
    } else {
      throw ApiException(
          ApiException.unknownCode, ApiException.unknownException);
    }
  }

  ///取消网络请求
  void cancel(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag]!.isCancelled) {
        _cancelTokens[tag]?.cancel();
      }
      _cancelTokens.remove(tag);
    }
  }
}
