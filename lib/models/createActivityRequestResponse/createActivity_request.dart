import 'package:json_annotation/json_annotation.dart';
part 'createActivity_request.g.dart';

@JsonSerializable()
class CreateActivityRequest {
  final String? title,
      description,
      location,
      notes,
      day,
      fromTime,
      toTime,
      user_id,
      group_id;

  CreateActivityRequest({
    required this.title,
    required this.description,
    required this.location,
    required this.notes,
    required this.day,
    required this.fromTime,
    required this.toTime,
    required this.group_id,
    required this.user_id,
  });

  factory CreateActivityRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateActivityRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateActivityRequestToJson(this);
}
