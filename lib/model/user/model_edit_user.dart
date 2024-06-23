// To parse this JSON data, do
//
//     final modelEditProfile = modelEditProfileFromJson(jsonString);

import 'dart:convert';

ModelEditProfile modelEditProfileFromJson(String str) =>
    ModelEditProfile.fromJson(json.decode(str));

String modelEditProfileToJson(ModelEditProfile data) =>
    json.encode(data.toJson());

class ModelEditProfile {
  int value;
  String message;
  String email;
  String username;
  String id;
  DateTime updatedAt;

  ModelEditProfile({
    required this.value,
    required this.message,
    required this.email,
    required this.username,
    required this.id,
    required this.updatedAt,
  });

  factory ModelEditProfile.fromJson(Map<String, dynamic> json) =>
      ModelEditProfile(
        value: json["value"],
        message: json["message"],
        email: json["email"],
        username: json["username"],
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "email": email,
        "username": username,
        "id": id,
        "updated_at": updatedAt.toIso8601String(),
      };
}
