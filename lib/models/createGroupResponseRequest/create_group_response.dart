import 'dart:convert';

class CreateGroupResponse {
  final int status;
  final Data data;
  CreateGroupResponse({
    required this.status,
    required this.data,
  });

  CreateGroupResponse copyWith({
    int? status,
    Data? data,
  }) {
    return CreateGroupResponse(
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

  factory CreateGroupResponse.fromMap(Map<String, dynamic> map) {
    return CreateGroupResponse(
      status: map['status']?.toInt(),
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateGroupResponse.fromJson(Map<String, dynamic> source) =>
      CreateGroupResponse.fromMap(source);

  @override
  String toString() => 'CreateGroupResponse(status: $status, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateGroupResponse &&
        other.status == status &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  final Group group;
  final User user;
  Data({
    required this.group,
    required this.user,
  });

  Data copyWith({
    Group? group,
    User? user,
  }) {
    return Data(
      group: group ?? this.group,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'group': group.toMap(),
      'user': user.toMap(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      group: Group.fromMap(map['group']),
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() => 'Data(group: $group, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data && other.group == group && other.user == user;
  }

  @override
  int get hashCode => group.hashCode ^ user.hashCode;
}

class Group {
  final String user_id;
  final String group_name;
  final String goal;
  final int active_members;
  final String max_group_members;
  final String location;
  final String comments;
  final double? radius;
  final String group_image;
  final String updated_at;
  final String created_at;
  final int id;
  Group({
    required this.user_id,
    required this.group_name,
    required this.goal,
    required this.active_members,
    required this.max_group_members,
    required this.location,
    required this.comments,
    required this.radius,
    required this.group_image,
    required this.updated_at,
    required this.created_at,
    required this.id,
  });

  Group copyWith({
    String? user_id,
    String? group_name,
    String? goal,
    int? active_members,
    String? max_group_members,
    String? location,
    String? comments,
    double? radius,
    String? group_image,
    String? updated_at,
    String? created_at,
    int? id,
  }) {
    return Group(
      user_id: user_id ?? this.user_id,
      group_name: group_name ?? this.group_name,
      goal: goal ?? this.goal,
      active_members: active_members ?? this.active_members,
      max_group_members: max_group_members ?? this.max_group_members,
      location: location ?? this.location,
      comments: comments ?? this.comments,
      radius: radius ?? this.radius,
      group_image: group_image ?? this.group_image,
      updated_at: updated_at ?? this.updated_at,
      created_at: created_at ?? this.created_at,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'group_name': group_name,
      'goal': goal,
      'active_members': active_members,
      'max_group_members': max_group_members,
      'location': location,
      'comments': comments,
      'radius': radius,
      'group_image': group_image,
      'updated_at': updated_at,
      'created_at': created_at,
      'id': id,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      user_id: map['user_id'],
      group_name: map['group_name'],
      goal: map['goal'],
      active_members: map['active_members']?.toInt(),
      max_group_members: map['max_group_members'],
      location: map['location'],
      comments: map['comments'],
      radius: map['radius'],
      group_image: map['group_image'],
      updated_at: map['updated_at'],
      created_at: map['created_at'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Group(user_id: $user_id, group_name: $group_name, goal: $goal, active_members: $active_members, max_group_members: $max_group_members, location: $location, comments: $comments, radius: $radius, group_image: $group_image, updated_at: $updated_at, created_at: $created_at, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Group &&
        other.user_id == user_id &&
        other.group_name == group_name &&
        other.goal == goal &&
        other.active_members == active_members &&
        other.max_group_members == max_group_members &&
        other.location == location &&
        other.comments == comments &&
        other.radius == radius &&
        other.group_image == group_image &&
        other.updated_at == updated_at &&
        other.created_at == created_at &&
        other.id == id;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        group_name.hashCode ^
        goal.hashCode ^
        active_members.hashCode ^
        max_group_members.hashCode ^
        location.hashCode ^
        comments.hashCode ^
        radius.hashCode ^
        group_image.hashCode ^
        updated_at.hashCode ^
        created_at.hashCode ^
        id.hashCode;
  }
}

class double {}

class User {
  final int id;
  final String user_name;
  final String? id_proof;
  final String email;
  final String password;
  final String profile_picture;
  final String? personal_goal;
  final String? height;
  final String? weight;
  final String? gender;
  final String? date_of_birth;
  final int? goal_id;
  final String? goal_description;
  final int status;
  final String created_at;
  final String updated_at;
  final int? group_count;
  final String? number;
  User({
    required this.id,
    required this.user_name,
    this.id_proof,
    required this.email,
    required this.password,
    required this.profile_picture,
    this.personal_goal,
    this.height,
    this.weight,
    this.gender,
    this.date_of_birth,
    this.goal_id,
    this.goal_description,
    required this.status,
    required this.created_at,
    required this.updated_at,
    this.group_count,
    this.number,
  });

  User copyWith({
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
    int? group_count,
    String? number,
  }) {
    return User(
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
      group_count: group_count ?? this.group_count,
      number: number ?? this.number,
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
      'group_count': group_count,
      'number': number,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      user_name: map['user_name'],
      id_proof: map['id_proof'],
      email: map['email'],
      password: map['password'],
      profile_picture: map['profile_picture'],
      personal_goal: map['personal_goal'],
      height: map['height'],
      weight: map['weight'],
      gender: map['gender'],
      date_of_birth: map['date_of_birth'],
      goal_id: map['goal_id']?.toInt(),
      goal_description: map['goal_description'],
      status: map['status']?.toInt(),
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      group_count: map['group_count']?.toInt(),
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, user_name: $user_name, id_proof: $id_proof, email: $email, password: $password, profile_picture: $profile_picture, personal_goal: $personal_goal, height: $height, weight: $weight, gender: $gender, date_of_birth: $date_of_birth, goal_id: $goal_id, goal_description: $goal_description, status: $status, created_at: $created_at, updated_at: $updated_at, group_count: $group_count, number: $number)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
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
        other.group_count == group_count &&
        other.number == number;
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
        group_count.hashCode ^
        number.hashCode;
  }
}
