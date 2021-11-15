import 'dart:convert';

class DisplayGroups {
  final int id;
  final int user_id;
  final String group_name;
  final String goal;
  final String active_members;
  final String max_group_members;
  final String location;
  final double? radius;
  final String group_image;
  final String created_at;
  final String updated_at;
  final String comments;
  DisplayGroups({
    required this.id,
    required this.user_id,
    required this.group_name,
    required this.goal,
    required this.active_members,
    required this.max_group_members,
    required this.location,
    required this.radius,
    required this.group_image,
    required this.created_at,
    required this.updated_at,
    required this.comments,
  });

  DisplayGroups copyWith({
    int? id,
    int? user_id,
    String? group_name,
    String? goal,
    String? active_members,
    String? max_group_members,
    String? location,
    double? radius,
    String? group_image,
    String? created_at,
    String? updated_at,
    String? comments,
  }) {
    return DisplayGroups(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      group_name: group_name ?? this.group_name,
      goal: goal ?? this.goal,
      active_members: active_members ?? this.active_members,
      max_group_members: max_group_members ?? this.max_group_members,
      location: location ?? this.location,
      radius: radius ?? this.radius,
      group_image: group_image ?? this.group_image,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'group_name': group_name,
      'goal': goal,
      'active_members': active_members,
      'max_group_members': max_group_members,
      'location': location,
      'radius': radius,
      'group_image': group_image,
      'created_at': created_at,
      'updated_at': updated_at,
      'comments': comments,
    };
  }

  factory DisplayGroups.fromMap(Map<String, dynamic> map) {
    return DisplayGroups(
      id: map['id']?.toInt(),
      user_id: map['user_id']?.toInt(),
      group_name: map['group_name'],
      goal: map['goal'],
      active_members: map['active_members'],
      max_group_members: map['max_group_members'],
      location: map['location'],
      radius: map['radius'],
      group_image: map['group_image'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      comments: map['comments'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayGroups.fromJson(Map<String, dynamic> source) =>
      DisplayGroups.fromMap(source);

  @override
  String toString() {
    return 'DisplayGroups(id: $id, user_id: $user_id, group_name: $group_name, goal: $goal, active_members: $active_members, max_group_members: $max_group_members, location: $location, radius: $radius, group_image: $group_image, created_at: $created_at, updated_at: $updated_at, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisplayGroups &&
        other.id == id &&
        other.user_id == user_id &&
        other.group_name == group_name &&
        other.goal == goal &&
        other.active_members == active_members &&
        other.max_group_members == max_group_members &&
        other.location == location &&
        other.radius == radius &&
        other.group_image == group_image &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.comments == comments;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        group_name.hashCode ^
        goal.hashCode ^
        active_members.hashCode ^
        max_group_members.hashCode ^
        location.hashCode ^
        radius.hashCode ^
        group_image.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        comments.hashCode;
  }
}
