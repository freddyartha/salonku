// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String phoneNumber;
  String name;
  String? address;
  String? nik;
  String? avatarUrl;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.address,
    required this.nik,
    required this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    phoneNumber: json["phone_number"],
    name: json["name"],
    address: json["address"],
    nik: json["nik"],
    avatarUrl: json["avatar_url"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone_number": phoneNumber,
    "name": name,
    "address": address,
    "nik": nik,
    "avatar_url": avatarUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
