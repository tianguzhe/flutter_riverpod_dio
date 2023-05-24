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
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  /// http request methods
  static const String GET = "get";
  static const String POST = "post";

  late Dio _client;

  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager() => _instance;

  Dio get client => _client;

  /// 创建 dio 实例对象
  HttpManager._internal() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: CONNECT_TIMEOUT),
      receiveTimeout: const Duration(milliseconds: RECEIVE_TIMEOUT),
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
    Duration connectTimeout = const Duration(milliseconds: CONNECT_TIMEOUT),
    Duration receiveTimeout = const Duration(milliseconds: CONNECT_TIMEOUT),
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
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
    String? tag,
  }) async {
    return _requestAsync(
      url: url,
      method: GET,
      params: params,
      options: options,
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
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
    String? tag,
  }) async {
    return _requestAsync(
      url: url,
      method: POST,
      data: data,
      params: params,
      options: options,
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
    String? method,
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
    String? tag,
  }) async {
    await _checkNetwork();

    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';

    options?.method = method;

    options = options ??
        Options(
          method: method,
        );

    try {
      CancelToken? cancelToken;
      if (tag != null) {
        cancelToken = _cancelTokens[tag] ?? CancelToken();
        _cancelTokens[tag] = cancelToken;
      }

      Response<Map<String, dynamic>> response = await _client.request(
        url,
        queryParameters: params,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );

      final statusCode = response.statusCode;

      if (statusCode == HttpStatus.ok) {
        //成功
        if (jsonParse != null) {
          return jsonParse(response.data);
        } else {
          return response.data as T;
        }
      } else {
        //失败
        LogUtil.v("请求服务器出错：${response.statusCode}");
        //只能用 Future，外层有 try catch
        return Future.error((HttpError(statusCode.toString(), "请求服务器出错：")));
      }
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
      // throw Error();
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
      // throw Error();
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
  Future<Response> downloadAsync(
    String url, {
    required Object savePath,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? params,
    Object? data,
    Options? options,
    String? tag,
  }) async {
    await _checkNetwork();

    //设置默认值
    params = params ?? {};

    try {
      CancelToken? cancelToken;
      if (tag != null) {
        cancelToken = _cancelTokens[tag] ?? CancelToken();
        _cancelTokens[tag] = cancelToken;
      }

      return _client.download(url, savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken);
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
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
    Options? options,
    JsonParse<T>? jsonParse,
    String? tag,
  }) async {
    await _checkNetwork();

    //设置默认值
    params = params ?? {};

    //强制 POST 请求
    options?.method = POST;

    options = options ??
        Options(
          method: POST,
        );

    try {
      CancelToken? cancelToken;
      if (tag != null) {
        cancelToken = _cancelTokens[tag] ?? CancelToken();
        _cancelTokens[tag] = cancelToken;
      }

      Response<Map<String, dynamic>> response = await _client.request(url,
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);

      final statusCode = response.statusCode;

      if (statusCode == HttpStatus.ok) {
        //成功
        if (jsonParse != null) {
          return jsonParse(response.data);
        } else {
          return response.data as T;
        }
      } else {
        //失败
        LogUtil.v("请求服务器出错：${response.statusCode}");
        //只能用 Future，外层有 try catch
        return Future.error((HttpError(statusCode.toString(), "请求服务器出错：")));
      }
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
    }
  }

  Future<void> _checkNetwork() async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      LogUtil.v("请求网络异常，请稍后重试！");
      throw (HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
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
