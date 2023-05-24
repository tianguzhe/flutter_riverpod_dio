import 'package:flutter_riverpod_demo/common/http/http_manager_nullsafe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_bin_view_model.freezed.dart';

part 'http_bin_view_model.g.dart';

@freezed
class Headers with _$Headers {
  factory Headers({
    @JsonKey(name: "User-Agent") required String userAgent,
    @JsonKey(name: "X-Amzn-Trace-Id") required String traceId,
  }) = _Headers;

  factory Headers.fromJson(Map<String, Object?> json) =>
      _$HeadersFromJson(json);
}

@freezed
class HttpBinModel with _$HttpBinModel {
  factory HttpBinModel({
    required String url,
    required Headers headers,
  }) = _HttpBinModel;

  factory HttpBinModel.fromJson(Map<String, Object?> json) =>
      _$HttpBinModelFromJson(json);
}

@riverpod
class AsyncHttpBin extends _$AsyncHttpBin {
  Future<HttpBinModel> _fetchTodo() async {
    // final json = await HttpManager().getAsync<HttpBinModel>(
    //   "/get",
    //   jsonParse: (data) => HttpBinModel.fromJson(data),
    // );

    final jsonResp = await HttpManager().getAsync<Map<String, dynamic>>(
      "/get",
      queryParameters: {"age": 12, "name": "zs"},
    );
    final json = HttpBinModel.fromJson(jsonResp);

    return json;
  }

  @override
  Future<HttpBinModel> build() => _fetchTodo();
}
