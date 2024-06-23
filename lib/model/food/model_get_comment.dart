// To parse this JSON data, do
//
//     final modelGetComment = modelGetCommentFromJson(jsonString);

import 'dart:convert';

ModelGetComment modelGetCommentFromJson(String str) =>
    ModelGetComment.fromJson(json.decode(str));

String modelGetCommentToJson(ModelGetComment data) =>
    json.encode(data.toJson());

class ModelGetComment {
  int value;
  String message;
  List<Comment> comments;

  ModelGetComment({
    required this.value,
    required this.message,
    required this.comments,
  });

  factory ModelGetComment.fromJson(Map<String, dynamic> json) =>
      ModelGetComment(
        value: json["value"],
        message: json["message"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  int idComment;
  int idUser;
  String username;
  int idFood;
  String foodName;
  String content;
  DateTime commentDate;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    required this.idComment,
    required this.idUser,
    required this.username,
    required this.idFood,
    required this.foodName,
    required this.content,
    required this.commentDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        idComment: json["id_comment"],
        idUser: json["id_user"],
        username: json["username"],
        idFood: json["id_food"],
        foodName: json["food_name"],
        content: json["content"],
        commentDate: DateTime.parse(json["comment_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_comment": idComment,
        "id_user": idUser,
        "username": username,
        "id_food": idFood,
        "food_name": foodName,
        "content": content,
        "comment_date": commentDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
