// To parse this JSON data, do
//
//     final updateProfilePictureResponse = updateProfilePictureResponseFromJson(jsonString);

import 'dart:convert';

class UpdateProfilePictureResponse {
  UpdateProfilePictureResponse({
    required this.result,
    required this.message,
    required this.status,
  });

  final Result? result;
  final String message;
  final int status;

  factory UpdateProfilePictureResponse.fromRawJson(String str) =>
      UpdateProfilePictureResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfilePictureResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfilePictureResponse(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson() ?? 'N/A',
        "message": message,
        "status": status,
      };
}

class Result {
  Result({
    required this.id,
    required this.userName,
    this.phoneNumber,
    required this.email,
    required this.profilePicture,
    required this.status,
    this.groupCount = 0,
  });

  final int id;
  final String userName;
  final String? phoneNumber;
  final String email;
  final String profilePicture;
  final int status;
  final int groupCount;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] == null ? null : json["id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        phoneNumber: json["number"] == null ? null : json["number"],
        email: json["email"] == null ? null : json["email"],
        profilePicture:
            json["profile_picture"] == null ? null : json["profile_picture"],
        status: json["status"] == null ? null : json["status"],
        groupCount: json["group_count"] == null ? 0 : json["group_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "number": phoneNumber,
        "email": email,
        "profile_picture": profilePicture,
        "status": status,
        "group_count": groupCount
      };
}
