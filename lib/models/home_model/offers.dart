class Offer {
  Offer({
    this.offersId,
    this.fkAccountsId,
    this.offersMainNumber,
    this.offersAdditionalNumber,
    this.offersDiscount,
    this.offersFrom,
    this.offersTo,
    this.offersStatus,
    this.accessLevel,
    this.offersImage,
    this.offersType,
    this.trans,
  });

  int? offersId;
  String? fkAccountsId;
  String? offersMainNumber;
  String? offersAdditionalNumber;
  String? offersDiscount;
  DateTime? offersFrom;
  DateTime? offersTo;
  String? offersStatus;
  String? accessLevel;
  String? offersImage;
  String? offersType;
  List<OfferTran>? trans;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offersId: json["offers_id"] == null ? null : json["offers_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        offersMainNumber: json["offers_main_number"] == null
            ? null
            : json["offers_main_number"],
        offersAdditionalNumber: json["offers_additional_number"] == null
            ? null
            : json["offers_additional_number"],
        offersDiscount:
            json["offers_discount"] == null ? null : json["offers_discount"],
        offersFrom: json["offers_from"] == null
            ? null
            : DateTime.parse(json["offers_from"]),
        offersTo: json["offers_to"] == null
            ? null
            : DateTime.parse(json["offers_to"]),
        offersStatus:
            json["offers_status"] == null ? null : json["offers_status"],
        accessLevel: json["access_level"] == null ? null : json["access_level"],
        offersImage: json["offers_image"] == null ? null : json["offers_image"],
        offersType: json["offers_type"] == null ? null : json["offers_type"],
        trans: json["trans"] == null
            ? null
            : List<OfferTran>.from(
                json["trans"].map((x) => OfferTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offers_id": offersId == null ? null : offersId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "offers_main_number":
            offersMainNumber == null ? null : offersMainNumber,
        "offers_additional_number":
            offersAdditionalNumber == null ? null : offersAdditionalNumber,
        "offers_discount": offersDiscount == null ? null : offersDiscount,
        "offers_from":
            offersFrom == null ? null : offersFrom!.toIso8601String(),
        "offers_to": offersTo == null ? null : offersTo!.toIso8601String(),
        "offers_status": offersStatus == null ? null : offersStatus!,
        "access_level": accessLevel == null ? null : accessLevel,
        "offers_image": offersImage == null ? null : offersImage,
        "offers_type": offersType == null ? null : offersType!,
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
      };
}

class OfferTran {
  OfferTran({
    this.offersTransId,
    this.offersId,
    this.offersTitle,
    this.offersAlert,
    this.locale,
  });

  int? offersTransId;
  String? offersId;
  String? offersTitle;
  String? offersAlert;
  String? locale;

  factory OfferTran.fromJson(Map<String, dynamic> json) => OfferTran(
        offersTransId:
            json["offers_trans_id"] == null ? null : json["offers_trans_id"],
        offersId: json["offers_id"] == null ? null : json["offers_id"],
        offersTitle: json["offers_title"] == null ? null : json["offers_title"],
        offersAlert: json["offers_alert"] == null ? null : json["offers_alert"],
        locale: json["locale"] == null ? null : json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "offers_trans_id": offersTransId == null ? null : offersTransId,
        "offers_id": offersId == null ? null : offersId,
        "offers_title": offersTitle == null ? null : offersTitle,
        "offers_alert": offersAlert == null ? null : offersAlert,
        "locale": locale == null ? null : locale!,
      };
}
