// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationResponseFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationResponseToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final int isRead;
  final int? expirationTime;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.isRead,
    this.expirationTime,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        isRead: json["is_read"],
        expirationTime: json["expiration_time"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "is_read": isRead,
    "expiration_time": expirationTime,
    "created_at": createdAt.toIso8601String(),
  };
}

enum NotificationPriority { normal, high }
