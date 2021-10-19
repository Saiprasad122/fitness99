// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

class SignUpResponse {
  SignUpResponse({
    this.result,
    this.error,
    required this.message,
    required this.status,
  });

  final Result? result;
  final String? error;
  final String message;
  final dynamic status;

  factory SignUpResponse.fromRawJson(String str) =>
      SignUpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson() ?? "N/A",
        "error": error,
        "message": message,
        "status": status,
      };
}

class Result {
  Result({
    required this.userName,
    required this.email,
    required this.password,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String userName;
  final String email;
  final String password;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userName: json["user_name"] == null ? null : json["user_name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "email": email,
        "password": password,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };

  toLowerCase() {}
}
