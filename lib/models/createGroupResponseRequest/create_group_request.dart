import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_group_request.g.dart';

@JsonSerializable()
class CreateGroupRequest extends Equatable {
  @JsonKey(name: 'group_name')
  final String? groupName;
  @JsonKey(name: 'goal')
  final String? goal;
  @JsonKey(name: 'max_group_members')
  final String? maxGroupMembers;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'group_image')
  final dynamic group_image;
  @JsonKey(name: 'comments')
  final String? comments;

  const CreateGroupRequest(
      {this.groupName,
      this.goal,
      this.maxGroupMembers,
      this.location,
      this.group_image,
      this.comments});

  factory CreateGroupRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateGroupRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateGroupRequestToJson(this);

  CreateGroupRequest copyWith({
    String? groupName,
    String? goal,
    String? maxGroupMembers,
    String? location,
    dynamic group_image,
    String? comments,
  }) {
    return CreateGroupRequest(
      groupName: groupName ?? this.groupName,
      goal: goal ?? this.goal,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [groupName, goal];
}
