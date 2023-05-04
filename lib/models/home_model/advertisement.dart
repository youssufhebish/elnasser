class Advertisements {
  Advertisements({
    this.homeBanner,
    this.homeEnd,
    this.smallAds,
    this.homeCenter,
    this.sectionalBanners,
    this.homePopup,
  });

  List<BannerClass>? homeBanner;
  List<BannerClass>? homeEnd;
  List<BannerClass>? smallAds;
  List<BannerClass>? homeCenter;
  List<BannerClass>? sectionalBanners;
  List<BannerClass>? homePopup;

  factory Advertisements.fromJson(Map<String, dynamic> json) => Advertisements(
        homeBanner: json["home_banner"] == null
            ? null
            : List<BannerClass>.from(
                json["home_banner"].map((x) => BannerClass.fromJson(x))),
        homeEnd: json["home_end"] == null
            ? null
            : List<BannerClass>.from(
                json["home_end"].map((x) => BannerClass.fromJson(x))),
        smallAds: json["small_ads"] == null
            ? null
            : List<BannerClass>.from(
                json["small_ads"].map((x) => BannerClass.fromJson(x))),
        homeCenter: json["home_center"] == null
            ? null
            : List<BannerClass>.from(
                json["home_center"].map((x) => BannerClass.fromJson(x))),
        sectionalBanners: json["sectional_banners"] == null
            ? null
            : List<BannerClass>.from(
                json["sectional_banners"].map((x) => BannerClass.fromJson(x))),
        homePopup: json["home_popup"] == null
            ? null
            : List<BannerClass>.from(
                json["home_popup"].map((x) => BannerClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home_banner": homeBanner == null
            ? null
            : List<dynamic>.from(homeBanner!.map((x) => x.toJson())),
        "home_end": homeEnd == null
            ? null
            : List<dynamic>.from(homeEnd!.map((x) => x.toJson())),
        "small_ads": smallAds == null
            ? null
            : List<dynamic>.from(smallAds!.map((x) => x.toJson())),
        "home_center": homeCenter == null
            ? null
            : List<dynamic>.from(homeCenter!.map((x) => x.toJson())),
        "sectional_banners": sectionalBanners == null
            ? null
            : List<dynamic>.from(sectionalBanners!.map((x) => x.toJson())),
        "home_popup": homePopup == null
            ? null
            : List<dynamic>.from(homePopup!.map((x) => x.toJson())),
      };
}

class BannerClass {
  BannerClass(
      {this.advertisementsId,
      this.fkAccountsId,
      this.advertisementsName,
      this.shopsId,
      this.advertisementsImg,
      this.advertisementsMobileImg,
      this.advertisementsColor,
      this.advertisementsStatus,
      this.advertisementsViewPage,
      this.advertisementsFrom,
      this.advertisementsTo,
      this.advertisementsPosition,
      this.advertisementsCreatedAt,
      this.advertisementsUpdatedAt,
      this.advertisementsText,
      this.advertisementsUrl,
      this.translations,
      this.advertisementsType,
      this.advertisementsValue});

  int? advertisementsId;
  String? fkAccountsId;
  String? advertisementsName;
  dynamic shopsId;
  String? advertisementsImg;
  String? advertisementsMobileImg;
  String? advertisementsColor;
  String? advertisementsStatus;
  String? advertisementsViewPage;
  DateTime? advertisementsFrom;
  DateTime? advertisementsTo;
  String? advertisementsPosition;
  DateTime? advertisementsCreatedAt;
  DateTime? advertisementsUpdatedAt;
  String? advertisementsType;
  String? advertisementsValue;
  dynamic advertisementsText;
  String? advertisementsUrl;
  List<BannerTranslation>? translations;

  factory BannerClass.fromJson(Map<String, dynamic> json) => BannerClass(
        advertisementsId: json["advertisements_id"],
        fkAccountsId: json["FK_accounts_id"],
        advertisementsName: json["advertisements_name"],
        shopsId: json["shops_id"],
        advertisementsImg: json["advertisements_img"],
        advertisementsMobileImg: json["advertisements_mobile_img"],
        advertisementsColor: json["advertisements_color"],
        advertisementsStatus: json["advertisements_status"],
        advertisementsViewPage: json["advertisements_view_page"],
        advertisementsFrom: json["advertisements_from"] == null
            ? null
            : DateTime.parse(json["advertisements_from"]),
        advertisementsTo: json["advertisements_to"] == null
            ? null
            : DateTime.parse(json["advertisements_to"]),
        advertisementsPosition: json["advertisements_position"],
        advertisementsCreatedAt:
            DateTime.parse(json["advertisements_created_at"]),
        advertisementsUpdatedAt:
            DateTime.parse(json["advertisements_updated_at"]),
        advertisementsText: json["advertisements_text"],
        advertisementsUrl: json["advertisements_url"] == null
            ? null
            : json["advertisements_url"],
        advertisementsValue: json["advertisements_value"] == null
            ? null
            : json["advertisements_value"],
        advertisementsType: json["advertisements_type"] == null
            ? null
            : json["advertisements_type"],
        translations: List<BannerTranslation>.from(
            json["translations"].map((x) => BannerTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "advertisements_id": advertisementsId,
        "FK_accounts_id": fkAccountsId,
        "advertisements_name": advertisementsName,
        "shops_id": shopsId,
        "advertisements_img": advertisementsImg,
        "advertisements_mobile_img": advertisementsMobileImg,
        "advertisements_color": advertisementsColor,
        "advertisements_status": advertisementsStatus,
        "advertisements_view_page": advertisementsViewPage,
        "advertisements_from": advertisementsFrom == null
            ? null
            : "${advertisementsFrom!.year.toString().padLeft(4, '0')}-${advertisementsFrom!.month.toString().padLeft(2, '0')}-${advertisementsFrom!.day.toString().padLeft(2, '0')}",
        "advertisements_to": advertisementsTo == null
            ? null
            : "${advertisementsTo!.year.toString().padLeft(4, '0')}-${advertisementsTo!.month.toString().padLeft(2, '0')}-${advertisementsTo!.day.toString().padLeft(2, '0')}",
        "advertisements_position": advertisementsPosition,
        "advertisements_created_at": advertisementsCreatedAt!.toIso8601String(),
        "advertisements_updated_at": advertisementsUpdatedAt!.toIso8601String(),
        "advertisements_text": advertisementsText,
        "advertisements_url":
            advertisementsUrl == null ? null : advertisementsUrl,
        "advertisements_value":
            advertisementsValue == null ? null : advertisementsValue,
        "advertisements_type":
            advertisementsType == null ? null : advertisementsType,
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class BannerTranslation {
  BannerTranslation({
    this.advertisementsTransId,
    this.advertisementsId,
    this.locale,
    this.advertisementsImg,
    this.advertisementsMobileImg,
    this.advertisementsText,
    this.advertisementsUrl,
  });

  int? advertisementsTransId;
  String? advertisementsId;
  String? locale;
  String? advertisementsImg;
  String? advertisementsMobileImg;
  dynamic advertisementsText;
  String? advertisementsUrl;

  factory BannerTranslation.fromJson(Map<String, dynamic> json) =>
      BannerTranslation(
        advertisementsTransId: json["advertisements_trans_id"],
        advertisementsId: json["advertisements_id"],
        locale: json["locale"],
        advertisementsImg: json["advertisements_img"],
        advertisementsMobileImg: json["advertisements_mobile_img"],
        advertisementsText: json["advertisements_text"],
        advertisementsUrl: json["advertisements_url"] == null
            ? null
            : json["advertisements_url"],
      );

  Map<String, dynamic> toJson() => {
        "advertisements_trans_id": advertisementsTransId,
        "advertisements_id": advertisementsId,
        "locale": locale,
        "advertisements_img": advertisementsImg,
        "advertisements_mobile_img": advertisementsMobileImg,
        "advertisements_text": advertisementsText,
        "advertisements_url":
            advertisementsUrl == null ? null : advertisementsUrl,
      };
}
