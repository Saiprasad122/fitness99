import 'dart:convert';

import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:flutter/foundation.dart';

class SendInvitationGroupResponse {
  final List<User> user;
  final int InvitationCount;
  SendInvitationGroupResponse({
    required this.user,
    required this.InvitationCount,
  });

  SendInvitationGroupResponse copyWith({
    List<User>? user,
    int? InvitationCount,
  }) {
    return SendInvitationGroupResponse(
      user: user ?? this.user,
      InvitationCount: InvitationCount ?? this.InvitationCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.map((x) => x.toJson()).toList(),
      'InvitationCount': InvitationCount,
    };
  }

  factory SendInvitationGroupResponse.fromMap(Map<String, dynamic> map) {
    return SendInvitationGroupResponse(
      user: List<User>.from(map['user']?.map((x) => User.fromJson(x))),
      InvitationCount: map['InvitationCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendInvitationGroupResponse.fromJson(Map<String, dynamic> source) =>
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
