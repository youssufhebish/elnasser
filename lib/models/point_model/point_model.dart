import 'dart:convert';

pointsModel pointsModelFromJson(String str) =>
    pointsModel.fromJson(json.decode(str));

String pointsModelToJson(pointsModel data) => json.encode(data.toJson());

class pointsModel {
  pointsModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory pointsModel.fromJson(Map<String, dynamic> json) => pointsModel(
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
  Data({this.pointLevels, this.customerLevel, this.customerPoints});

  List<Level>? pointLevels;
  Level? customerLevel;
  String? customerPoints;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pointLevels: json["pointLevels"] == null
            ? null
            : List<Level>.from(
                json["pointLevels"].map((x) => Level.fromJson(x))),
        customerLevel: json["customerLevel"] == null
            ? null
            : Level.fromJson(json["customerLevel"]),
        customerPoints: json["customer_points"],
      );

  Map<String, dynamic> toJson() => {
        "pointLevels": pointLevels == null
            ? null
            : List<dynamic>.from(pointLevels!.map((x) => x.toJson())),
        "customerLevel": customerLevel == null ? null : customerLevel!.toJson(),
        "customer_points": customerPoints == null ? null : customerPoints,
      };
}

class Level {
  Level({
    this.pointsLevelsId,
    this.fkAccountsId,
    this.pointsLevelsFrom,
    this.pointsLevelsTo,
    this.pointsLevelsValue,
    this.pointsLevelsStatus,
    this.accessLevel,
    this.pointsLevelsCreatedAt,
    this.pointsLevelsUpdatedAt,
    this.pointsLevelsName,
    this.translations,
  });

  int? pointsLevelsId;
  String? fkAccountsId;
  String? pointsLevelsFrom;
  String? pointsLevelsTo;
  String? pointsLevelsValue;
  String? pointsLevelsStatus;
  String? accessLevel;
  DateTime? pointsLevelsCreatedAt;
  DateTime? pointsLevelsUpdatedAt;
  String? pointsLevelsName;
  List<Translation>? translations;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        pointsLevelsId:
            json["points_levels_id"] == null ? null : json["points_levels_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        pointsLevelsFrom: json["points_levels_from"] == null
            ? null
            : json["points_levels_from"],
        pointsLevelsTo:
            json["points_levels_to"] == null ? null : json["points_levels_to"],
        pointsLevelsValue: json["points_levels_value"] == null
            ? null
            : json["points_levels_value"],
        pointsLevelsStatus: json["points_levels_status"] == null
            ? null
            : json["points_levels_status"],
        accessLevel: json["access_level"] == null ? null : json["access_level"],
        pointsLevelsCreatedAt: json["points_levels_created_at"] == null
            ? null
            : DateTime.parse(json["points_levels_created_at"]),
        pointsLevelsUpdatedAt: json["points_levels_updated_at"] == null
            ? null
            : DateTime.parse(json["points_levels_updated_at"]),
        pointsLevelsName: json["points_levels_name"] == null
            ? null
            : json["points_levels_name"],
        translations: json["translations"] == null
            ? null
            : List<Translation>.from(
                json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "points_levels_id": pointsLevelsId == null ? null : pointsLevelsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "points_levels_from":
            pointsLevelsFrom == null ? null : pointsLevelsFrom,
        "points_levels_to": pointsLevelsTo == null ? null : pointsLevelsTo,
        "points_levels_value":
            pointsLevelsValue == null ? null : pointsLevelsValue,
        "points_levels_status":
            pointsLevelsStatus == null ? null : pointsLevelsStatus,
        "access_level": accessLevel == null ? null : accessLevel,
        "points_levels_created_at": pointsLevelsCreatedAt == null
            ? null
            : pointsLevelsCreatedAt!.toIso8601String(),
        "points_levels_updated_at": pointsLevelsUpdatedAt == null
            ? null
            : pointsLevelsUpdatedAt!.toIso8601String(),
        "points_levels_name":
            pointsLevelsName == null ? null : pointsLevelsName,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    this.pointsLevelsTransId,
    this.pointsLevelsId,
    this.locale,
    this.pointsLevelsName,
  });

  int? pointsLevelsTransId;
  String? pointsLevelsId;
  String? locale;
  String? pointsLevelsName;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        pointsLevelsTransId: json["points_levels_trans_id"] == null
            ? null
            : json["points_levels_trans_id"],
        pointsLevelsId:
            json["points_levels_id"] == null ? null : json["points_levels_id"],
        locale: json["locale"] == null ? null : json["locale"],
        pointsLevelsName: json["points_levels_name"] == null
            ? null
            : json["points_levels_name"],
      );

  Map<String, dynamic> toJson() => {
        "points_levels_trans_id":
            pointsLevelsTransId == null ? null : pointsLevelsTransId,
        "points_levels_id": pointsLevelsId == null ? null : pointsLevelsId,
        "locale": locale == null ? null : locale!,
        "points_levels_name":
            pointsLevelsName == null ? null : pointsLevelsName,
      };
}
