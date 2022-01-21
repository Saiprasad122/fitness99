import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add_preferences_request.g.dart';

@JsonSerializable()
class AddPreferencesRequest {
  final String day, user_id, from_time, to_time;

  AddPreferencesRequest({
    required this.day,
    required this.user_id,
    required this.from_time,
    required this.to_time,
  });

  factory AddPreferencesRequest.fromJson(Map<String, dynamic> json) {
    return _$AddPreferencesRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddPreferencesRequestToJson(this);
}
