import 'dart:convert';

RateOrderModel rateOrderModleFromJson(String str) =>
    RateOrderModel.fromJson(json.decode(str));

String rateOrderModleToJson(RateOrderModel data) => json.encode(data.toJson());

class RateOrderModel {
  RateOrderModel({
    this.accountId,
    this.ratingsDelivery,
    this.ratingsService,
    this.ratingsText,
    this.ordersId,
    this.productsId,
    this.productsRating,
    this.ratingsQuality,
    this.ratingsPrice,
    this.ratingsSize,
    this.ratingsMatchPicture,
    this.productRatingsText,
  });

  int? accountId;
  double? ratingsDelivery;
  double? ratingsService;
  String? ratingsText;
  int? ordersId;
  List<int>? productsId;
  List<int>? productsRating;
  List<double>? ratingsQuality;
  List<double>? ratingsPrice;
  List<double>? ratingsSize;
  List<double>? ratingsMatchPicture;
  List<String>? productRatingsText;

  factory RateOrderModel.fromJson(Map<String, dynamic> json) => RateOrderModel(
        accountId: json["accountId"] == null ? null : json["accountId"],
        ratingsDelivery:
            json["ratings_delivery"] == null ? null : json["ratings_delivery"],
        ratingsService:
            json["ratings_service"] == null ? null : json["ratings_service"],
        ratingsText: json["ratings_text"] == null ? null : json["ratings_text"],
        ordersId: json["orders_id"] == null ? null : json["orders_id"],
        productsId: json["products_id"] == null
            ? null
            : List<int>.from(json["products_id"].map((x) => x)),
        productsRating: json["products_rating"] == null
            ? null
            : List<int>.from(json["products_rating"].map((x) => x)),
        ratingsQuality: json["ratings_quality"] == null
            ? null
            : List<double>.from(json["ratings_quality"].map((x) => x)),
        ratingsPrice: json["ratings_price"] == null
            ? null
            : List<double>.from(json["ratings_price"].map((x) => x)),
        ratingsSize: json["ratings_size"] == null
            ? null
            : List<double>.from(json["ratings_size"].map((x) => x)),
        ratingsMatchPicture: json["ratings_match_picture"] == null
            ? null
            : List<double>.from(json["ratings_match_picture"].map((x) => x)),
        productRatingsText: json["product_ratings_text"] == null
            ? null
            : List<String>.from(json["product_ratings_text"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId == null ? null : accountId,
        "ratings_delivery": ratingsDelivery == null ? null : ratingsDelivery,
        "ratings_service": ratingsService == null ? null : ratingsService,
        "ratings_text": ratingsText == null ? null : ratingsText,
        "orders_id": ordersId == null ? null : ordersId,
        "products_id": productsId == null
            ? null
            : List<dynamic>.from(productsId!.map((x) => x)),
        "products_rating": productsRating == null
            ? null
            : List<dynamic>.from(productsRating!.map((x) => x)),
        "ratings_quality": ratingsQuality == null
            ? null
            : List<dynamic>.from(ratingsQuality!.map((x) => x)),
        "ratings_price": ratingsPrice == null
            ? null
            : List<dynamic>.from(ratingsPrice!.map((x) => x)),
        "ratings_size": ratingsSize == null
            ? null
            : List<dynamic>.from(ratingsSize!.map((x) => x)),
        "ratings_match_picture": ratingsMatchPicture == null
            ? null
            : List<dynamic>.from(ratingsMatchPicture!.map((x) => x)),
        "product_ratings_text": productRatingsText == null
            ? null
            : List<dynamic>.from(productRatingsText!.map((x) => x)),
      };
}
