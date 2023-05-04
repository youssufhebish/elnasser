// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:elnasser/models/home_model/atributes.dart';
import 'package:elnasser/models/home_model/offers.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/rating/get_rating.dart';

import '../account_model.dart';
import 'order_model_detail.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
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
    this.orders,
  });

  List<Order>? orders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: json["orders"] == null
            ? null
            : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders == null
            ? null
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

// class Order {
//   Order({
//
//
//
//
//     this.ordersId,
//     this.fkAccountsId,
//     this.fkBranchesId,
//     this.fkAreasId,
//     this.fkCustomersId,
//     this.fkPaymentsId,
//     this.fkShippingMethodsId,
//     this.ordersPrice,
//     this.ordersDeliveryCost,
//     this.ordersFinalCost,
//     this.ordersNotes,
//     this.ordersNotesForItems,
//     this.ordersDeliveryAddress,
//     this.ordersPaymentMethod,
//     this.ordersGps,
//     this.ordersImg,
//     this.ordersImgPrice,
//     this.ordersStatus,
//     this.ordersPaymentStatus,
//     this.ordersRead,
//     this.ordersTimeTaken,
//     this.ordersFollowDeliveryTime,
//     this.shopsId,
//     this.ordersPhone,
//     this.ordersProductsTotalCount,
//     this.ordersVat,
//     this.ordersNumberPoints,
//     this.ordersDiscountPoints,
//     this.deliveryTimesId,
//     this.isDelivery,
//     this.ordersFullResponseUrl,
//     this.ordersTotalPayment,
//     this.ordersCreatedAt,
//     this.ordersUpdatedAt,
//     this.fkCouponsId,
//     this.couponsValue,
//     this.couponsCode,
//     this.couponsType,
//     this.items,
//     this.contacts,
//     this.payment,
//     this.account,
//     this.shippingMethod,
//     this.orderReturnModel,
//     this.rating,
//     this.ordersDiscountValue,
//     this.ordersTotalOrderProductsPoints,
//     this.orderDetailsRating,
//     this.productRating,
//
//   });
//   String? ordersTotalOrderProductsPoints;
//
//   dynamic ordersDiscountValue;
//   int? ordersId;
//   String? fkAccountsId;
//   String? fkBranchesId;
//   dynamic fkAreasId;
//   String? fkCustomersId;
//   String? fkPaymentsId;
//   String? fkShippingMethodsId;
//   String? ordersPrice;
//   String? ordersDeliveryCost;
//   String? ordersFinalCost;
//   dynamic ordersNotes;
//   dynamic ordersNotesForItems;
//   String? ordersDeliveryAddress;
//   String? ordersPaymentMethod;
//   String? ordersGps;
//   dynamic ordersImg;
//   dynamic ordersImgPrice;
//   String? ordersStatus;
//   String? ordersPaymentStatus;
//   String? ordersRead;
//   dynamic ordersTimeTaken;
//   String? ordersFollowDeliveryTime;
//   dynamic shopsId;
//   String? ordersPhone;
//   String? ordersProductsTotalCount;
//   String? ordersVat;
//   String? ordersNumberPoints;
//   dynamic ordersDiscountPoints;
//   dynamic deliveryTimesId;
//   String? isDelivery;
//   dynamic ordersFullResponseUrl;
//   dynamic ordersTotalPayment;
//   DateTime? ordersCreatedAt;
//   DateTime? ordersUpdatedAt;
//   String? fkCouponsId;
//   String? couponsValue;
//   String? couponsCode;
//   String? couponsType;
//   String? rating;
//   List<OrderItemModel >? items;
//   List<dynamic>? contacts;
//   Payment? payment;
//   ShippingMethod? shippingMethod;
//   OrderDetailsRating? orderDetailsRating;
//   Account? account;
//   OrderReturnModel? orderReturnModel;
//   List<RatingProduct>? productRating;
//
//   factory Order.fromJson(Map<String , dynamic>  json) => Order(
//     ordersDiscountValue: json["orders_discount_value"],
//
//     ordersId: json["orders_id"] == null ? null : json["orders_id"],
//     fkAccountsId: json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
//     fkBranchesId: json["FK_branches_id"] == null ? null : json["FK_branches_id"],
//     fkAreasId: json["FK_areas_id"],
//     fkCustomersId: json["FK_customers_id"] == null ? null : json["FK_customers_id"],
//     rating: json["rating"] == null ? null : json["rating"],
//     fkPaymentsId: json["FK_payments_id"] == null ? null : json["FK_payments_id"],
//     fkShippingMethodsId: json["FK_shipping_methods_id"] == null ? null : json["FK_shipping_methods_id"],
//     ordersPrice: json["orders_price"] == null ? null : json["orders_price"],
//     ordersDeliveryCost: json["orders_delivery_cost"] == null ? null : json["orders_delivery_cost"],
//     ordersFinalCost: json["orders_final_cost"] == null ? null : json["orders_final_cost"],
//     ordersNotes: json["orders_notes"],
//     ordersNotesForItems: json["orders_notes_for_items"],
//     ordersDeliveryAddress: json["orders_delivery_address"] == null ? null : json["orders_delivery_address"],
//     ordersPaymentMethod: json["orders_payment_method"] == null ? null : json["orders_payment_method"],
//     ordersGps: json["orders_gps"] == null ? null : json["orders_gps"],
//     ordersImg: json["orders_img"],
//     ordersImgPrice: json["orders_img_price"],
//     ordersStatus: json["orders_status"] == null ? null : json["orders_status"],
//     ordersPaymentStatus: json["orders_payment_status"] == null ? null : json["orders_payment_status"],
//     ordersRead: json["orders_read"] == null ? null : json["orders_read"],
//     ordersTimeTaken: json["orders_time_taken"],
//     ordersFollowDeliveryTime: json["orders_follow_delivery_time"] == null ? null : json["orders_follow_delivery_time"],
//     shopsId: json["shops_id"],
//     ordersPhone: json["orders_phone"] == null ? null : json["orders_phone"],
//     ordersProductsTotalCount: json["orders_products_total_count"] == null ? null : json["orders_products_total_count"],
//     ordersVat: json["orders_vat"] == null ? null : json["orders_vat"],
//     ordersNumberPoints: json["orders_number_points"] == null ? null : json["orders_number_points"],
//     ordersDiscountPoints: json["orders_discount_points"],
//     deliveryTimesId: json["delivery_times_id"],
//     isDelivery: json["is_delivery"] == null ? null : json["is_delivery"],
//     ordersFullResponseUrl: json["orders_full_response_url"],
//     ordersTotalPayment: json["orders_total_payment"],
//     ordersCreatedAt: json["orders_created_at"] == null ? null : DateTime.parse(json["orders_created_at"]),
//     ordersUpdatedAt: json["orders_updated_at"] == null ? null : DateTime.parse(json["orders_updated_at"]),
//     fkCouponsId: json["FK_coupons_id"] == null ? null : json["FK_coupons_id"],
//     couponsValue: json["coupons_value"] == null ? null : json["coupons_value"],
//     couponsCode: json["coupons_code"] == null ? null : json["coupons_code"],
//     couponsType: json["coupons_type"] == null ? null : json["coupons_type"],
//     items: json["items"] == null ? null : List<OrderItemModel >.from(json["items"].map((x) => OrderItemModel.fromJson(x))),
//     contacts: json["contacts"] == null ? null : List<dynamic>.from(json["contacts"].map((x) => x)),
//     payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
//     shippingMethod: json["shipping_method"] == null ? null : ShippingMethod.fromJson(json["shipping_method"]),
//     orderDetailsRating: json["rating"] == null ? null : OrderDetailsRating.fromJson(json["rating"]),
//     account: json["account"] == null ? null : Account.fromJson(json["account"]),
//     orderReturnModel: json["order_return"] == null ? null : OrderReturnModel.fromJson(json["order_return"]),
//     ordersTotalOrderProductsPoints: json["orders_total_order_products_points"] == null ? null : json["orders_total_order_products_points"],
//     productRating: json["products_rating"] == null ? null :List<RatingProduct >.from(json["products_rating"].map((x) => RatingProduct.fromJson(x))),
//
//   );
//
//   Map<String , dynamic>  toJson() => {
//     "orders_total_order_products_points": ordersTotalOrderProductsPoints == null ? null : ordersTotalOrderProductsPoints,
//     "orders_discount_value": ordersDiscountValue,
//
//     "orders_id": ordersId == null ? null : ordersId,
//     "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
//     "FK_branches_id": fkBranchesId == null ? null : fkBranchesId,
//     "rating": rating == null ? null : rating,
//     "FK_areas_id": fkAreasId,
//     "FK_customers_id": fkCustomersId == null ? null : fkCustomersId,
//     "FK_payments_id": fkPaymentsId == null ? null : fkPaymentsId,
//     "FK_shipping_methods_id": fkShippingMethodsId == null ? null : fkShippingMethodsId,
//     "orders_price": ordersPrice == null ? null : ordersPrice,
//     "orders_delivery_cost": ordersDeliveryCost == null ? null : ordersDeliveryCost,
//     "orders_final_cost": ordersFinalCost == null ? null : ordersFinalCost,
//     "orders_notes": ordersNotes,
//     "orders_notes_for_items": ordersNotesForItems,
//     "orders_delivery_address": ordersDeliveryAddress == null ? null : ordersDeliveryAddress!,
//     "orders_payment_method": ordersPaymentMethod == null ? null :ordersPaymentMethod!,
//     "orders_gps": ordersGps == null ? null : ordersGps!,
//     "orders_img": ordersImg,
//     "orders_img_price": ordersImgPrice,
//     "orders_status": ordersStatus == null ? null : ordersStatus,
//     "orders_payment_status": ordersPaymentStatus == null ? null : ordersPaymentStatus,
//     "orders_read": ordersRead == null ? null : ordersRead,
//     "orders_time_taken": ordersTimeTaken,
//     "orders_follow_delivery_time": ordersFollowDeliveryTime == null ? null : ordersFollowDeliveryTime,
//     "shops_id": shopsId,
//     "orders_phone": ordersPhone == null ? null : ordersPhone,
//     "orders_products_total_count": ordersProductsTotalCount == null ? null : ordersProductsTotalCount,
//     "orders_vat": ordersVat == null ? null : ordersVat,
//     "orders_number_points": ordersNumberPoints == null ? null : ordersNumberPoints,
//     "orders_discount_points": ordersDiscountPoints,
//     "delivery_times_id": deliveryTimesId,
//     "is_delivery": isDelivery == null ? null : isDelivery,
//     "orders_full_response_url": ordersFullResponseUrl,
//     "orders_total_payment": ordersTotalPayment,
//     "orders_created_at": ordersCreatedAt == null ? null : ordersCreatedAt!.toIso8601String(),
//     "orders_updated_at": ordersUpdatedAt == null ? null : ordersUpdatedAt!.toIso8601String(),
//     "FK_coupons_id": fkCouponsId == null ? null : fkCouponsId,
//     "coupons_value": couponsValue == null ? null : couponsValue,
//     "coupons_code": couponsCode == null ? null : couponsCode,
//     "coupons_type": couponsType == null ? null : couponsType,
//     "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
//     "contacts": contacts == null ? null : List<dynamic>.from(contacts!.map((x) => x)),
//     "payment": payment == null ? null : payment!.toJson(),
//     "shipping_method": shippingMethod == null ? null : shippingMethod!.toJson(),
//     "ratting": orderDetailsRating == null ? null : orderDetailsRating!.toJson(),
//     "account": account == null ? null : account!.toJson(),
//     "order_return": orderReturnModel == null ? null : orderReturnModel!.toJson(),
//     "products_rating": productRating == null ? null : List<dynamic>.from(productRating!.map((x) => x.toJson())),
//
//   };
// }

class OrderItemModel {
  OrderItemModel(
      {this.ordersItemsId,
      this.fkOrdersId,
      this.fkProductsId,
      this.fkOffersId,
      this.fkChoicesId,
      this.ordersItemsPrice,
      this.ordersItemsPriceBeforeSale,
      this.ordersItemsCount,
      this.ordersItemsTotal,
      this.choice,
      this.customerRequest,
      this.product,
      this.offer,
      this.checked = false});

  int? ordersItemsId;
  String? fkOrdersId;
  String? fkProductsId;
  dynamic fkOffersId;
  String? fkChoicesId;
  String? ordersItemsPrice;
  String? ordersItemsPriceBeforeSale;
  String? ordersItemsCount;
  String? ordersItemsTotal;
  AttributeProductsChoice? choice;
  dynamic customerRequest;
  ProductClass? product;
  Offer? offer;
  bool? checked;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        ordersItemsId:
            json["orders_items_id"] == null ? null : json["orders_items_id"],
        fkOrdersId: json["FK_orders_id"] == null ? null : json["FK_orders_id"],
        fkProductsId:
            json["FK_products_id"] == null ? null : json["FK_products_id"],
        fkOffersId: json["FK_offers_id"],
        fkChoicesId:
            json["FK_choices_id"] == null ? null : json["FK_choices_id"],
        ordersItemsPrice: json["orders_items_price"] == null
            ? null
            : json["orders_items_price"],
        ordersItemsPriceBeforeSale:
            json["orders_items_price_before_sale"] == null
                ? null
                : json["orders_items_price_before_sale"],
        ordersItemsCount: json["orders_items_count"] == null
            ? null
            : json["orders_items_count"],
        ordersItemsTotal: json["orders_items_total"] == null
            ? null
            : json["orders_items_total"],
        choice: json["choice"] == null
            ? null
            : AttributeProductsChoice.fromJson(json["choice"]),
        customerRequest: json["customer_request"],
        product: json["product"] == null
            ? null
            : ProductClass.fromJson(json["product"]),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
      );

  Map<String, dynamic> toJson() => {
        "orders_items_id": ordersItemsId == null ? null : ordersItemsId,
        "FK_orders_id": fkOrdersId == null ? null : fkOrdersId,
        "FK_products_id": fkProductsId == null ? null : fkProductsId,
        "FK_offers_id": fkOffersId,
        "FK_choices_id": fkChoicesId == null ? null : fkChoicesId,
        "orders_items_price":
            ordersItemsPrice == null ? null : ordersItemsPrice,
        "orders_items_price_before_sale": ordersItemsPriceBeforeSale == null
            ? null
            : ordersItemsPriceBeforeSale,
        "orders_items_count":
            ordersItemsCount == null ? null : ordersItemsCount,
        "orders_items_total":
            ordersItemsTotal == null ? null : ordersItemsTotal,
        "choice": choice == null ? null : choice!.toJson(),
        "customer_request": customerRequest,
        "product": product == null ? null : product!.toJson(),
        "offer": offer == null ? null : offer!.toJson(),
      };
}

class OrderDetailsRating {
  OrderDetailsRating({
    this.ratingsId,
    this.clientsId,
    this.ordersId,
    this.ratingsService,
    this.ratingsDelivery,
    this.ratingsValue,
    this.ratingsText,
    this.ratingsStatus,
    this.ratingsCreatedAt,
    this.ratingsUpdatedAt,
  });

  int? ratingsId;
  String? clientsId;
  String? ordersId;
  String? ratingsService;
  String? ratingsDelivery;
  String? ratingsValue;
  dynamic ratingsText;
  String? ratingsStatus;
  DateTime? ratingsCreatedAt;
  DateTime? ratingsUpdatedAt;

  factory OrderDetailsRating.fromJson(Map<String, dynamic> json) =>
      OrderDetailsRating(
        ratingsId: json["ratings_id"],
        clientsId: json["clients_id"],
        ordersId: json["orders_id"],
        ratingsService: json["ratings_service"],
        ratingsDelivery: json["ratings_delivery"],
        ratingsValue: json["ratings_value"],
        ratingsText: json["ratings_text"],
        ratingsStatus: json["ratings_status"],
        ratingsCreatedAt: json["ratings_created_at"] == null
            ? null
            : DateTime.parse(json["ratings_created_at"]),
        ratingsUpdatedAt: json["ratings_updated_at"] == null
            ? null
            : DateTime.parse(json["ratings_updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "ratings_id": ratingsId,
        "clients_id": clientsId,
        "orders_id": ordersId,
        "ratings_service": ratingsService,
        "ratings_delivery": ratingsDelivery,
        "ratings_value": ratingsValue,
        "ratings_text": ratingsText,
        "ratings_status": ratingsStatus,
        "ratings_created_at": ratingsCreatedAt == null
            ? null
            : ratingsCreatedAt!.toIso8601String(),
        "ratings_updated_at": ratingsUpdatedAt == null
            ? null
            : ratingsUpdatedAt!.toIso8601String(),
      };
}

class ShippingMethod {
  ShippingMethod({
    this.shippingMethodsId,
    this.fkAccountsId,
    this.shippingMethodsOrderLimit,
    this.shippingMethodsDeliveryCost,
    this.shippingMethodsStatus,
    this.shippingMethodsPosition,
    this.shippingMethodsCreatedAt,
    this.shippingMethodsUpdatedAt,
    this.shippingMethodsTitle,
    this.shippingMethodsText,
    this.translations,
  });

  int? shippingMethodsId;
  String? fkAccountsId;
  dynamic shippingMethodsOrderLimit;
  String? shippingMethodsDeliveryCost;
  String? shippingMethodsStatus;
  String? shippingMethodsPosition;
  DateTime? shippingMethodsCreatedAt;
  DateTime? shippingMethodsUpdatedAt;
  String? shippingMethodsTitle;
  String? shippingMethodsText;
  List<ShippingMethodTranslation>? translations;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
        shippingMethodsId: json["shipping_methods_id"] == null
            ? null
            : json["shipping_methods_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        shippingMethodsOrderLimit: json["shipping_methods_order_limit"],
        shippingMethodsDeliveryCost:
            json["shipping_methods_delivery_cost"] == null
                ? null
                : json["shipping_methods_delivery_cost"],
        shippingMethodsStatus: json["shipping_methods_status"] == null
            ? null
            : json["shipping_methods_status"],
        shippingMethodsPosition: json["shipping_methods_position"] == null
            ? null
            : json["shipping_methods_position"],
        shippingMethodsCreatedAt: json["shipping_methods_created_at"] == null
            ? null
            : DateTime.parse(json["shipping_methods_created_at"]),
        shippingMethodsUpdatedAt: json["shipping_methods_updated_at"] == null
            ? null
            : DateTime.parse(json["shipping_methods_updated_at"]),
        shippingMethodsTitle: json["shipping_methods_title"] == null
            ? null
            : json["shipping_methods_title"],
        shippingMethodsText: json["shipping_methods_text"] == null
            ? null
            : json["shipping_methods_text"],
        translations: json["translations"] == null
            ? null
            : List<ShippingMethodTranslation>.from(json["translations"]
                .map((x) => ShippingMethodTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shipping_methods_id":
            shippingMethodsId == null ? null : shippingMethodsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "shipping_methods_order_limit": shippingMethodsOrderLimit,
        "shipping_methods_delivery_cost": shippingMethodsDeliveryCost == null
            ? null
            : shippingMethodsDeliveryCost,
        "shipping_methods_status":
            shippingMethodsStatus == null ? null : shippingMethodsStatus,
        "shipping_methods_position":
            shippingMethodsPosition == null ? null : shippingMethodsPosition,
        "shipping_methods_created_at": shippingMethodsCreatedAt == null
            ? null
            : shippingMethodsCreatedAt!.toIso8601String(),
        "shipping_methods_updated_at": shippingMethodsUpdatedAt == null
            ? null
            : shippingMethodsUpdatedAt!.toIso8601String(),
        "shipping_methods_title":
            shippingMethodsTitle == null ? null : shippingMethodsTitle,
        "shipping_methods_text":
            shippingMethodsText == null ? null : shippingMethodsText,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class ShippingMethodTranslation {
  ShippingMethodTranslation({
    this.shippingMethodsTransId,
    this.shippingMethodsId,
    this.locale,
    this.shippingMethodsTitle,
    this.shippingMethodsText,
  });

  int? shippingMethodsTransId;
  String? shippingMethodsId;
  String? locale;
  String? shippingMethodsTitle;
  String? shippingMethodsText;

  factory ShippingMethodTranslation.fromJson(Map<String, dynamic> json) =>
      ShippingMethodTranslation(
        shippingMethodsTransId: json["shipping_methods_trans_id"] == null
            ? null
            : json["shipping_methods_trans_id"],
        shippingMethodsId: json["shipping_methods_id"] == null
            ? null
            : json["shipping_methods_id"],
        locale: json["locale"] == null ? null : json["locale"],
        shippingMethodsTitle: json["shipping_methods_title"] == null
            ? null
            : json["shipping_methods_title"],
        shippingMethodsText: json["shipping_methods_text"] == null
            ? null
            : json["shipping_methods_text"],
      );

  Map<String, dynamic> toJson() => {
        "shipping_methods_trans_id":
            shippingMethodsTransId == null ? null : shippingMethodsTransId,
        "shipping_methods_id":
            shippingMethodsId == null ? null : shippingMethodsId,
        "locale": locale == null ? null : locale,
        "shipping_methods_title":
            shippingMethodsTitle == null ? null : shippingMethodsTitle,
        "shipping_methods_text":
            shippingMethodsText == null ? null : shippingMethodsText,
      };
}

class Payment {
  Payment({
    this.paymentsId,
    this.fkAccountsId,
    this.paymentsSlug,
    this.paymentsCredentials,
    this.paymentsStatus,
    this.paymentsName,
    this.translations,
  });

  int? paymentsId;
  String? fkAccountsId;
  String? paymentsSlug;
  PaymentsCredentials? paymentsCredentials;
  String? paymentsStatus;
  String? paymentsName;
  List<PaymentTranslation>? translations;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentsId: json["payments_id"] == null ? null : json["payments_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        paymentsSlug:
            json["payments_slug"] == null ? null : json["payments_slug"],
        paymentsCredentials: json["payments_credentials"] == null
            ? null
            : PaymentsCredentials.fromJson(json["payments_credentials"]),
        paymentsStatus:
            json["payments_status"] == null ? null : json["payments_status"],
        paymentsName:
            json["payments_name"] == null ? null : json["payments_name"],
        translations: json["translations"] == null
            ? null
            : List<PaymentTranslation>.from(json["translations"]
                .map((x) => PaymentTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payments_id": paymentsId == null ? null : paymentsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "payments_slug": paymentsSlug == null ? null : paymentsSlug!,
        "payments_credentials":
            paymentsCredentials == null ? null : paymentsCredentials!.toJson(),
        "payments_status": paymentsStatus == null ? null : paymentsStatus,
        "payments_name": paymentsName == null ? null : paymentsName!,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class PaymentsCredentials {
  PaymentsCredentials({
    this.mid,
    this.tid,
    this.secureHash,
    this.returnUrl,
    this.url,
  });

  String? mid;
  String? tid;
  String? secureHash;
  String? returnUrl;
  String? url;

  factory PaymentsCredentials.fromJson(Map<String, dynamic> json) =>
      PaymentsCredentials(
        mid: json["MID"] == null ? null : json["MID"],
        tid: json["TID"] == null ? null : json["TID"],
        secureHash: json["SecureHash"] == null ? null : json["SecureHash"],
        returnUrl: json["return_url"] == null ? null : json["return_url"],
        url: json["Url"] == null ? null : json["Url"],
      );

  Map<String, dynamic> toJson() => {
        "MID": mid == null ? null : mid,
        "TID": tid == null ? null : tid,
        "SecureHash": secureHash == null ? null : secureHash,
        "return_url": returnUrl == null ? null : returnUrl,
        "Url": url == null ? null : url,
      };
}

class PaymentTranslation {
  PaymentTranslation({
    this.paymentsTransId,
    this.paymentsId,
    this.locale,
    this.paymentsName,
  });

  int? paymentsTransId;
  String? paymentsId;
  String? locale;
  String? paymentsName;

  factory PaymentTranslation.fromJson(Map<String, dynamic> json) =>
      PaymentTranslation(
        paymentsTransId: json["payments_trans_id"] == null
            ? null
            : json["payments_trans_id"],
        paymentsId: json["payments_id"] == null ? null : json["payments_id"],
        locale: json["locale"] == null ? null : json["locale"],
        paymentsName:
            json["payments_name"] == null ? null : json["payments_name"],
      );

  Map<String, dynamic> toJson() => {
        "payments_trans_id": paymentsTransId == null ? null : paymentsTransId,
        "payments_id": paymentsId == null ? null : paymentsId,
        "locale": locale == null ? null : locale!,
        "payments_name": paymentsName == null ? null : paymentsName!,
      };
}

class OrderReturnModel {
  OrderReturnModel(
      {this.orderReturnRequestsId,
      this.fkOrdersId,
      this.fkAccountsId,
      this.fkCustomersId,
      this.orderReturnRequestsReason,
      this.orderReturnRequestsStatus,
      this.orderReturnRequestsResponseNotes,
      this.orderReturnRequestsCreatedAt,
      this.orderReturnRequestsUpdatedAt,
      this.account,
      this.fkItemsIds});

  int? orderReturnRequestsId;
  String? fkOrdersId;
  String? fkAccountsId;
  String? fkItemsIds;
  String? fkCustomersId;
  String? orderReturnRequestsReason;
  String? orderReturnRequestsStatus;
  dynamic orderReturnRequestsResponseNotes;
  DateTime? orderReturnRequestsCreatedAt;
  DateTime? orderReturnRequestsUpdatedAt;
  Account? account;

  factory OrderReturnModel.fromJson(Map<String, dynamic> json) =>
      OrderReturnModel(
        orderReturnRequestsId: json["order_return_requests_id"] == null
            ? null
            : json["order_return_requests_id"],
        fkOrdersId: json["FK_orders_id"] == null ? null : json["FK_orders_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkItemsIds: json["FK_items_ids"] == null ? null : json["FK_items_ids"],
        fkCustomersId:
            json["FK_customers_id"] == null ? null : json["FK_customers_id"],
        orderReturnRequestsReason: json["order_return_requests_reason"] == null
            ? null
            : json["order_return_requests_reason"],
        orderReturnRequestsStatus: json["order_return_requests_status"] == null
            ? null
            : json["order_return_requests_status"],
        orderReturnRequestsResponseNotes:
            json["order_return_requests_response_notes"],
        orderReturnRequestsCreatedAt:
            json["order_return_requests_created_at"] == null
                ? null
                : DateTime.parse(json["order_return_requests_created_at"]),
        orderReturnRequestsUpdatedAt:
            json["order_return_requests_updated_at"] == null
                ? null
                : DateTime.parse(json["order_return_requests_updated_at"]),
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "order_return_requests_id":
            orderReturnRequestsId == null ? null : orderReturnRequestsId,
        "FK_orders_id": fkOrdersId == null ? null : fkOrdersId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_customers_id": fkCustomersId == null ? null : fkCustomersId,
        "FK_items_ids": fkItemsIds == null ? null : fkItemsIds,
        "order_return_requests_reason": orderReturnRequestsReason == null
            ? null
            : orderReturnRequestsReason,
        "order_return_requests_status": orderReturnRequestsStatus == null
            ? null
            : orderReturnRequestsStatus,
        "order_return_requests_response_notes":
            orderReturnRequestsResponseNotes,
        "order_return_requests_created_at": orderReturnRequestsCreatedAt == null
            ? null
            : orderReturnRequestsCreatedAt!.toIso8601String(),
        "order_return_requests_updated_at": orderReturnRequestsUpdatedAt == null
            ? null
            : orderReturnRequestsUpdatedAt!.toIso8601String(),
        "account": account == null ? null : account!.toJson(),
      };
}
