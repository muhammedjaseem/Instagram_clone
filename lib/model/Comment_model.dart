// To parse this JSON data, do
//
//     final comentModel = comentModelFromJson(jsonString);

import 'dart:convert';

List<ComentModel> comentModelFromJson(String str) => List<ComentModel>.from(json.decode(str).map((x) => ComentModel.fromJson(x)));

String comentModelToJson(List<ComentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComentModel {
  ComentModel({
    this.username,
    this.comments,
  });

   var username;
   var comments;

  factory ComentModel.fromJson(Map<String, dynamic> json) => ComentModel(
    username: json["username"],
    comments: json["comments"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "comments": comments,
  };
}
