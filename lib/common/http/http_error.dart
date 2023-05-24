import 'package:dio/dio.dart';

class ApiException implements Exception {
  static const unknownCode = -1;
  static const unknownException = "未知错误";

  final int code;
  final String? message;

  ApiException(this.code, this.message);

  factory ApiException.dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return BadRequestException(unknownCode, "请求取消");
      case DioErrorType.connectionTimeout:
        return BadRequestException(unknownCode, "连接超时");
      case DioErrorType.sendTimeout:
        return BadRequestException(unknownCode, "请求超时");
      case DioErrorType.receiveTimeout:
        return BadRequestException(unknownCode, "响应超时");
      default:
        return ApiException(unknownCode, error.message);
    }
  }

  @override
  String toString() {
    return 'HttpError {code: $code, message: $message}';
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException(int code, String message) : super(code, message);
}
