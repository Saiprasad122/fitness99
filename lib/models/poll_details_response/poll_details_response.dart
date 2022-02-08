import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:fitness_99/models/poll_details_response/poll_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'poll_details_response.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class PollDetailsResponse {
  PollDetailsResponse({
    required this.poll,
    this.hasAnswered,
    this.option1 = const [],
    this.option2 = const [],
    this.option3 = const [],
    this.option4 = const [],
  });

  Poll poll;
  int? hasAnswered;
  List<User> option1;
  List<User> option2;
  List<User> option3;
  List<User> option4;

  PollDetailsResponse copyWith({
    Poll? poll,
    int? hasAnswered,
    List<User>? option1,
    List<User>? option2,
    List<User>? option3,
    List<User>? option4,
  }) =>
      PollDetailsResponse(
        poll: poll ?? this.poll,
        hasAnswered: hasAnswered ?? this.hasAnswered,
        option1: option1 ?? this.option1,
        option2: option2 ?? this.option2,
        option3: option3 ?? this.option3,
        option4: option4 ?? this.option4,
      );

  factory PollDetailsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PollDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PollDetailsResponseToJson(this);
}
