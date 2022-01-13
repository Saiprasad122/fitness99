import 'dart:convert';

class DisplayActivityResponse {
  final int id;
  final String title;
  final String description;
  final String created_at;
  final String updated_at;
  final String location;
  final String note;
  final String day;
  final String from_time;
  final String to_time;
  final int user_id;
  final int group_id;
  DisplayActivityResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.created_at,
    required this.updated_at,
    required this.location,
    required this.note,
    required this.day,
    required this.from_time,
    required this.to_time,
    required this.user_id,
    required this.group_id,
  });

  DisplayActivityResponse copyWith({
    int? id,
    String? title,
    String? description,
    String? created_at,
    String? updated_at,
    String? location,
    String? note,
    String? day,
    String? from_time,
    String? to_time,
    int? user_id,
    int? group_id,
  }) {
    return DisplayActivityResponse(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      location: location ?? this.location,
      note: note ?? this.note,
      day: day ?? this.day,
      from_time: from_time ?? this.from_time,
      to_time: to_time ?? this.to_time,
      user_id: user_id ?? this.user_id,
      group_id: group_id ?? this.group_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': created_at,
      'updated_at': updated_at,
      'location': location,
      'note': note,
      'day': day,
      'from_time': from_time,
      'to_time': to_time,
      'user_id': user_id,
      'group_id': group_id,
    };
  }

  factory DisplayActivityResponse.fromMap(Map<String, dynamic> map) {
    return DisplayActivityResponse(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
      location: map['location'] ?? '',
      note: map['note'] ?? '',
      day: map['day'] ?? '',
      from_time: map['from_time'] ?? '',
      to_time: map['to_time'] ?? '',
      user_id: map['user_id']?.toInt() ?? 0,
      group_id: map['group_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayActivityResponse.fromJson(Map<String, dynamic> source) =>
      DisplayActivityResponse.fromMap(source);

  @override
  String toString() {
    return 'DisplayActivityResponse(id: $id, title: $title, description: $description, created_at: $created_at, updated_at: $updated_at, location: $location, note: $note, day: $day, from_time: $from_time, to_time: $to_time, user_id: $user_id, group_id: $group_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisplayActivityResponse &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.location == location &&
        other.note == note &&
        other.day == day &&
        other.from_time == from_time &&
        other.to_time == to_time &&
        other.user_id == user_id &&
        other.group_id == group_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        location.hashCode ^
        note.hashCode ^
        day.hashCode ^
        from_time.hashCode ^
        to_time.hashCode ^
        user_id.hashCode ^
        group_id.hashCode;
  }
}
