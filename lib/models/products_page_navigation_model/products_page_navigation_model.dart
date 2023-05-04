import 'dart:convert';

import 'package:elnasser/models/home_model/atributes.dart';
import 'package:elnasser/models/home_model/offers.dart';
import 'package:elnasser/models/home_model/product_class.dart';

ResultDataModel newArrivalFromJson(String str) =>
    ResultDataModel.fromJson(json.decode(str));

String newArrivalToJson(ResultDataModel data) => json.encode(data.toJson());

class ResultDataModel {
  ResultDataModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory ResultDataModel.fromJson(Map<String, dynamic> json) =>
      ResultDataModel(
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
    this.products,
    this.pagination,
    this.min,
    this.max,
    this.attributes,
    this.choices,
    this.offers,
  });

  List<ProductClass>? products;
  Pagination? pagination;
  String? min;
  String? max;
  List<Attribute>? attributes;
  List<Choice>? choices;
  List<Offer>? offers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<ProductClass>.from(
            json["products"].map((x) => ProductClass.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        min: json["min"],
        max: json["max"],
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "pagination": pagination!.toJson(),
        "min": min,
        "max": max,
        "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "choices": List<dynamic>.from(choices!.map((x) => x.toJson())),
        "offers": List<dynamic>.from(offers!.map((x) => x.toJson())),
      };
}

class Pagination {
  Pagination({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
