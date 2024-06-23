// To parse this JSON data, do
//
//     final modelMassage = modelMassageFromJson(jsonString);

import 'dart:convert';

ModelMassage modelMassageFromJson(String str) =>
    ModelMassage.fromJson(json.decode(str));

String modelMassageToJson(ModelMassage data) => json.encode(data.toJson());

class ModelMassage {
  int value;
  String message;

  ModelMassage({
    required this.value,
    required this.message,
  });

  factory ModelMassage.fromJson(Map<String, dynamic> json) => ModelMassage(
        value: json["value"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
      };
}
