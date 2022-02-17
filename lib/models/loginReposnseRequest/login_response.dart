import 'dart:convert';

class LoginResponse {
  final User user;
  final int pending_invitation;
  LoginResponse({
    required this.user,
    required this.pending_invitation,
  });

  LoginResponse copyWith({
    User? user,
    int? pending_invitation,
  }) {
    return LoginResponse(
      user: user ?? this.user,
      pending_invitation: pending_invitation ?? this.pending_invitation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'pending_invitation': pending_invitation,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      user: User.fromMap(map['user']),
      pending_invitation: map['pending_invitation']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(Map<String, dynamic> source) =>
      LoginResponse.fromMap(source);

  @override
  String toString() =>
      'LoginResponse(user: $user, pending_invitation: $pending_invitation)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResponse &&
        other.user == user &&
        other.pending_invitation == pending_invitation;
  }

  @override
  int get hashCode => user.hashCode ^ pending_invitation.hashCode;
}

class User {
  final int id;
  final String user_name;
  final String? id_proof;
  final String email;
  final String password;
  final String? profile_picture;
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
  final int group_count;
  final String? number;
  User({
    required this.id,
    required this.user_name,
    this.id_proof,
    required this.email,
    required this.password,
    this.profile_picture,
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
    required this.group_count,
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
      group_count: map['group_count']?.toInt() ?? 0,
      number: map['number'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> source) => User.fromMap(source);

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
