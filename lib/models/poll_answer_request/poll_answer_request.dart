import 'package:json_annotation/json_annotation.dart';

part 'poll_answer_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PollAnswerRequest {
  PollAnswerRequest({
    required this.pollId,
    required this.userId,
    required this.answer,
    required this.firebaseId,
  });
  @JsonKey(name: 'poll_id')
  int pollId;
  @JsonKey(name: 'user_id')
  int userId;

  int answer;

  @JsonKey(name: 'firebase_id')
  String firebaseId;

  PollAnswerRequest copyWith({
    int? pollId,
    int? userId,
    int? answer,
    String? firebaseId,
  }) =>
      PollAnswerRequest(
        pollId: pollId ?? this.pollId,
        userId: userId ?? this.userId,
        answer: answer ?? this.answer,
        firebaseId: firebaseId ?? this.firebaseId,
      );

  factory PollAnswerRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PollAnswerRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PollAnswerRequestToJson(this);
}
