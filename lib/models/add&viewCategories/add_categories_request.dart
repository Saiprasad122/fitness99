import 'package:json_annotation/json_annotation.dart';
part 'add_categories_request.g.dart';

@JsonSerializable()
class AddCategoriesRequest {
  String categories, user_id;

  AddCategoriesRequest({
    required this.categories,
    required this.user_id,
  });

  factory AddCategoriesRequest.fromJson(Map<String, dynamic> data) =>
      _$AddCategoriesRequestFromJson(data);

  Map<String, dynamic> toJson() => _$AddCategoriesRequestToJson(this);
}
