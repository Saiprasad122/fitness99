import 'dart:convert';

class DisplayGlobalEventList {
  final int id;
  final String title;
  final String description;
  final int members;
  final String date;
  final String time;
  final int user_id;
  final int group_id;
  final String created_at;
  final String updated_at;
  final String location;
  final int active;
  DisplayGlobalEventList({
    required this.id,
    required this.title,
    required this.description,
    required this.members,
    required this.date,
    required this.time,
    required this.user_id,
    required this.group_id,
    required this.created_at,
    required this.updated_at,
    required this.location,
    required this.active,
  });

  DisplayGlobalEventList copyWith({
    int? id,
    String? title,
    String? description,
    int? members,
    String? date,
    String? time,
    int? user_id,
    int? group_id,
    String? created_at,
    String? updated_at,
    String? location,
    int? active,
  }) {
    return DisplayGlobalEventList(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      members: members ?? this.members,
      date: date ?? this.date,
      time: time ?? this.time,
      user_id: user_id ?? this.user_id,
      group_id: group_id ?? this.group_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      location: location ?? this.location,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'members': members,
      'date': date,
      'time': time,
      'user_id': user_id,
      'group_id': group_id,
      'created_at': created_at,
      'updated_at': updated_at,
      'location': location,
      'active': active,
    };
  }

  factory DisplayGlobalEventList.fromMap(Map<String, dynamic> map) {
    return DisplayGlobalEventList(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      members: map['members']?.toInt() ?? 0,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      user_id: map['user_id']?.toInt() ?? 0,
      group_id: map['group_id']?.toInt() ?? 0,
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
      location: map['location'] ?? '',
      active: map['active']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayGlobalEventList.fromJson(Map<String, dynamic> source) =>
      DisplayGlobalEventList.fromMap(source);

  @override
  String toString() {
    return 'DisplayGlobalEventList(id: $id, title: $title, description: $description, members: $members, date: $date, time: $time, user_id: $user_id, group_id: $group_id, created_at: $created_at, updated_at: $updated_at, location: $location, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisplayGlobalEventList &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.members == members &&
        other.date == date &&
        other.time == time &&
        other.user_id == user_id &&
        other.group_id == group_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.location == location &&
        other.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        members.hashCode ^
        date.hashCode ^
        time.hashCode ^
        user_id.hashCode ^
        group_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        location.hashCode ^
        active.hashCode;
  }
}
