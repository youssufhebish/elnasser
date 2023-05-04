import 'dart:convert';

import 'package:elnasser/models/home_model/category.dart';
import 'package:elnasser/models/home_model/offers.dart';

FilterModel filterModelFromJson(String str) =>
    FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
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
    this.categories,
    this.attributes,
    this.offers,
    this.choices,
    this.brands,
  });

  List<CategoryClass>? categories;
  List<Attribute>? attributes;
  List<Offer>? offers;
  List<Choice>? choices;
  List<Brand>? brands;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null
            ? null
            : List<CategoryClass>.from(
                json["categories"].map((x) => CategoryClass.fromJson(x))),
        attributes: json["attributes"] == null
            ? null
            : List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromJson(x))),
        offers: json["offers"] == null
            ? null
            : List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        choices: json["choices"] == null
            ? null
            : List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        brands: json["brands"] == null
            ? null
            : List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "offers": offers == null
            ? null
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
        "choices": choices == null
            ? null
            : List<dynamic>.from(choices!.map((x) => x.toJson())),
        "brands": brands == null
            ? null
            : List<dynamic>.from(brands!.map((x) => x.toJson())),
      };
}

class Attribute {
  Attribute({
    this.attributesId,
    this.fkAccountsId,
    this.attributesCode,
    this.attributesImage,
    this.attributesStatus,
    this.attributesCreatedAt,
    this.attributesUpdatedAt,
    this.trans,
  });

  int? attributesId;
  String? fkAccountsId;
  String? attributesCode;
  String? attributesImage;
  String? attributesStatus;
  DateTime? attributesCreatedAt;
  DateTime? attributesUpdatedAt;
  List<AttributeTran>? trans;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        attributesId:
            json["attributes_id"] == null ? null : json["attributes_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        attributesCode:
            json["attributes_code"] == null ? null : json["attributes_code"],
        attributesImage:
            json["attributes_image"] == null ? null : json["attributes_image"],
        attributesStatus: json["attributes_status"] == null
            ? null
            : json["attributes_status"],
        attributesCreatedAt: json["attributes_created_at"] == null
            ? null
            : DateTime.parse(json["attributes_created_at"]),
        attributesUpdatedAt: json["attributes_updated_at"] == null
            ? null
            : DateTime.parse(json["attributes_updated_at"]),
        trans: json["trans"] == null
            ? null
            : List<AttributeTran>.from(
                json["trans"].map((x) => AttributeTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributes_id": attributesId == null ? null : attributesId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "attributes_code": attributesCode == null ? null : attributesCode,
        "attributes_image": attributesImage == null ? null : attributesImage,
        "attributes_status": attributesStatus == null ? null : attributesStatus,
        "attributes_created_at": attributesCreatedAt == null
            ? null
            : attributesCreatedAt!.toIso8601String(),
        "attributes_updated_at": attributesUpdatedAt == null
            ? null
            : attributesUpdatedAt!.toIso8601String(),
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
      };
}

class AttributeTran {
  AttributeTran({
    this.attributesTransId,
    this.attributesId,
    this.locale,
    this.attributesTitle,
  });

  int? attributesTransId;
  String? attributesId;
  String? locale;
  String? attributesTitle;

  factory AttributeTran.fromJson(Map<String, dynamic> json) => AttributeTran(
        attributesTransId: json["attributes_trans_id"] == null
            ? null
            : json["attributes_trans_id"],
        attributesId:
            json["attributes_id"] == null ? null : json["attributes_id"],
        locale: json["locale"] == null ? null : json["locale"],
        attributesTitle:
            json["attributes_title"] == null ? null : json["attributes_title"],
      );

  Map<String, dynamic> toJson() => {
        "attributes_trans_id":
            attributesTransId == null ? null : attributesTransId,
        "attributes_id": attributesId == null ? null : attributesId,
        "locale": locale == null ? null : locale!,
        "attributes_title": attributesTitle == null ? null : attributesTitle,
      };
}

class Brand {
  Brand({
    this.brandsId,
    this.fkAccountsId,
    this.brandsCode,
    this.brandsHome,
    this.brandsStatus,
    this.brandsCreatedAt,
    this.brandsUpdatedAt,
    this.brandsName,
    this.brandsImg,
    this.translations,
  });

  int? brandsId;
  String? fkAccountsId;
  String? brandsCode;
  String? brandsHome;
  String? brandsStatus;
  DateTime? brandsCreatedAt;
  DateTime? brandsUpdatedAt;
  String? brandsName;
  String? brandsImg;
  List<Translation>? translations;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        brandsId: json["brands_id"] == null ? null : json["brands_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        brandsCode: json["brands_code"] == null ? null : json["brands_code"],
        brandsHome: json["brands_home"] == null ? null : json["brands_home"],
        brandsStatus:
            json["brands_status"] == null ? null : json["brands_status"],
        brandsCreatedAt: json["brands_created_at"] == null
            ? null
            : DateTime.parse(json["brands_created_at"]),
        brandsUpdatedAt: json["brands_updated_at"] == null
            ? null
            : DateTime.parse(json["brands_updated_at"]),
        brandsName: json["brands_name"] == null ? null : json["brands_name"],
        brandsImg: json["brands_img"] == null ? null : json["brands_img"],
        translations: json["translations"] == null
            ? null
            : List<Translation>.from(
                json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "brands_id": brandsId == null ? null : brandsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "brands_code": brandsCode == null ? null : brandsCode,
        "brands_home": brandsHome == null ? null : brandsHome,
        "brands_status": brandsStatus == null ? null : brandsStatus,
        "brands_created_at":
            brandsCreatedAt == null ? null : brandsCreatedAt!.toIso8601String(),
        "brands_updated_at":
            brandsUpdatedAt == null ? null : brandsUpdatedAt!.toIso8601String(),
        "brands_name": brandsName == null ? null : brandsName,
        "brands_img": brandsImg == null ? null : brandsImg,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    this.brandsTransId,
    this.brandsId,
    this.locale,
    this.brandsName,
    this.brandsImg,
  });

  int? brandsTransId;
  String? brandsId;
  String? locale;
  String? brandsName;
  String? brandsImg;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        brandsTransId:
            json["brands_trans_id"] == null ? null : json["brands_trans_id"],
        brandsId: json["brands_id"] == null ? null : json["brands_id"],
        locale: json["locale"] == null ? null : json["locale"],
        brandsName: json["brands_name"] == null ? null : json["brands_name"],
        brandsImg: json["brands_img"] == null ? null : json["brands_img"],
      );

  Map<String, dynamic> toJson() => {
        "brands_trans_id": brandsTransId == null ? null : brandsTransId,
        "brands_id": brandsId == null ? null : brandsId,
        "locale": locale == null ? null : locale!,
        "brands_name": brandsName == null ? null : brandsName,
        "brands_img": brandsImg == null ? null : brandsImg,
      };
}

class Choice {
  Choice({
    this.choicesId,
    this.fkAccountsId,
    this.choicesCode,
    this.choicesParentId,
    this.choicesStatus,
    this.choicesPosition,
    this.choicesCreatedAt,
    this.choicesUpdatedAt,
    this.lft,
    this.rgt,
    this.depth,
    this.trans,
    this.subchoices,
  });

  int? choicesId;
  String? fkAccountsId;
  String? choicesCode;
  String? choicesParentId;
  String? choicesStatus;
  String? choicesPosition;
  DateTime? choicesCreatedAt;
  DateTime? choicesUpdatedAt;
  String? lft;
  String? rgt;
  String? depth;
  List<ChoiceTran>? trans;
  List<Choice>? subchoices;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        choicesId: json["choices_id"] == null ? null : json["choices_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        choicesCode: json["choices_code"] == null ? null : json["choices_code"],
        choicesParentId: json["choices_parent_id"] == null
            ? null
            : json["choices_parent_id"],
        choicesStatus:
            json["choices_status"] == null ? null : json["choices_status"],
        choicesPosition:
            json["choices_position"] == null ? null : json["choices_position"],
        choicesCreatedAt: json["choices_created_at"] == null
            ? null
            : DateTime.parse(json["choices_created_at"]),
        choicesUpdatedAt: json["choices_updated_at"] == null
            ? null
            : DateTime.parse(json["choices_updated_at"]),
        lft: json["lft"] == null ? null : json["lft"],
        rgt: json["rgt"] == null ? null : json["rgt"],
        depth: json["depth"] == null ? null : json["depth"],
        trans: json["trans"] == null
            ? null
            : List<ChoiceTran>.from(
                json["trans"].map((x) => ChoiceTran.fromJson(x))),
        subchoices: json["subchoices"] == null
            ? null
            : List<Choice>.from(
                json["subchoices"].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "choices_id": choicesId == null ? null : choicesId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "choices_code": choicesCode == null ? null : choicesCode,
        "choices_parent_id": choicesParentId == null ? null : choicesParentId,
        "choices_status": choicesStatus == null ? null : choicesStatus,
        "choices_position": choicesPosition == null ? null : choicesPosition,
        "choices_created_at": choicesCreatedAt == null
            ? null
            : choicesCreatedAt!.toIso8601String(),
        "choices_updated_at": choicesUpdatedAt == null
            ? null
            : choicesUpdatedAt!.toIso8601String(),
        "lft": lft == null ? null : lft,
        "rgt": rgt == null ? null : rgt,
        "depth": depth == null ? null : depth,
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
        "subchoices": subchoices == null
            ? null
            : List<dynamic>.from(subchoices!.map((x) => x.toJson())),
      };
}

class ChoiceTran {
  ChoiceTran({
    this.choicesTransId,
    this.choicesId,
    this.locale,
    this.choicesTitle,
  });

  int? choicesTransId;
  String? choicesId;
  String? locale;
  String? choicesTitle;

  factory ChoiceTran.fromJson(Map<String, dynamic> json) => ChoiceTran(
        choicesTransId:
            json["choices_trans_id"] == null ? null : json["choices_trans_id"],
        choicesId: json["choices_id"] == null ? null : json["choices_id"],
        locale: json["locale"] == null ? null : json["locale"],
        choicesTitle:
            json["choices_title"] == null ? null : json["choices_title"],
      );

  Map<String, dynamic> toJson() => {
        "choices_trans_id": choicesTransId == null ? null : choicesTransId,
        "choices_id": choicesId == null ? null : choicesId,
        "locale": locale == null ? null : locale!,
        "choices_title": choicesTitle == null ? null : choicesTitle,
      };
}
