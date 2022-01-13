import 'package:freezed_annotation/freezed_annotation.dart';
part 'base.response.g.dart';

@JsonSerializable(
    includeIfNull: false, genericArgumentFactories: true, explicitToJson: false)
class BaseResponse<T> {
  const BaseResponse({required this.status, this.data, required this.message});
  final String? message;
  final int status;
  final T? data;

  BaseResponse<T> copyWith({int? code, T? data, String? message}) =>
      BaseResponse(
          status: code ?? this.status,
          data: data ?? this.data,
          message: message ?? this.message);

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
