import 'package:freezed_annotation/freezed_annotation.dart';
part 'base.response.freezed.dart';
part 'base.response.g.dart';

@freezed
@JsonSerializable(
  genericArgumentFactories: true,
  explicitToJson: true,
)
class BaseResponse<T> with _$BaseResponse<T> {
  const BaseResponse._();
  const factory BaseResponse({
    @Default(404) int status,
    String? message,
    T? data,
  }) = _BaseResponse<T>;
}
