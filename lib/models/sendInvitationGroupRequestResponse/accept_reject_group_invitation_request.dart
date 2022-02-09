import 'package:json_annotation/json_annotation.dart';
part 'accept_reject_group_invitation_request.g.dart';

@JsonSerializable()
class AcceptRejectGroupInivitationRequest {
  String user_id, group_id, status;

  AcceptRejectGroupInivitationRequest({
    required this.user_id,
    required this.group_id,
    required this.status,
  });

  factory AcceptRejectGroupInivitationRequest.fromJson(
      Map<String, dynamic> json) {
    return _$AcceptRejectGroupInivitationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$AcceptRejectGroupInivitationRequestToJson(this);
}
