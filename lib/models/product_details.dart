import 'dart:convert';

import 'package:elnasser/models/home_model/product_class.dart';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
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
    this.product,
  });

  ProductClass? product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: ProductClass.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "product": product!.toJson(),
      };
}
