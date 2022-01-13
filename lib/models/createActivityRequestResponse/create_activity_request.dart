import 'package:json_annotation/json_annotation.dart';
part 'create_activity_request.g.dart';

@JsonSerializable()
class CreateActivityRequest {
  final String? title,
      description,
      location,
      note,
      day,
      from_time,
      to_time,
      user_id,
      group_id;

  CreateActivityRequest({
    required this.title,
    required this.description,
    required this.location,
    required this.note,
    required this.day,
    required this.from_time,
    required this.to_time,
    required this.group_id,
    required this.user_id,
  });

  factory CreateActivityRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateActivityRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateActivityRequestToJson(this);
}
