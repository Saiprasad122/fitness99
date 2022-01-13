import 'dart:convert';

import 'package:flutter/foundation.dart';

class DisplayEventResponse {
  final int status;
  final Data data;
  DisplayEventResponse({
    required this.status,
    required this.data,
  });

  DisplayEventResponse copyWith({
    int? status,
    Data? data,
  }) {
    return DisplayEventResponse(
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

  factory DisplayEventResponse.fromMap(Map<String, dynamic> map) {
    return DisplayEventResponse(
      status: map['status']?.toInt() ?? 0,
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayEventResponse.fromJson(Map<String, dynamic> source) =>
      DisplayEventResponse.fromMap(source);

  @override
  String toString() => 'DisplayEventResponse(status: $status, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisplayEventResponse &&
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
  final int members;
  final String date;
  final String time;
  final int user_id;
  final int group_id;
  final String created_at;
  final String updated_at;
  final String location;
  Content({
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
  });

  Content copyWith({
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
  }) {
    return Content(
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
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Content(id: $id, title: $title, description: $description, members: $members, date: $date, time: $time, user_id: $user_id, group_id: $group_id, created_at: $created_at, updated_at: $updated_at, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Content &&
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
        other.location == location;
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
        location.hashCode;
  }
}
