import 'package:json_annotation/json_annotation.dart';
part 'send_request_from_my_group_request.g.dart';

@JsonSerializable()
class SendReqFromMyGroupRequest {
  String group_id, user_id;

  SendReqFromMyGroupRequest({
    required this.group_id,
    required this.user_id,
  });

  factory SendReqFromMyGroupRequest.fromJson(Map<String, dynamic> data) =>
      _$SendReqFromMyGroupRequestFromJson(data);

  Map<String, dynamic> toJson() => _$SendReqFromMyGroupRequestToJson(this);
}
