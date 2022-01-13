// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel(
      {required this.messageType,
      required this.imageURl,
      required this.id,
      required this.message,
      required this.dateTime,
      required this.extension});

  final String messageType;
  final String imageURl;
  final String id;
  final String message;
  final DateTime dateTime;
  final String extension;

  MessageModel copyWith({
    String? messageType,
    String? imageURl,
    String? id,
    String? message,
    DateTime? dateTime,
    String? extension,
  }) =>
      MessageModel(
        messageType: messageType ?? this.messageType,
        imageURl: imageURl ?? this.imageURl,
        id: id ?? this.id,
        message: message ?? this.message,
        dateTime: dateTime ?? this.dateTime,
        extension: extension ?? this.extension,
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageType: json["messageType"],
        imageURl: json["imageURl"],
        id: json["id"],
        message: json["message"],
        dateTime: json["time"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "imageURl": imageURl,
        "id": id,
        "message": message,
        "time": dateTime,
        "extension": extension,
      };
}
