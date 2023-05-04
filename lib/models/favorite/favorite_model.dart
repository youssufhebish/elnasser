import 'dart:convert';

import 'package:elnasser/models/home_model/atributes.dart';
import 'package:elnasser/models/home_model/category.dart';
import 'package:elnasser/models/home_model/offers.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/home_model/product_images_list.dart';

FavoriteModelClass favoriteModelFromJson(String str) =>
    FavoriteModelClass.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModelClass data) =>
    json.encode(data.toJson());

class FavoriteModelClass {
  FavoriteModelClass({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory FavoriteModelClass.fromJson(Map<String, dynamic> json) =>
      FavoriteModelClass(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        errors: json["errors"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "errors": errors,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.favs,
  });

  List<ProductClass>? favs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        favs: json["favs"] == null
            ? null
            : List<ProductClass>.from(
                json["favs"].map((x) => ProductClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "favs": favs == null
            ? null
            : List<dynamic>.from(favs!.map((x) => x.toJson())),
      };
}
