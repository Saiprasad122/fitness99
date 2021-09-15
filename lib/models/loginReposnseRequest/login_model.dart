// To parse this JSON data, do
//
//     final allVoucherListResponse = allVoucherListResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
  LoginResponse({
    required this.result,
    required this.message,
    required this.status,
  });

  final Result result;
  final String message;
  final int status;

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        result: Result.fromJson(json["result"]),
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "message": message,
        "status": status,
      };
}

class Result {
  Result({
    required this.id,
    required this.userName,
    this.idProof,
    required this.email,
    required this.password,
    required this.profilePicture,
    this.height,
    this.weight,
    required this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.otp,
    this.profileStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String userName;
  final String? idProof;
  final String email;
  final String password;
  final String profilePicture;
  final double? height;
  final double? weight;
  final int gender;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? otp;
  final String? profileStatus;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] == null ? null : json["id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        idProof: json["id_proof"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        profilePicture:
            json["profile_picture"] == null ? null : json["profile_picture"],
        height: json["height"] == null ? null : json["height"],
        weight: json["weight"] == null ? null : json["weight"],
        gender: json["gender"] == null ? null : json["gender"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        otp: json["otp"],
        profileStatus: json["profile_status"],
        status: json["status"] == null ? null : json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "id_proof": idProof,
        "email": email,
        "password": password,
        "profile_picture": profilePicture,
        "height": height,
        "weight": weight,
        "gender": gender,
        "date_of_birth":
            "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "phone_number": phoneNumber,
        "otp": otp,
        "profile_status": profileStatus,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
