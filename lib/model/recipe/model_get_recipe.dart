// To parse this JSON data, do
//
//     final modelGetRecipe = modelGetRecipeFromJson(jsonString);

import 'dart:convert';

ModelGetRecipe modelGetRecipeFromJson(String str) =>
    ModelGetRecipe.fromJson(json.decode(str));

String modelGetRecipeToJson(ModelGetRecipe data) => json.encode(data.toJson());

class ModelGetRecipe {
  int value;
  String message;
  List<Recipe> recipes;

  ModelGetRecipe({
    required this.value,
    required this.message,
    required this.recipes,
  });

  factory ModelGetRecipe.fromJson(Map<String, dynamic> json) => ModelGetRecipe(
        value: json["value"],
        message: json["message"],
        recipes:
            List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
      };
}

class Recipe {
  String idRecipe;
  String idUser;
  String recipeName;
  String ingredient;
  DateTime createdAt;
  DateTime updatedAt;

  Recipe({
    required this.idRecipe,
    required this.idUser,
    required this.recipeName,
    required this.ingredient,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        idRecipe: json["id_recipe"],
        idUser: json["id_user"],
        recipeName: json["recipe_name"],
        ingredient: json["ingredient"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_recipe": idRecipe,
        "id_user": idUser,
        "recipe_name": recipeName,
        "ingredient": ingredient,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
