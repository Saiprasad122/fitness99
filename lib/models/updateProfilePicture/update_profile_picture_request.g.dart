// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_picture_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfilePictureRequest _$UpdateProfilePictureRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfilePictureRequest(
      userId: json['user_id'] as int?,
      profilePicture: json['profile_picture'] as MultipartFile?,
    );

Map<String, dynamic> _$UpdateProfilePictureRequestToJson(
        UpdateProfilePictureRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'profile_picture': instance.profilePicture,
    };
