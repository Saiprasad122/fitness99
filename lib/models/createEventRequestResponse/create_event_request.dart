import 'package:json_annotation/json_annotation.dart';
part 'create_event_request.g.dart';

@JsonSerializable()
class CreateEventRequest {
  final String? title,
      description,
      location,
      members,
      date,
      time,
      user_id,
      group_id;

  CreateEventRequest({
    required this.title,
    required this.description,
    required this.location,
    required this.members,
    required this.date,
    required this.time,
    required this.user_id,
    required this.group_id,
  });

  factory CreateEventRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateEventRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateEventRequestToJson(this);
}
