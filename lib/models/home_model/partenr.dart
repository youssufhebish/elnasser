class Partner {
  Partner({
    this.partnersId,
    this.fkAccountsId,
    this.partnersImg,
    this.partnersStatus,
    this.partnersPosition,
    this.accessLevel,
    this.partnersCreatedAt,
    this.partnersUpdatedAt,
    this.partnersName,
    this.translations,
  });

  int? partnersId;
  String? fkAccountsId;
  String? partnersImg;
  String? partnersStatus;
  String? partnersPosition;
  String? accessLevel;
  DateTime? partnersCreatedAt;
  DateTime? partnersUpdatedAt;
  String? partnersName;
  List<PartnerTranslation>? translations;

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
        partnersId: json["partners_id"],
        fkAccountsId: json["FK_accounts_id"],
        partnersImg: json["partners_img"],
        partnersStatus: json["partners_status"],
        partnersPosition: json["partners_position"],
        accessLevel: json["access_level"],
        partnersCreatedAt: DateTime.parse(json["partners_created_at"]),
        partnersUpdatedAt: DateTime.parse(json["partners_updated_at"]),
        partnersName: json["partners_name"],
        translations: List<PartnerTranslation>.from(
            json["translations"].map((x) => PartnerTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partners_id": partnersId,
        "FK_accounts_id": fkAccountsId,
        "partners_img": partnersImg,
        "partners_status": partnersStatus,
        "partners_position": partnersPosition,
        "access_level": accessLevel,
        "partners_created_at": partnersCreatedAt!.toIso8601String(),
        "partners_updated_at": partnersUpdatedAt!.toIso8601String(),
        "partners_name": partnersName,
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class PartnerTranslation {
  PartnerTranslation({
    this.partnersTransId,
    this.partnersId,
    this.locale,
    this.partnersName,
  });

  int? partnersTransId;
  String? partnersId;
  String? locale;
  String? partnersName;

  factory PartnerTranslation.fromJson(Map<String, dynamic> json) =>
      PartnerTranslation(
        partnersTransId: json["partners_trans_id"],
        partnersId: json["partners_id"],
        locale: json["locale"],
        partnersName: json["partners_name"],
      );

  Map<String, dynamic> toJson() => {
        "partners_trans_id": partnersTransId,
        "partners_id": partnersId,
        "locale": locale,
        "partners_name": partnersName,
      };
}
