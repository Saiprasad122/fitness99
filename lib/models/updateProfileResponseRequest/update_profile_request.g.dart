// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequest(
      id: json['id'] as int?,
      userName: json['user_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profile_picture'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestToJson(
        UpdateProfileRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'profile_picture': instance.profilePicture,
    };
