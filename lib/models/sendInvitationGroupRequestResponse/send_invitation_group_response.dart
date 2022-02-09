import 'dart:convert';

import 'package:flutter/foundation.dart';

class SendInvitationGroupResponse {
  final List<Users> user;
  final int InvitationCount;
  SendInvitationGroupResponse({
    required this.user,
    required this.InvitationCount,
  });

  SendInvitationGroupResponse copyWith({
    List<Users>? user,
    int? InvitationCount,
  }) {
    return SendInvitationGroupResponse(
      user: user ?? this.user,
      InvitationCount: InvitationCount ?? this.InvitationCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.map((x) => x.toMap()).toList(),
      'InvitationCount': InvitationCount,
    };
  }

  factory SendInvitationGroupResponse.fromMap(Map<String, dynamic> map) {
    return SendInvitationGroupResponse(
      user: List<Users>.from(map['user']?.map((x) => Users.fromMap(x))),
      InvitationCount: map['InvitationCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendInvitationGroupResponse.fromJson(source) =>
      SendInvitationGroupResponse.fromMap(source);

  @override
  String toString() =>
      'SendInvitationGroupResponse(user: $user, InvitationCount: $InvitationCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendInvitationGroupResponse &&
        listEquals(other.user, user) &&
        other.InvitationCount == InvitationCount;
  }

  @override
  int get hashCode => user.hashCode ^ InvitationCount.hashCode;
}

class Users {
  final int id;
  final String user_name;
  final String id_proof;
  final String email;
  final String password;
  final String profile_picture;
  final String personal_goal;
  final String height;
  final String weight;
  final String gender;
  final String date_of_birth;
  final int goal_id;
  final String goal_description;
  final int status;
  final String created_at;
  final String updated_at;
  final String otp;
  final String group_count;
  final String number;
  final String api_token;
  Users({
    required this.id,
    required this.user_name,
    required this.id_proof,
    required this.email,
    required this.password,
    required this.profile_picture,
    required this.personal_goal,
    required this.height,
    required this.weight,
    required this.gender,
    required this.date_of_birth,
    required this.goal_id,
    required this.goal_description,
    required this.status,
    required this.created_at,
    required this.updated_at,
    required this.otp,
    required this.group_count,
    required this.number,
    required this.api_token,
  });

  Users copyWith({
    int? id,
    String? user_name,
    String? id_proof,
    String? email,
    String? password,
    String? profile_picture,
    String? personal_goal,
    String? height,
    String? weight,
    String? gender,
    String? date_of_birth,
    int? goal_id,
    String? goal_description,
    int? status,
    String? created_at,
    String? updated_at,
    String? otp,
    String? group_count,
    String? number,
    String? api_token,
  }) {
    return Users(
      id: id ?? this.id,
      user_name: user_name ?? this.user_name,
      id_proof: id_proof ?? this.id_proof,
      email: email ?? this.email,
      password: password ?? this.password,
      profile_picture: profile_picture ?? this.profile_picture,
      personal_goal: personal_goal ?? this.personal_goal,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      date_of_birth: date_of_birth ?? this.date_of_birth,
      goal_id: goal_id ?? this.goal_id,
      goal_description: goal_description ?? this.goal_description,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      otp: otp ?? this.otp,
      group_count: group_count ?? this.group_count,
      number: number ?? this.number,
      api_token: api_token ?? this.api_token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_name': user_name,
      'id_proof': id_proof,
      'email': email,
      'password': password,
      'profile_picture': profile_picture,
      'personal_goal': personal_goal,
      'height': height,
      'weight': weight,
      'gender': gender,
      'date_of_birth': date_of_birth,
      'goal_id': goal_id,
      'goal_description': goal_description,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
      'otp': otp,
      'group_count': group_count,
      'number': number,
      'api_token': api_token,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id']?.toInt() ?? 0,
      user_name: map['user_name'] ?? '',
      id_proof: map['id_proof'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      profile_picture: map['profile_picture'] ?? '',
      personal_goal: map['personal_goal'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      gender: map['gender'] ?? '',
      date_of_birth: map['date_of_birth'] ?? '',
      goal_id: map['goal_id']?.toInt() ?? 0,
      goal_description: map['goal_description'] ?? '',
      status: map['status']?.toInt() ?? 0,
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
      otp: map['otp'] ?? '',
      group_count: map['group_count'] ?? '',
      number: map['number'] ?? '',
      api_token: map['api_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Users(id: $id, user_name: $user_name, id_proof: $id_proof, email: $email, password: $password, profile_picture: $profile_picture, personal_goal: $personal_goal, height: $height, weight: $weight, gender: $gender, date_of_birth: $date_of_birth, goal_id: $goal_id, goal_description: $goal_description, status: $status, created_at: $created_at, updated_at: $updated_at, otp: $otp, group_count: $group_count, number: $number, api_token: $api_token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.id == id &&
        other.user_name == user_name &&
        other.id_proof == id_proof &&
        other.email == email &&
        other.password == password &&
        other.profile_picture == profile_picture &&
        other.personal_goal == personal_goal &&
        other.height == height &&
        other.weight == weight &&
        other.gender == gender &&
        other.date_of_birth == date_of_birth &&
        other.goal_id == goal_id &&
        other.goal_description == goal_description &&
        other.status == status &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.otp == otp &&
        other.group_count == group_count &&
        other.number == number &&
        other.api_token == api_token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_name.hashCode ^
        id_proof.hashCode ^
        email.hashCode ^
        password.hashCode ^
        profile_picture.hashCode ^
        personal_goal.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        gender.hashCode ^
        date_of_birth.hashCode ^
        goal_id.hashCode ^
        goal_description.hashCode ^
        status.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        otp.hashCode ^
        group_count.hashCode ^
        number.hashCode ^
        api_token.hashCode;
  }
}
