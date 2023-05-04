class AccountBranch {
  AccountBranch({
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
  List<BranchTranslation>? translations;

  factory AccountBranch.fromJson(Map<String, dynamic> json) => AccountBranch(
        branchesId: json["branches_id"],
        fkAccountsId: json["FK_accounts_id"],
        fkCitiesId: json["FK_cities_id"] == null ? null : json["FK_cities_id"],
        branchesWhatsapp: json["branches_whatsapp"] == null
            ? null
            : json["branches_whatsapp"],
        branchesMobile:
            json["branches_mobile"] == null ? null : json["branches_mobile"],
        branchesGps: json["branches_gps"] == null ? null : json["branches_gps"],
        branchesStatus: json["branches_status"],
        branchesPosition: json["branches_position"],
        branchesCode: json["branches_code"],
        branchesCreatedAt: DateTime.parse(json["branches_created_at"]),
        branchesUpdatedAt: DateTime.parse(json["branches_updated_at"]),
        branchesTitle: json["branches_title"],
        branchesAddress:
            json["branches_address"] == null ? null : json["branches_address"],
        branchesText:
            json["branches_text"] == null ? null : json["branches_text"],
        translations: List<BranchTranslation>.from(
            json["translations"].map((x) => BranchTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branches_id": branchesId,
        "FK_accounts_id": fkAccountsId,
        "FK_cities_id": fkCitiesId == null ? null : fkCitiesId,
        "branches_whatsapp": branchesWhatsapp == null ? null : branchesWhatsapp,
        "branches_mobile": branchesMobile == null ? null : branchesMobile,
        "branches_gps": branchesGps == null ? null : branchesGps,
        "branches_status": branchesStatus,
        "branches_position": branchesPosition,
        "branches_code": branchesCode,
        "branches_created_at": branchesCreatedAt!.toIso8601String(),
        "branches_updated_at": branchesUpdatedAt!.toIso8601String(),
        "branches_title": branchesTitle,
        "branches_address": branchesAddress == null ? null : branchesAddress,
        "branches_text": branchesText == null ? null : branchesText,
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
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
        branchesTransId: json["branches_trans_id"],
        branchesId: json["branches_id"],
        locale: json["locale"],
        branchesTitle: json["branches_title"],
        branchesAddress:
            json["branches_address"] == null ? null : json["branches_address"],
        branchesText:
            json["branches_text"] == null ? null : json["branches_text"],
      );

  Map<String, dynamic> toJson() => {
        "branches_trans_id": branchesTransId,
        "branches_id": branchesId,
        "locale": locale,
        "branches_title": branchesTitle,
        "branches_address": branchesAddress == null ? null : branchesAddress,
        "branches_text": branchesText == null ? null : branchesText,
      };
}
