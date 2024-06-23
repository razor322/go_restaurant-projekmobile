// To parse this JSON data, do
//
//     final modelGetFav = modelGetFavFromJson(jsonString);

import 'dart:convert';

ModelGetFav modelGetFavFromJson(String str) =>
    ModelGetFav.fromJson(json.decode(str));

String modelGetFavToJson(ModelGetFav data) => json.encode(data.toJson());

class ModelGetFav {
  int value;
  String message;
  List<Favorite> favorites;

  ModelGetFav({
    required this.value,
    required this.message,
    required this.favorites,
  });

  factory ModelGetFav.fromJson(Map<String, dynamic> json) => ModelGetFav(
        value: json["value"],
        message: json["message"],
        favorites: List<Favorite>.from(
            json["favorites"].map((x) => Favorite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
      };
}

class Favorite {
  int idFavorite;
  int idUser;
  String username;
  int idFood;
  String foodName;
  String foodDescription;
  int idStore;
  int idCategory;
  DateTime createdAt;
  DateTime updatedAt;

  Favorite({
    required this.idFavorite,
    required this.idUser,
    required this.username,
    required this.idFood,
    required this.foodName,
    required this.foodDescription,
    required this.idStore,
    required this.idCategory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        idFavorite: json["id_favorite"],
        idUser: json["id_user"],
        username: json["username"],
        idFood: json["id_food"],
        foodName: json["food_name"],
        foodDescription: json["food_description"],
        idStore: json["id_store"],
        idCategory: json["id_category"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_favorite": idFavorite,
        "id_user": idUser,
        "username": username,
        "id_food": idFood,
        "food_name": foodName,
        "food_description": foodDescription,
        "id_store": idStore,
        "id_category": idCategory,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
