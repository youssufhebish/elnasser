import 'dart:convert';

BranchesModel branchesModelFromJson(String str) =>
    BranchesModel.fromJson(json.decode(str));

String branchesModelToJson(BranchesModel data) => json.encode(data.toJson());

class BranchesModel {
  BranchesModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory BranchesModel.fromJson(Map<String, dynamic> json) => BranchesModel(
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
    this.branches,
    this.cities,
  });

  List<Branch>? branches;
  List<CityModel>? cities;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        branches: json["branches"] == null
            ? null
            : List<Branch>.from(
                json["branches"].map((x) => Branch.fromJson(x))),
        cities: json["cities"] == null
            ? null
            : List<CityModel>.from(
                json["cities"].map((x) => CityModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branches": branches == null
            ? null
            : List<dynamic>.from(branches!.map((x) => x.toJson())),
        "cities": cities == null
            ? null
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.branchesId,
    this.fkAccountsId,
    this.fkCitiesId,
    this.branchesWhatsapp,
    this.branchesMobile,
    this.branchesGps,
    this.branchesStatus,
    this.branchesPosition,
    this.branchesCode,
    this.branchesCreatedAt,
    this.branchesUpdatedAt,
    this.branchesTitle,
    this.branchesAddress,
    this.branchesText,
    this.areas,
    this.translations,
  });

  int? branchesId;
  String? fkAccountsId;
  String? fkCitiesId;
  String? branchesWhatsapp;
  String? branchesMobile;
  String? branchesGps;
  String? branchesStatus;
  String? branchesPosition;
  String? branchesCode;
  DateTime? branchesCreatedAt;
  DateTime? branchesUpdatedAt;
  String? branchesTitle;
  String? branchesAddress;
  String? branchesText;
  List<Area>? areas;
  List<BranchTranslation>? translations;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branchesId: json["branches_id"] == null ? null : json["branches_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkCitiesId: json["FK_cities_id"] == null ? null : json["FK_cities_id"],
        branchesWhatsapp: json["branches_whatsapp"] == null
            ? null
            : json["branches_whatsapp"],
        branchesMobile:
            json["branches_mobile"] == null ? null : json["branches_mobile"],
        branchesGps: json["branches_gps"] == null ? null : json["branches_gps"],
        branchesStatus:
            json["branches_status"] == null ? null : json["branches_status"],
        branchesPosition: json["branches_position"] == null
            ? null
            : json["branches_position"],
        branchesCode:
            json["branches_code"] == null ? null : json["branches_code"],
        branchesCreatedAt: json["branches_created_at"] == null
            ? null
            : DateTime.parse(json["branches_created_at"]),
        branchesUpdatedAt: json["branches_updated_at"] == null
            ? null
            : DateTime.parse(json["branches_updated_at"]),
        branchesTitle:
            json["branches_title"] == null ? null : json["branches_title"],
        branchesAddress:
            json["branches_address"] == null ? null : json["branches_address"],
        branchesText:
            json["branches_text"] == null ? null : json["branches_text"],
        areas: json["areas"] == null
            ? null
            : List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
        translations: json["translations"] == null
            ? null
            : List<BranchTranslation>.from(
                json["translations"].map((x) => BranchTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branches_id": branchesId == null ? null : branchesId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_cities_id": fkCitiesId == null ? null : fkCitiesId,
        "branches_whatsapp": branchesWhatsapp == null ? null : branchesWhatsapp,
        "branches_mobile": branchesMobile == null ? null : branchesMobile,
        "branches_gps": branchesGps == null ? null : branchesGps,
        "branches_status": branchesStatus == null ? null : branchesStatus,
        "branches_position": branchesPosition == null ? null : branchesPosition,
        "branches_code": branchesCode == null ? null : branchesCode,
        "branches_created_at": branchesCreatedAt == null
            ? null
            : branchesCreatedAt!.toIso8601String(),
        "branches_updated_at": branchesUpdatedAt == null
            ? null
            : branchesUpdatedAt!.toIso8601String(),
        "branches_title": branchesTitle == null ? null : branchesTitle,
        "branches_address": branchesAddress == null ? null : branchesAddress,
        "branches_text": branchesText == null ? null : branchesText,
        "areas": areas == null
            ? null
            : List<dynamic>.from(areas!.map((x) => x.toJson())),
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    this.areasId,
    this.fkAccountsId,
    this.fkBranchesId,
    this.areasDeliveryCost,
    this.areasStatus,
    this.areasPosition,
    this.areasCode,
    this.areasCreatedAt,
    this.areasUpdatedAt,
    this.areasTitle,
    this.translations,
  });

  int? areasId;
  String? fkAccountsId;
  String? fkBranchesId;
  String? areasDeliveryCost;
  String? areasStatus;
  String? areasPosition;
  String? areasCode;
  DateTime? areasCreatedAt;
  DateTime? areasUpdatedAt;
  String? areasTitle;
  List<AreaTranslation>? translations;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        areasId: json["areas_id"] == null ? null : json["areas_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkBranchesId:
            json["FK_branches_id"] == null ? null : json["FK_branches_id"],
        areasDeliveryCost: json["areas_delivery_cost"] == null
            ? null
            : json["areas_delivery_cost"],
        areasStatus: json["areas_status"] == null ? null : json["areas_status"],
        areasPosition:
            json["areas_position"] == null ? null : json["areas_position"],
        areasCode: json["areas_code"] == null ? null : json["areas_code"],
        areasCreatedAt: json["areas_created_at"] == null
            ? null
            : DateTime.parse(json["areas_created_at"]),
        areasUpdatedAt: json["areas_updated_at"] == null
            ? null
            : DateTime.parse(json["areas_updated_at"]),
        areasTitle: json["areas_title"] == null ? null : json["areas_title"],
        translations: json["translations"] == null
            ? null
            : List<AreaTranslation>.from(
                json["translations"].map((x) => AreaTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "areas_id": areasId == null ? null : areasId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_branches_id": fkBranchesId == null ? null : fkBranchesId,
        "areas_delivery_cost":
            areasDeliveryCost == null ? null : areasDeliveryCost,
        "areas_status": areasStatus == null ? null : areasStatus,
        "areas_position": areasPosition == null ? null : areasPosition,
        "areas_code": areasCode == null ? null : areasCode,
        "areas_created_at":
            areasCreatedAt == null ? null : areasCreatedAt!.toIso8601String(),
        "areas_updated_at":
            areasUpdatedAt == null ? null : areasUpdatedAt!.toIso8601String(),
        "areas_title": areasTitle == null ? null : areasTitle,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class AreaTranslation {
  AreaTranslation({
    this.areasTransId,
    this.areasId,
    this.locale,
    this.areasTitle,
  });

  int? areasTransId;
  String? areasId;
  String? locale;
  String? areasTitle;

  factory AreaTranslation.fromJson(Map<String, dynamic> json) =>
      AreaTranslation(
        areasTransId:
            json["areas_trans_id"] == null ? null : json["areas_trans_id"],
        areasId: json["areas_id"] == null ? null : json["areas_id"],
        locale: json["locale"] == null ? null : json["locale"],
        areasTitle: json["areas_title"] == null ? null : json["areas_title"],
      );

  Map<String, dynamic> toJson() => {
        "areas_trans_id": areasTransId == null ? null : areasTransId,
        "areas_id": areasId == null ? null : areasId,
        "locale": locale == null ? null : locale!,
        "areas_title": areasTitle == null ? null : areasTitle,
      };
}

class BranchTranslation {
  BranchTranslation({
    this.branchesTransId,
    this.branchesId,
    this.locale,
    this.branchesTitle,
    this.branchesAddress,
    this.branchesText,
  });

  int? branchesTransId;
  String? branchesId;
  String? locale;
  String? branchesTitle;
  String? branchesAddress;
  String? branchesText;

  factory BranchTranslation.fromJson(Map<String, dynamic> json) =>
      BranchTranslation(
        branchesTransId: json["branches_trans_id"] == null
            ? null
            : json["branches_trans_id"],
        branchesId: json["branches_id"] == null ? null : json["branches_id"],
        locale: json["locale"] == null ? null : json["locale"],
        branchesTitle:
            json["branches_title"] == null ? null : json["branches_title"],
        branchesAddress:
            json["branches_address"] == null ? null : json["branches_address"],
        branchesText:
            json["branches_text"] == null ? null : json["branches_text"],
      );

  Map<String, dynamic> toJson() => {
        "branches_trans_id": branchesTransId == null ? null : branchesTransId,
        "branches_id": branchesId == null ? null : branchesId,
        "locale": locale == null ? null : locale!,
        "branches_title": branchesTitle == null ? null : branchesTitle,
        "branches_address": branchesAddress == null ? null : branchesAddress,
        "branches_text": branchesText == null ? null : branchesText,
      };
}

class CityModel {
  CityModel({
    this.citiesId,
    this.fkAccountsId,
    this.citiesStatus,
    this.citiesPosition,
    this.citiesTitle,
    this.translations,
  });

  int? citiesId;
  String? fkAccountsId;
  String? citiesStatus;
  String? citiesPosition;
  String? citiesTitle;
  List<CityTranslation>? translations;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        citiesId: json["cities_id"] == null ? null : json["cities_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        citiesStatus:
            json["cities_status"] == null ? null : json["cities_status"],
        citiesPosition:
            json["cities_position"] == null ? null : json["cities_position"],
        citiesTitle: json["cities_title"] == null ? null : json["cities_title"],
        translations: json["translations"] == null
            ? null
            : List<CityTranslation>.from(
                json["translations"].map((x) => CityTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cities_id": citiesId == null ? null : citiesId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "cities_status": citiesStatus == null ? null : citiesStatus,
        "cities_position": citiesPosition == null ? null : citiesPosition,
        "cities_title": citiesTitle == null ? null : citiesTitle,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class CityTranslation {
  CityTranslation({
    this.citiesTransId,
    this.citiesId,
    this.locale,
    this.citiesTitle,
  });

  int? citiesTransId;
  String? citiesId;
  String? locale;
  String? citiesTitle;

  factory CityTranslation.fromJson(Map<String, dynamic> json) =>
      CityTranslation(
        citiesTransId:
            json["cities_trans_id"] == null ? null : json["cities_trans_id"],
        citiesId: json["cities_id"] == null ? null : json["cities_id"],
        locale: json["locale"] == null ? null : json["locale"],
        citiesTitle: json["cities_title"] == null ? null : json["cities_title"],
      );

  Map<String, dynamic> toJson() => {
        "cities_trans_id": citiesTransId == null ? null : citiesTransId,
        "cities_id": citiesId == null ? null : citiesId,
        "locale": locale == null ? null : locale!,
        "cities_title": citiesTitle == null ? null : citiesTitle,
      };
}
