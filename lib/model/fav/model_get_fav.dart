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
  String image;
  String foodDescription;
  String storeName;
  String location;
  DateTime createdAt;
  DateTime updatedAt;

  Favorite({
    required this.idFavorite,
    required this.idUser,
    required this.username,
    required this.idFood,
    required this.foodName,
    required this.image,
    required this.foodDescription,
    required this.storeName,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        idFavorite: json["id_favorite"],
        idUser: json["id_user"],
        username: json["username"],
        idFood: json["id_food"],
        foodName: json["food_name"],
        image: json["image"],
        foodDescription: json["food_description"],
        storeName: json["store_name"],
        location: json["location"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_favorite": idFavorite,
        "id_user": idUser,
        "username": username,
        "id_food": idFood,
        "food_name": foodName,
        "image": image,
        "food_description": foodDescription,
        "store_name": storeName,
        "location": location,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
