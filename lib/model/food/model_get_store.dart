// To parse this JSON data, do
//
//     final modelGetStore = modelGetStoreFromJson(jsonString);

import 'dart:convert';

ModelGetStore modelGetStoreFromJson(String str) =>
    ModelGetStore.fromJson(json.decode(str));

String modelGetStoreToJson(ModelGetStore data) => json.encode(data.toJson());

class ModelGetStore {
  int value;
  String message;
  List<Store> stores;

  ModelGetStore({
    required this.value,
    required this.message,
    required this.stores,
  });

  factory ModelGetStore.fromJson(Map<String, dynamic> json) => ModelGetStore(
        value: json["value"],
        message: json["message"],
        stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class Store {
  String storeId;
  String storeName;
  String location;
  DateTime createdAt;
  DateTime updatedAt;
  List<Food> foods;

  Store({
    required this.storeId,
    required this.storeName,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.foods,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeId: json["store_id"],
        storeName: json["store_name"],
        location: json["location"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "store_name": storeName,
        "location": location,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
      };
}

class Food {
  String idFood;
  String name;
  String description;
  String image;

  Food({
    required this.idFood,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        idFood: json["id_food"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id_food": idFood,
        "name": name,
        "description": description,
        "image": image,
      };
}
