// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'http_bin_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return _Headers.fromJson(json);
}

/// @nodoc
mixin _$Headers {
  @JsonKey(name: "User-Agent")
  String get userAgent => throw _privateConstructorUsedError;
  @JsonKey(name: "X-Amzn-Trace-Id")
  String get traceId => throw _privateConstructorUsedError;
  @JsonKey(name: "Aabbcc")
  String? get bbc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HeadersCopyWith<Headers> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeadersCopyWith<$Res> {
  factory $HeadersCopyWith(Headers value, $Res Function(Headers) then) =
      _$HeadersCopyWithImpl<$Res, Headers>;
  @useResult
  $Res call(
      {@JsonKey(name: "User-Agent") String userAgent,
      @JsonKey(name: "X-Amzn-Trace-Id") String traceId,
      @JsonKey(name: "Aabbcc") String? bbc});
}

/// @nodoc
class _$HeadersCopyWithImpl<$Res, $Val extends Headers>
    implements $HeadersCopyWith<$Res> {
  _$HeadersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAgent = null,
    Object? traceId = null,
    Object? bbc = freezed,
  }) {
    return _then(_value.copyWith(
      userAgent: null == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      traceId: null == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String,
      bbc: freezed == bbc
          ? _value.bbc
          : bbc // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HeadersCopyWith<$Res> implements $HeadersCopyWith<$Res> {
  factory _$$_HeadersCopyWith(
          _$_Headers value, $Res Function(_$_Headers) then) =
      __$$_HeadersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "User-Agent") String userAgent,
      @JsonKey(name: "X-Amzn-Trace-Id") String traceId,
      @JsonKey(name: "Aabbcc") String? bbc});
}

/// @nodoc
class __$$_HeadersCopyWithImpl<$Res>
    extends _$HeadersCopyWithImpl<$Res, _$_Headers>
    implements _$$_HeadersCopyWith<$Res> {
  __$$_HeadersCopyWithImpl(_$_Headers _value, $Res Function(_$_Headers) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAgent = null,
    Object? traceId = null,
    Object? bbc = freezed,
  }) {
    return _then(_$_Headers(
      userAgent: null == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      traceId: null == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String,
      bbc: freezed == bbc
          ? _value.bbc
          : bbc // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Headers implements _Headers {
  _$_Headers(
      {@JsonKey(name: "User-Agent") required this.userAgent,
      @JsonKey(name: "X-Amzn-Trace-Id") required this.traceId,
      @JsonKey(name: "Aabbcc") this.bbc});

  factory _$_Headers.fromJson(Map<String, dynamic> json) =>
      _$$_HeadersFromJson(json);

  @override
  @JsonKey(name: "User-Agent")
  final String userAgent;
  @override
  @JsonKey(name: "X-Amzn-Trace-Id")
  final String traceId;
  @override
  @JsonKey(name: "Aabbcc")
  final String? bbc;

  @override
  String toString() {
    return 'Headers(userAgent: $userAgent, traceId: $traceId, bbc: $bbc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Headers &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.traceId, traceId) || other.traceId == traceId) &&
            (identical(other.bbc, bbc) || other.bbc == bbc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userAgent, traceId, bbc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HeadersCopyWith<_$_Headers> get copyWith =>
      __$$_HeadersCopyWithImpl<_$_Headers>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HeadersToJson(
      this,
    );
  }
}

abstract class _Headers implements Headers {
  factory _Headers(
      {@JsonKey(name: "User-Agent") required final String userAgent,
      @JsonKey(name: "X-Amzn-Trace-Id") required final String traceId,
      @JsonKey(name: "Aabbcc") final String? bbc}) = _$_Headers;

  factory _Headers.fromJson(Map<String, dynamic> json) = _$_Headers.fromJson;

  @override
  @JsonKey(name: "User-Agent")
  String get userAgent;
  @override
  @JsonKey(name: "X-Amzn-Trace-Id")
  String get traceId;
  @override
  @JsonKey(name: "Aabbcc")
  String? get bbc;
  @override
  @JsonKey(ignore: true)
  _$$_HeadersCopyWith<_$_Headers> get copyWith =>
      throw _privateConstructorUsedError;
}

HttpBinModel _$HttpBinModelFromJson(Map<String, dynamic> json) {
  return _HttpBinModel.fromJson(json);
}

/// @nodoc
mixin _$HttpBinModel {
  String get url => throw _privateConstructorUsedError;
  Headers get headers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HttpBinModelCopyWith<HttpBinModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HttpBinModelCopyWith<$Res> {
  factory $HttpBinModelCopyWith(
          HttpBinModel value, $Res Function(HttpBinModel) then) =
      _$HttpBinModelCopyWithImpl<$Res, HttpBinModel>;
  @useResult
  $Res call({String url, Headers headers});

  $HeadersCopyWith<$Res> get headers;
}

/// @nodoc
class _$HttpBinModelCopyWithImpl<$Res, $Val extends HttpBinModel>
    implements $HttpBinModelCopyWith<$Res> {
  _$HttpBinModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? headers = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Headers,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HeadersCopyWith<$Res> get headers {
    return $HeadersCopyWith<$Res>(_value.headers, (value) {
      return _then(_value.copyWith(headers: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_HttpBinModelCopyWith<$Res>
    implements $HttpBinModelCopyWith<$Res> {
  factory _$$_HttpBinModelCopyWith(
          _$_HttpBinModel value, $Res Function(_$_HttpBinModel) then) =
      __$$_HttpBinModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, Headers headers});

  @override
  $HeadersCopyWith<$Res> get headers;
}

/// @nodoc
class __$$_HttpBinModelCopyWithImpl<$Res>
    extends _$HttpBinModelCopyWithImpl<$Res, _$_HttpBinModel>
    implements _$$_HttpBinModelCopyWith<$Res> {
  __$$_HttpBinModelCopyWithImpl(
      _$_HttpBinModel _value, $Res Function(_$_HttpBinModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? headers = null,
  }) {
    return _then(_$_HttpBinModel(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Headers,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HttpBinModel implements _HttpBinModel {
  _$_HttpBinModel({required this.url, required this.headers});

  factory _$_HttpBinModel.fromJson(Map<String, dynamic> json) =>
      _$$_HttpBinModelFromJson(json);

  @override
  final String url;
  @override
  final Headers headers;

  @override
  String toString() {
    return 'HttpBinModel(url: $url, headers: $headers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HttpBinModel &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.headers, headers) || other.headers == headers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, headers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HttpBinModelCopyWith<_$_HttpBinModel> get copyWith =>
      __$$_HttpBinModelCopyWithImpl<_$_HttpBinModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HttpBinModelToJson(
      this,
    );
  }
}

abstract class _HttpBinModel implements HttpBinModel {
  factory _HttpBinModel(
      {required final String url,
      required final Headers headers}) = _$_HttpBinModel;

  factory _HttpBinModel.fromJson(Map<String, dynamic> json) =
      _$_HttpBinModel.fromJson;

  @override
  String get url;
  @override
  Headers get headers;
  @override
  @JsonKey(ignore: true)
  _$$_HttpBinModelCopyWith<_$_HttpBinModel> get copyWith =>
      throw _privateConstructorUsedError;
}
