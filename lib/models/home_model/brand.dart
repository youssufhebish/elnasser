class BrandModel {
  BrandModel({
    this.brandsId,
    this.fkAccountsId,
    this.brandsCode,
    this.brandsHome,
    this.brandsStatus,
    this.accessLevel,
    this.brandsCreatedAt,
    this.brandsUpdatedAt,
    this.name,
    this.brandsImg,
    this.translations,
  });

  int? brandsId;
  String? fkAccountsId;
  String? brandsCode;
  String? brandsHome;
  String? brandsStatus;
  String? accessLevel;
  DateTime? brandsCreatedAt;
  DateTime? brandsUpdatedAt;
  String? name;
  String? brandsImg;
  List<BrandTranslation>? translations;

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        brandsId: json["brands_id"],
        fkAccountsId: json["FK_accounts_id"],
        brandsCode: json["brands_code"],
        brandsHome: json["brands_home"],
        brandsStatus: json["brands_status"],
        accessLevel: json["access_level"],
        brandsCreatedAt: DateTime.parse(json["brands_created_at"]),
        brandsUpdatedAt: DateTime.parse(json["brands_updated_at"]),
        name: json["brands_name"],
        brandsImg: json["brands_img"],
        translations: List<BrandTranslation>.from(
            json["translations"].map((x) => BrandTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "brands_id": brandsId,
        "FK_accounts_id": fkAccountsId,
        "brands_code": brandsCode,
        "brands_home": brandsHome,
        "brands_status": brandsStatus,
        "access_level": accessLevel,
        "brands_created_at": brandsCreatedAt!.toIso8601String(),
        "brands_updated_at": brandsUpdatedAt!.toIso8601String(),
        "brands_name": name,
        "brands_img": brandsImg,
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class BrandTranslation {
  BrandTranslation({
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

  factory BrandTranslation.fromJson(Map<String, dynamic> json) =>
      BrandTranslation(
        brandsTransId: json["brands_trans_id"],
        brandsId: json["brands_id"],
        locale: json["locale"],
        brandsName: json["brands_name"],
        brandsImg: json["brands_img"],
      );

  Map<String, dynamic> toJson() => {
        "brands_trans_id": brandsTransId,
        "brands_id": brandsId,
        "locale": locale,
        "brands_name": brandsName,
        "brands_img": brandsImg,
      };
}
