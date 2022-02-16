import 'package:json_annotation/json_annotation.dart';
part 'add_group_categories_request.g.dart';

@JsonSerializable()
class AddGroupCategoriesRequest {
  String categories, group_id;

  AddGroupCategoriesRequest({
    required this.categories,
    required this.group_id,
  });

  factory AddGroupCategoriesRequest.fromJson(Map<String, dynamic> data) =>
      _$AddGroupCategoriesRequestFromJson(data);

  Map<String, dynamic> toJson() => _$AddGroupCategoriesRequestToJson(this);
}
