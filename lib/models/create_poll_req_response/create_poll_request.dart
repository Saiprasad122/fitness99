import 'package:json_annotation/json_annotation.dart';
part 'create_poll_request.g.dart';

@JsonSerializable()
class CreatePollRequest {
  String poll_question,
      user_id,
      group_id,
      option1,
      option2,
      option3,
      option4,
      firebase_id;

  CreatePollRequest({
    required this.poll_question,
    required this.user_id,
    required this.group_id,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.firebase_id,
  });

  factory CreatePollRequest.fromJson(Map<String, dynamic> data) =>
      _$CreatePollRequestFromJson(data);

  Map<String, dynamic> toJson() => _$CreatePollRequestToJson(this);
}
