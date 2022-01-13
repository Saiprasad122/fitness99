import 'dart:convert';

import 'package:flutter/foundation.dart';

class DisplayActivityResponse {
  final int status;
  final Data data;
  DisplayActivityResponse({
    required this.status,
    required this.data,
  });

  DisplayActivityResponse copyWith({
    int? status,
    Data? data,
  }) {
    return DisplayActivityResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory DisplayActivityResponse.fromMap(Map<String, dynamic> map) {
    return DisplayActivityResponse(
      status: map['status']?.toInt() ?? 0,
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayActivityResponse.fromJson(Map<String, dynamic> source) =>
      DisplayActivityResponse.fromMap(source);

  @override
  String toString() => 'DisplayActivityResponse(status: $status, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisplayActivityResponse &&
        other.status == status &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  final int current_page;
  final List<Content> content;
  Data({
    required this.current_page,
    required this.content,
  });

  Data copyWith({
    int? current_page,
    List<Content>? content,
  }) {
    return Data(
      current_page: current_page ?? this.current_page,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_page': current_page,
      'data': content.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      current_page: map['current_page']?.toInt() ?? 0,
      content: List<Content>.from(map['data']?.map((x) => Content.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() => 'Data(current_page: $current_page, data: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        other.current_page == current_page &&
        listEquals(other.content, content);
  }

  @override
  int get hashCode => current_page.hashCode ^ content.hashCode;
}

class Content {
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
  Content({
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

  Content copyWith({
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
    return Content(
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

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
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

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Content(id: $id, title: $title, description: $description, created_at: $created_at, updated_at: $updated_at, location: $location, note: $note, day: $day, from_time: $from_time, to_time: $to_time, user_id: $user_id, group_id: $group_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Content &&
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
