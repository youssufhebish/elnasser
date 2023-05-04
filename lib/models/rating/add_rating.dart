// To parse this JSON data, do
//
//     final rEgisterModel = rEgisterModelFromJson(jsonString);

import 'dart:convert';

AddRatingModel AddRatingModelFromJson(String str) =>
    AddRatingModel.fromJson(json.decode(str));

String AddRatingModelToJson(AddRatingModel data) => json.encode(data.toJson());

class AddRatingModel {
  AddRatingModel(
      {this.accountId,
      this.products_id,
      this.ratings_quality,
      this.ratings_price,
      this.ratings_size,
      this.ratings_match_picture,
      this.ratings_text});
  String? accountId;
  String? products_id;
  double? ratings_quality;
  double? ratings_price;
  double? ratings_size;
  double? ratings_match_picture;
  String? ratings_text;

  factory AddRatingModel.fromJson(Map<String, dynamic> json) => AddRatingModel(
        accountId: json["accountId"],
        products_id: json["products_id"],
        ratings_quality: json["ratings_quality"],
        ratings_price: json["ratings_price"],
        ratings_size: json["ratings_size"],
        ratings_match_picture: json["ratings_match_picture"],
        ratings_text: json["ratings_text"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "products_id": products_id,
        "ratings_quality": ratings_quality,
        "ratings_price": ratings_price,
        "ratings_size": ratings_size,
        "ratings_match_picture": ratings_match_picture,
        "ratings_text": ratings_text,
      };
}
