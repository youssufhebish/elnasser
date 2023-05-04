import 'dart:convert';

import 'package:elnasser/models/home_model/category.dart';

CategoriesModel categoryModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoryModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        status: json["status"],
        message: json["message"],
        errors: json["errors"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.categories,
  });

  List<CategoryClass>? categories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: List<CategoryClass>.from(
            json["categories"].map((x) => CategoryClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}
