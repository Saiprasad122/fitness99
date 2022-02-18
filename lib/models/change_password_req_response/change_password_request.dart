import 'package:json_annotation/json_annotation.dart';
part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  String user_id, password, new_password;
  ChangePasswordRequest({
    required this.user_id,
    required this.password,
    required this.new_password,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
