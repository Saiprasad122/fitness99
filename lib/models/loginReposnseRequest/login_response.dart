import 'dart:convert';

LoginResponse loginResponseFromMap(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToMap(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.user,
  });

  final String status;
  final User user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.userName,
    required this.idProof,
    required this.email,
    required this.password,
    required this.profilePicture,
    required this.personalGoal,
    required this.height,
    required this.weight,
    required this.gender,
    required this.dateOfBirth,
    required this.goalId,
    required this.goalDescription,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.groupCount,
    required this.number,
  });

  final int id;
  final String userName;
  final dynamic idProof;
  final String email;
  final String password;
  final dynamic profilePicture;
  final dynamic personalGoal;
  final dynamic height;
  final dynamic weight;
  final dynamic gender;
  final dynamic dateOfBirth;
  final dynamic goalId;
  final dynamic goalDescription;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int groupCount;
  final String? number;
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["user_name"],
        idProof: json["id_proof"],
        email: json["email"],
        password: json["password"],
        profilePicture: json["profile_picture"],
        personalGoal: json["personal_goal"],
        height: json["height"],
        weight: json["weight"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        goalId: json["goal_id"],
        goalDescription: json["goal_description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        groupCount: json["group_count"] ?? 0,
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "id_proof": idProof,
        "email": email,
        "password": password,
        "profile_picture": profilePicture,
        "personal_goal": personalGoal,
        "height": height,
        "weight": weight,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "goal_id": goalId,
        "goal_description": goalDescription,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "group_count": groupCount,
        "number": number
      };
}
