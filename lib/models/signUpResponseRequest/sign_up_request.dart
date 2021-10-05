import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest extends Equatable {
  @JsonKey(name: 'user_name')
  final String? userName;
  final String? email;
  final String? password;

  const SignUpRequest({this.userName, this.email, this.password});

  factory SignUpRequest.fromJson(Map<String, dynamic> json) {
    return _$SignUpRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);

  SignUpRequest copyWith({
    String? userName,
    String? email,
    String? password,
  }) {
    return SignUpRequest(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userName, email, password];
}
