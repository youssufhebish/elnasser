import 'dart:convert';

GetRatingModel getRatingModelFromJson(String str) =>
    GetRatingModel.fromJson(json.decode(str));

String getRatingModelToJson(GetRatingModel data) => json.encode(data.toJson());

class GetRatingModel {
  const GetRatingModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  final int? status;
  final String? message;
  final dynamic errors;
  final Data? data;

  factory GetRatingModel.fromJson(Map<String, dynamic> json) => GetRatingModel(
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
    this.ratings,
    this.pagination,
    this.allowRating,
    this.allReviews,
    this.productRating,
    this.oneStar,
    this.twoStar,
    this.threeStar,
    this.fourStar,
    this.fiveStar,
  });

  List<RatingProduct>? ratings;
  Pagination? pagination;
  int? allowRating;
  int? allReviews;
  String? productRating;
  int? oneStar;
  int? twoStar;
  int? threeStar;
  int? fourStar;
  int? fiveStar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ratings: json["ratings"] == null
            ? null
            : List<RatingProduct>.from(
                json["ratings"].map((x) => RatingProduct.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        allowRating: json["allow_rating"] == null ? null : json["allow_rating"],
        allReviews: json["all_reviews"] == null ? null : json["all_reviews"],
        productRating:
            json["product_rating"] == null ? null : json["product_rating"],
        oneStar: json["oneStar"] == null ? null : json["oneStar"],
        twoStar: json["twoStar"] == null ? null : json["twoStar"],
        threeStar: json["threeStar"] == null ? null : json["threeStar"],
        fourStar: json["fourStar"] == null ? null : json["fourStar"],
        fiveStar: json["fiveStar"] == null ? null : json["fiveStar"],
      );

  Map<String, dynamic> toJson() => {
        "ratings": ratings == null
            ? null
            : List<dynamic>.from(ratings!.map((x) => x.toJson())),
        "pagination": pagination == null ? null : pagination!.toJson(),
        "allow_rating": allowRating == null ? null : allowRating,
        "all_reviews": allReviews == null ? null : allReviews,
        "product_rating": productRating == null ? null : productRating,
        "oneStar": oneStar == null ? null : oneStar,
        "twoStar": twoStar == null ? null : twoStar,
        "threeStar": threeStar == null ? null : threeStar,
        "fourStar": fourStar == null ? null : fourStar,
        "fiveStar": fiveStar == null ? null : fiveStar,
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
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
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
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
      };
}

class RatingProduct {
  RatingProduct({
    this.ratingsId,
    this.fkAccountsId,
    this.fkCustomersId,
    this.productsId,
    this.ratingsQuality,
    this.ratingsPrice,
    this.ratingsSize,
    this.ratingsMatchPicture,
    this.ratingsValue,
    this.ratingsText,
    this.ratingsStatus,
    this.accessLevel,
    this.ratingsCreatedAt,
    this.ratingsUpdatedAt,
    this.customer,
  });

  int? ratingsId;
  String? fkAccountsId;
  String? fkCustomersId;
  String? productsId;
  String? ratingsQuality;
  String? ratingsPrice;
  String? ratingsSize;
  String? ratingsMatchPicture;
  String? ratingsValue;
  String? ratingsText;
  String? ratingsStatus;
  String? accessLevel;
  DateTime? ratingsCreatedAt;
  dynamic ratingsUpdatedAt;
  Customer? customer;

  factory RatingProduct.fromJson(Map<String, dynamic> json) => RatingProduct(
        ratingsId: json["ratings_id"] == null ? null : json["ratings_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkCustomersId:
            json["FK_customers_id"] == null ? null : json["FK_customers_id"],
        productsId: json["products_id"] == null ? null : json["products_id"],
        ratingsQuality:
            json["ratings_quality"] == null ? null : json["ratings_quality"],
        ratingsPrice:
            json["ratings_price"] == null ? null : json["ratings_price"],
        ratingsSize: json["ratings_size"] == null ? null : json["ratings_size"],
        ratingsMatchPicture: json["ratings_match_picture"] == null
            ? null
            : json["ratings_match_picture"],
        ratingsValue:
            json["ratings_value"] == null ? null : json["ratings_value"],
        ratingsText: json["ratings_text"] == null ? null : json["ratings_text"],
        ratingsStatus:
            json["ratings_status"] == null ? null : json["ratings_status"],
        accessLevel: json["access_level"] == null ? null : json["access_level"],
        ratingsCreatedAt: json["ratings_created_at"] == null
            ? null
            : DateTime.parse(json["ratings_created_at"]),
        ratingsUpdatedAt: json["ratings_updated_at"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "ratings_id": ratingsId == null ? null : ratingsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_customers_id": fkCustomersId == null ? null : fkCustomersId,
        "products_id": productsId == null ? null : productsId,
        "ratings_quality": ratingsQuality == null ? null : ratingsQuality,
        "ratings_price": ratingsPrice == null ? null : ratingsPrice,
        "ratings_size": ratingsSize == null ? null : ratingsSize,
        "ratings_match_picture":
            ratingsMatchPicture == null ? null : ratingsMatchPicture,
        "ratings_value": ratingsValue == null ? null : ratingsValue,
        "ratings_text": ratingsText == null ? null : ratingsText,
        "ratings_status": ratingsStatus == null ? null : ratingsStatus,
        "access_level": accessLevel == null ? null : accessLevel,
        "ratings_created_at": ratingsCreatedAt == null
            ? null
            : ratingsCreatedAt!.toIso8601String(),
        "ratings_updated_at": ratingsUpdatedAt,
        "customer": customer == null ? null : customer!.toJson(),
      };
}

class Customer {
  Customer({
    this.customersId,
    this.fkAccountsId,
    this.customersName,
    this.customersEmail,
    this.customersPhone,
    this.customersCountryCode,
    this.customersBirthday,
    this.customersGender,
    this.customersStatus,
    this.emailVerified,
    this.phoneVerified,
    this.customersWallet,
    this.customersDiscountPoints,
    this.customersLevelPoints,
    this.provider,
    this.providerId,
    this.customersCreatedAt,
    this.customersUpdatedAt,
  });

  int? customersId;
  String? fkAccountsId;
  String? customersName;
  String? customersEmail;
  String? customersPhone;
  String? customersCountryCode;
  DateTime? customersBirthday;
  String? customersGender;
  String? customersStatus;
  String? emailVerified;
  String? phoneVerified;
  String? customersWallet;
  String? customersDiscountPoints;
  String? customersLevelPoints;
  dynamic provider;
  dynamic providerId;
  DateTime? customersCreatedAt;
  DateTime? customersUpdatedAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customersId: json["customers_id"] == null ? null : json["customers_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        customersName:
            json["customers_name"] == null ? null : json["customers_name"],
        customersEmail:
            json["customers_email"] == null ? null : json["customers_email"],
        customersPhone:
            json["customers_phone"] == null ? null : json["customers_phone"],
        customersCountryCode: json["customers_country_code"] == null
            ? null
            : json["customers_country_code"],
        customersBirthday: json["customers_birthday"] == null
            ? null
            : DateTime.parse(json["customers_birthday"]),
        customersGender:
            json["customers_gender"] == null ? null : json["customers_gender"],
        customersStatus:
            json["customers_status"] == null ? null : json["customers_status"],
        emailVerified:
            json["email_verified"] == null ? null : json["email_verified"],
        phoneVerified:
            json["phone_verified"] == null ? null : json["phone_verified"],
        customersWallet:
            json["customers_wallet"] == null ? null : json["customers_wallet"],
        customersDiscountPoints: json["customers_discount_points"] == null
            ? null
            : json["customers_discount_points"],
        customersLevelPoints: json["customers_level_points"] == null
            ? null
            : json["customers_level_points"],
        provider: json["provider"],
        providerId: json["provider_id"],
        customersCreatedAt: json["customers_created_at"] == null
            ? null
            : DateTime.parse(json["customers_created_at"]),
        customersUpdatedAt: json["customers_updated_at"] == null
            ? null
            : DateTime.parse(json["customers_updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "customers_id": customersId == null ? null : customersId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "customers_name": customersName == null ? null : customersName,
        "customers_email": customersEmail == null ? null : customersEmail,
        "customers_phone": customersPhone == null ? null : customersPhone,
        "customers_country_code":
            customersCountryCode == null ? null : customersCountryCode,
        "customers_birthday": customersBirthday == null
            ? null
            : "${customersBirthday!.year.toString().padLeft(4, '0')}-${customersBirthday!.month.toString().padLeft(2, '0')}-${customersBirthday!.day.toString().padLeft(2, '0')}",
        "customers_gender": customersGender == null ? null : customersGender,
        "customers_status": customersStatus == null ? null : customersStatus,
        "email_verified": emailVerified == null ? null : emailVerified,
        "phone_verified": phoneVerified == null ? null : phoneVerified,
        "customers_wallet": customersWallet == null ? null : customersWallet,
        "customers_discount_points":
            customersDiscountPoints == null ? null : customersDiscountPoints,
        "customers_level_points":
            customersLevelPoints == null ? null : customersLevelPoints,
        "provider": provider,
        "provider_id": providerId,
        "customers_created_at": customersCreatedAt == null
            ? null
            : customersCreatedAt!.toIso8601String(),
        "customers_updated_at": customersUpdatedAt == null
            ? null
            : customersUpdatedAt!.toIso8601String(),
      };
}
