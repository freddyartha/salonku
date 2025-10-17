// To parse this JSON data, do
//
//     final loginUserModel = loginUserModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

AuthModel loginUserModelFromJson(String str) =>
    AuthModel.fromJson(json.decode(str));

String loginUserModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String accessToken;
  String fingerprint;
  UserModel user;

  AuthModel({
    required this.accessToken,
    required this.fingerprint,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    accessToken: json["access_token"],
    fingerprint: json["fingerprint"],
    user: UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "fingerprint": fingerprint,
    "user": user.toJson(),
  };
}
