import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_picture_request.g.dart';

@JsonSerializable()
class UpdateProfilePictureRequest extends Equatable {
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'profile_picture')
  final dynamic profilePicture;

  const UpdateProfilePictureRequest({this.userId, this.profilePicture});

  factory UpdateProfilePictureRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateProfilePictureRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateProfilePictureRequestToJson(this);

  UpdateProfilePictureRequest copyWith({
    int? userId,
    dynamic profilePicture,
  }) {
    return UpdateProfilePictureRequest(
      userId: userId ?? this.userId,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userId, profilePicture];
}
