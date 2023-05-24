// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_bin_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Headers _$$_HeadersFromJson(Map<String, dynamic> json) => _$_Headers(
      userAgent: json['User-Agent'] as String,
      traceId: json['X-Amzn-Trace-Id'] as String,
    );

Map<String, dynamic> _$$_HeadersToJson(_$_Headers instance) =>
    <String, dynamic>{
      'User-Agent': instance.userAgent,
      'X-Amzn-Trace-Id': instance.traceId,
    };

_$_HttpBinModel _$$_HttpBinModelFromJson(Map<String, dynamic> json) =>
    _$_HttpBinModel(
      url: json['url'] as String,
      headers: Headers.fromJson(json['headers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_HttpBinModelToJson(_$_HttpBinModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'headers': instance.headers,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncHttpBinHash() => r'87a5c80915ba19834b72197b8196cb86fd40ccc2';

/// See also [AsyncHttpBin].
@ProviderFor(AsyncHttpBin)
final asyncHttpBinProvider =
    AutoDisposeAsyncNotifierProvider<AsyncHttpBin, HttpBinModel>.internal(
  AsyncHttpBin.new,
  name: r'asyncHttpBinProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$asyncHttpBinHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncHttpBin = AutoDisposeAsyncNotifier<HttpBinModel>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
