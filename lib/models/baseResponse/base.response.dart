import 'package:freezed_annotation/freezed_annotation.dart';
part 'base.response.freezed.dart';
part 'base.response.g.dart';

@freezed
class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    @Default(404) int status,
    String? message,
    @JsonKey(name: 'result') T? data,
  }) = _BaseResponse;


  factory  BaseResponse<T>.fromJson(Map<String, dynamic> json, T fromJson) =>
      _$BaseResponseFromJson(json, fromJson);

  @override
  BaseResponse fromMap(Map<String, dynamic> map, T fromJson) {
    return BaseResponse.fromJson(map, fromJson);
  }

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
