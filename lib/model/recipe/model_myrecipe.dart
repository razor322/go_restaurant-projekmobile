// To parse this JSON data, do
//
//     final modelMyRecipe = modelMyRecipeFromJson(jsonString);

import 'dart:convert';

ModelMyRecipe modelMyRecipeFromJson(String str) =>
    ModelMyRecipe.fromJson(json.decode(str));

String modelMyRecipeToJson(ModelMyRecipe data) => json.encode(data.toJson());

class ModelMyRecipe {
  int value;
  String message;
  List<MyRecipe> recipes;

  ModelMyRecipe({
    required this.value,
    required this.message,
    required this.recipes,
  });

  factory ModelMyRecipe.fromJson(Map<String, dynamic> json) => ModelMyRecipe(
        value: json["value"],
        message: json["message"],
        recipes: List<MyRecipe>.from(
            json["recipes"].map((x) => MyRecipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
      };
}

class MyRecipe {
  String idRecipe;
  String idUser;
  String username;
  String recipeName;
  String image;
  String ingredient;
  DateTime createdAt;
  DateTime updatedAt;

  MyRecipe({
    required this.idRecipe,
    required this.idUser,
    required this.username,
    required this.recipeName,
    required this.image,
    required this.ingredient,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyRecipe.fromJson(Map<String, dynamic> json) => MyRecipe(
        idRecipe: json["id_recipe"],
        idUser: json["id_user"],
        username: json["username"],
        recipeName: json["recipe_name"],
        image: json["image"],
        ingredient: json["ingredient"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_recipe": idRecipe,
        "id_user": idUser,
        "username": username,
        "recipe_name": recipeName,
        "image": image,
        "ingredient": ingredient,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
