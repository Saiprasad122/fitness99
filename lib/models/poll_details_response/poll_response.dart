import 'package:json_annotation/json_annotation.dart';
part 'poll_response.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class Poll {
  Poll({
    required this.id,
    required this.pollQuestion,
    required this.userId,
    required this.option1,
    required this.option2,
    required this.maxMember,
    required this.updatedAt,
    required this.createdAt,
    required this.expire,
    required this.groupId,
    required this.firebaseId,
    this.option3 = '',
    this.option4 = '',
  });

  int id;
  @JsonKey(name: 'poll_question')
  String pollQuestion;
  @JsonKey(name: 'user_id')
  int userId;

  String option1;
  String option2;
  @JsonKey(name: 'max_member')
  int maxMember;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  int expire;
  @JsonKey(name: 'group_id')
  int groupId;
  @JsonKey(name: 'firebase_id')
  String firebaseId;
  @JsonKey(defaultValue: '')
  String option3;
  @JsonKey(defaultValue: '')
  String option4;

  Poll copyWith({
    int? id,
    String? pollQuestion,
    int? userId,
    String? option1,
    String? option2,
    int? maxMember,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? expire,
    int? groupId,
    String? firebaseId,
    String? option3,
    String? option4,
  }) =>
      Poll(
        id: id ?? this.id,
        pollQuestion: pollQuestion ?? this.pollQuestion,
        userId: userId ?? this.userId,
        option1: option1 ?? this.option1,
        option2: option2 ?? this.option2,
        maxMember: maxMember ?? this.maxMember,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        expire: expire ?? this.expire,
        groupId: groupId ?? this.groupId,
        firebaseId: firebaseId ?? this.firebaseId,
        option3: option3 ?? this.option3,
        option4: option4 ?? this.option4,
      );

  factory Poll.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PollFromJson(json);
  Map<String, dynamic> toJson() => _$PollToJson(this);
}
