import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest extends Equatable {
  final int? id;
  @JsonKey(name: 'user_name')
  final String? userName;
  @JsonKey(name: 'number')
  final String? phoneNumber;
  final String? email;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;

  const UpdateProfileRequest({
    this.id,
    this.userName,
    this.phoneNumber,
    this.email,
    this.profilePicture,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateProfileRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);

  UpdateProfileRequest copyWith({
    int? id,
    String? userName,
    String? phoneNumber,
    String? email,
    String? profilePicture,
  }) {
    return UpdateProfileRequest(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userName,
      phoneNumber,
      email,
      profilePicture,
    ];
  }
}
