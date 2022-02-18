import 'package:fitness_99/models/createGroupResponseRequest/create_group_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pending_invitation_model.g.dart';

@JsonSerializable()
class PendingInvitationModel {
  PendingInvitationModel({
    this.group,
    this.userName,
  });

  final Group? group;
  @JsonKey(name: 'user_name')
  final String? userName;

  factory PendingInvitationModel.fromJson(Map<String, dynamic> json) {
    return _$PendingInvitationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PendingInvitationModelToJson(this);
}
