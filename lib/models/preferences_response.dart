import 'dart:convert';

class PreferenceResponse {
  final int id;
  final String day;
  final int user_id;
  final String from_time;
  final String to_time;
  final String created_at;
  final String updated_at;
  PreferenceResponse({
    required this.id,
    required this.day,
    required this.user_id,
    required this.from_time,
    required this.to_time,
    required this.created_at,
    required this.updated_at,
  });

  PreferenceResponse copyWith({
    int? id,
    String? day,
    int? user_id,
    String? from_time,
    String? to_time,
    String? created_at,
    String? updated_at,
  }) {
    return PreferenceResponse(
      id: id ?? this.id,
      day: day ?? this.day,
      user_id: user_id ?? this.user_id,
      from_time: from_time ?? this.from_time,
      to_time: to_time ?? this.to_time,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'user_id': user_id,
      'from_time': from_time,
      'to_time': to_time,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory PreferenceResponse.fromMap(Map<String, dynamic> map) {
    return PreferenceResponse(
      id: map['id']?.toInt() ?? 0,
      day: map['day'] ?? '',
      user_id: map['user_id']?.toInt() ?? 0,
      from_time: map['from_time'] ?? '',
      to_time: map['to_time'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PreferenceResponse.fromJson(Map<String, dynamic> source) =>
      PreferenceResponse.fromMap(source);

  @override
  String toString() {
    return 'PreferenceResponse(id: $id, day: $day, user_id: $user_id, from_time: $from_time, to_time: $to_time, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PreferenceResponse &&
        other.id == id &&
        other.day == day &&
        other.user_id == user_id &&
        other.from_time == from_time &&
        other.to_time == to_time &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        day.hashCode ^
        user_id.hashCode ^
        from_time.hashCode ^
        to_time.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
