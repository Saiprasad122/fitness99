import 'package:freezed_annotation/freezed_annotation.dart';
part 'cando_cannotdo_goal.response.freezed.dart';
part 'cando_cannotdo_goal.response.g.dart';

@freezed
class GetCanDoCannotDoGoals with _$GetCanDoCannotDoGoals {
  const GetCanDoCannotDoGoals._();
  const factory GetCanDoCannotDoGoals(
          {required int id,
          @JsonKey(name: 'user_id') required int userId,
          @JsonKey(name: 'text') required String content,
          @JsonKey(name: 'created_at') DateTime? createdAt,
          @JsonKey(name: 'updated_at') DateTime? updatedAt}) =
      _GetCanDoCannotDoGoals;

  factory GetCanDoCannotDoGoals.fromJson(Map<String, dynamic> json) =>
      _$GetCanDoCannotDoGoalsFromJson(json);

  Map<String, dynamic> toJson() {
    return toJson();
  }
}
