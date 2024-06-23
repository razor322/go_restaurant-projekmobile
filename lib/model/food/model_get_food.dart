// To parse this JSON data, do
//
//     final modelGetFood = modelGetFoodFromJson(jsonString);

import 'dart:convert';

ModelGetFood modelGetFoodFromJson(String str) =>
    ModelGetFood.fromJson(json.decode(str));

String modelGetFoodToJson(ModelGetFood data) => json.encode(data.toJson());

class ModelGetFood {
  int value;
  String message;
  List<Food> foods;

  ModelGetFood({
    required this.value,
    required this.message,
    required this.foods,
  });

  factory ModelGetFood.fromJson(Map<String, dynamic> json) => ModelGetFood(
        value: json["value"],
        message: json["message"],
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
      };
}

class Food {
  String idFood;
  String name;
  String description;
  String image;
  String idStore;
  String storeName;
  String location;
  DateTime createdAt;
  DateTime updatedAt;

  Food({
    required this.idFood,
    required this.name,
    required this.description,
    required this.image,
    required this.idStore,
    required this.storeName,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        idFood: json["id_food"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        idStore: json["id_store"],
        storeName: json["store_name"],
        location: json["location"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_food": idFood,
        "name": name,
        "description": description,
        "image": image,
        "id_store": idStore,
        "store_name": storeName,
        "location": location,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
