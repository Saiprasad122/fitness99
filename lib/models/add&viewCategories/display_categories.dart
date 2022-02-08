import 'dart:convert';

class DisplayCategoriesResponse {
  final int id;
  final String categories;
  final String created_at;
  final int user_id;
  final String updated_at;
  DisplayCategoriesResponse({
    required this.id,
    required this.categories,
    required this.created_at,
    required this.user_id,
    required this.updated_at,
  });

  DisplayCategoriesResponse copyWith({
    int? id,
    String? categories,
    String? created_at,
    int? user_id,
    String? updated_at,
  }) {
    return DisplayCategoriesResponse(
      id: id ?? this.id,
      categories: categories ?? this.categories,
      created_at: created_at ?? this.created_at,
      user_id: user_id ?? this.user_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categories': categories,
      'created_at': created_at,
      'user_id': user_id,
      'updated_at': updated_at,
    };
  }

  factory DisplayCategoriesResponse.fromMap(Map<String, dynamic> map) {
    return DisplayCategoriesResponse(
      id: map['id']?.toInt() ?? 0,
      categories: map['categories'] ?? '',
      created_at: map['created_at'] ?? '',
      user_id: map['user_id']?.toInt() ?? 0,
      updated_at: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayCategoriesResponse.fromJson(Map<String, dynamic> source) =>
      DisplayCategoriesResponse.fromMap(source);

  @override
  String toString() {
    return 'DisplayCategoriesResponse(id: $id, categories: $categories, created_at: $created_at, user_id: $user_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisplayCategoriesResponse &&
        other.id == id &&
        other.categories == categories &&
        other.created_at == created_at &&
        other.user_id == user_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categories.hashCode ^
        created_at.hashCode ^
        user_id.hashCode ^
        updated_at.hashCode;
  }
}
