// To parse this JSON data, do
//
//     final modelSucces = modelSuccesFromJson(jsonString);

import 'dart:convert';

ModelSucces modelSuccesFromJson(String str) =>
    ModelSucces.fromJson(json.decode(str));

String modelSuccesToJson(ModelSucces data) => json.encode(data.toJson());

class ModelSucces {
  String status;
  String message;

  ModelSucces({
    required this.status,
    required this.message,
  });

  factory ModelSucces.fromJson(Map<String, dynamic> json) => ModelSucces(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
