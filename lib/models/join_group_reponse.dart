import 'dart:convert';

import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';

class JoinGroupResponse {
  final User user_id;
  JoinGroupResponse({
    required this.user_id,
  });

  JoinGroupResponse copyWith({
    User? user_id,
  }) {
    return JoinGroupResponse(
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id.toMap(),
    };
  }

  factory JoinGroupResponse.fromMap(Map<String, dynamic> map) {
    return JoinGroupResponse(
      user_id: User.fromMap(map['user_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory JoinGroupResponse.fromJson(Map<String, dynamic> source) =>
      JoinGroupResponse.fromMap(source);

  @override
  String toString() => 'JoinGroupResponse(user_id: $user_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JoinGroupResponse && other.user_id == user_id;
  }

  @override
  int get hashCode => user_id.hashCode;
}
