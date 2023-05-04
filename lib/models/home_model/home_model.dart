import 'dart:convert';

import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/models/order_model/order_model_detail.dart';

import 'advertisement.dart';
import 'brand.dart';
import 'category.dart';
import 'partenr.dart';
import 'product_class.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data(
      {this.homeProducts,
      this.categories,
      this.bestSales,
      this.discountProducts,
      this.dailyOfferProducts,
      this.lastArrivedProducts,
      this.advertisements,
      this.brands,
      this.partners,
      this.order,
      this.orderRating});

  List<ProductClass>? homeProducts;
  List<CategoryClass>? categories;
  List<ProductClass>? bestSales;
  List<ProductClass>? discountProducts;
  List<ProductClass>? dailyOfferProducts;
  List<ProductClass>? lastArrivedProducts;
  Advertisements? advertisements;
  List<BrandModel>? brands;
  List<Partner>? partners;
  Order? order;
  int? orderRating;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        homeProducts: List<ProductClass>.from(
            json["homeProducts"].map((x) => ProductClass.fromJson(x))),
        categories: List<CategoryClass>.from(
            json["categories"].map((x) => CategoryClass.fromJson(x))),
        bestSales: List<ProductClass>.from(
            json["bestSales"].map((x) => ProductClass.fromJson(x))),
        discountProducts: List<ProductClass>.from(
            json["discountProducts"].map((x) => ProductClass.fromJson(x))),
        dailyOfferProducts: List<ProductClass>.from(
            json["dailyOfferProducts"].map((x) => ProductClass.fromJson(x))),
        lastArrivedProducts: List<ProductClass>.from(
            json["lastArrivedProducts"].map((x) => ProductClass.fromJson(x))),
        advertisements: Advertisements.fromJson(json["advertisements"]),
        brands: List<BrandModel>.from(
            json["brands"].map((x) => BrandModel.fromJson(x))),
        partners: List<Partner>.from(
            json["partners"].map((x) => Partner.fromJson(x))),
        orderRating: json["order_rating"] == null ? null : json["order_rating"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "homeProducts":
            List<dynamic>.from(homeProducts!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "bestSales": List<dynamic>.from(bestSales!.map((x) => x.toJson())),
        "discountProducts":
            List<dynamic>.from(discountProducts!.map((x) => x.toJson())),
        "dailyOfferProducts":
            List<dynamic>.from(dailyOfferProducts!.map((x) => x.toJson())),
        "lastArrivedProducts":
            List<dynamic>.from(lastArrivedProducts!.map((x) => x.toJson())),
        "advertisements": advertisements!.toJson(),
        "brands": List<dynamic>.from(brands!.map((x) => x.toJson())),
        "partners": List<dynamic>.from(partners!.map((x) => x.toJson())),
        "order_rating": orderRating == null ? null : orderRating,
        "order": order == null ? null : order!.toJson(),
      };
}
