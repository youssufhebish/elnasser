// To parse this JSON data, do
//
//     final postOrderResponseModel = postOrderResponseModelFromJson(jsonString);

import 'dart:convert';

import '../account_model.dart';

PostOrderResponseModel postOrderResponseModelFromJson(String str) =>
    PostOrderResponseModel.fromJson(json.decode(str));

String postOrderResponseModelToJson(PostOrderResponseModel data) =>
    json.encode(data.toJson());

class PostOrderResponseModel {
  PostOrderResponseModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory PostOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      PostOrderResponseModel(
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
    this.order,
    this.url,
  });

  Order? order;
  String? url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "order": order == null ? null : order!.toJson(),
        "url": url == null ? null : url,
      };
}

class Order {
  Order({
    this.fkAccountsId,
    this.fkBranchesId,
    this.fkAreasId,
    this.fkCustomersId,
    this.fkPaymentsId,
    this.ordersNotes,
    this.ordersNotesForItems,
    this.ordersDeliveryAddress,
    this.ordersGps,
    this.ordersImg,
    this.ordersPaymentMethod,
    this.ordersDeliveryCost,
    this.fkShippingMethodsId,
    this.ordersPrice,
    this.ordersFinalCost,
    this.fkCouponsId,
    this.couponsValue,
    this.couponsCode,
    this.couponsType,
    this.ordersPhone,
    this.ordersProductsTotalCount,
    this.ordersVat,
    this.ordersNumberPoints,
    this.ordersDiscountPoints,
    this.deliveryTimesId,
    this.isDelivery,
    this.ordersUpdatedAt,
    this.ordersCreatedAt,
    this.ordersId,
    this.payment,
    this.account,
  });

  dynamic fkAccountsId;
  dynamic fkBranchesId;
  dynamic fkAreasId;
  dynamic fkCustomersId;
  String? fkPaymentsId;
  dynamic ordersNotes;
  dynamic ordersNotesForItems;
  String? ordersDeliveryAddress;
  String? ordersGps;
  dynamic ordersImg;
  String? ordersPaymentMethod;
  String? ordersDeliveryCost;
  String? fkShippingMethodsId;
  String? ordersPrice;
  String? ordersFinalCost;
  dynamic fkCouponsId;
  dynamic couponsValue;
  dynamic couponsCode;
  dynamic couponsType;
  String? ordersPhone;
  dynamic ordersProductsTotalCount;
  String? ordersVat;
  dynamic ordersNumberPoints;
  dynamic ordersDiscountPoints;
  dynamic deliveryTimesId;
  String? isDelivery;
  DateTime? ordersUpdatedAt;
  DateTime? ordersCreatedAt;
  int? ordersId;
  Payment? payment;
  Account? account;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkBranchesId:
            json["FK_branches_id"] == null ? null : json["FK_branches_id"],
        fkAreasId: json["FK_areas_id"],
        fkCustomersId:
            json["FK_customers_id"] == null ? null : json["FK_customers_id"],
        fkPaymentsId:
            json["FK_payments_id"] == null ? null : json["FK_payments_id"],
        ordersNotes: json["orders_notes"],
        ordersNotesForItems: json["orders_notes_for_items"],
        ordersDeliveryAddress: json["orders_delivery_address"] == null
            ? null
            : json["orders_delivery_address"],
        ordersGps: json["orders_gps"] == null ? null : json["orders_gps"],
        ordersImg: json["orders_img"],
        ordersPaymentMethod: json["orders_payment_method"] == null
            ? null
            : json["orders_payment_method"],
        ordersDeliveryCost: json["orders_delivery_cost"] == null
            ? null
            : json["orders_delivery_cost"],
        fkShippingMethodsId: json["FK_shipping_methods_id"] == null
            ? null
            : json["FK_shipping_methods_id"],
        ordersPrice: json["orders_price"] == null ? null : json["orders_price"],
        ordersFinalCost: json["orders_final_cost"] == null
            ? null
            : json["orders_final_cost"],
        fkCouponsId: json["FK_coupons_id"],
        couponsValue: json["coupons_value"],
        couponsCode: json["coupons_code"],
        couponsType: json["coupons_type"],
        ordersPhone: json["orders_phone"] == null ? null : json["orders_phone"],
        ordersProductsTotalCount: json["orders_products_total_count"] == null
            ? null
            : json["orders_products_total_count"],
        ordersVat: json["orders_vat"] == null ? null : json["orders_vat"],
        ordersNumberPoints: json["orders_number_points"] == null
            ? null
            : json["orders_number_points"],
        ordersDiscountPoints: json["orders_discount_points"],
        deliveryTimesId: json["delivery_times_id"],
        isDelivery: json["is_delivery"] == null ? null : json["is_delivery"],
        ordersUpdatedAt: json["orders_updated_at"] == null
            ? null
            : DateTime.parse(json["orders_updated_at"]),
        ordersCreatedAt: json["orders_created_at"] == null
            ? null
            : DateTime.parse(json["orders_created_at"]),
        ordersId: json["orders_id"] == null ? null : json["orders_id"],
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_branches_id": fkBranchesId == null ? null : fkBranchesId,
        "FK_areas_id": fkAreasId,
        "FK_customers_id": fkCustomersId == null ? null : fkCustomersId,
        "FK_payments_id": fkPaymentsId == null ? null : fkPaymentsId,
        "orders_notes": ordersNotes,
        "orders_notes_for_items": ordersNotesForItems,
        "orders_delivery_address":
            ordersDeliveryAddress == null ? null : ordersDeliveryAddress,
        "orders_gps": ordersGps == null ? null : ordersGps,
        "orders_img": ordersImg,
        "orders_payment_method":
            ordersPaymentMethod == null ? null : ordersPaymentMethod,
        "orders_delivery_cost":
            ordersDeliveryCost == null ? null : ordersDeliveryCost,
        "FK_shipping_methods_id":
            fkShippingMethodsId == null ? null : fkShippingMethodsId,
        "orders_price": ordersPrice == null ? null : ordersPrice,
        "orders_final_cost": ordersFinalCost == null ? null : ordersFinalCost,
        "FK_coupons_id": fkCouponsId,
        "coupons_value": couponsValue,
        "coupons_code": couponsCode,
        "coupons_type": couponsType,
        "orders_phone": ordersPhone == null ? null : ordersPhone,
        "orders_products_total_count":
            ordersProductsTotalCount == null ? null : ordersProductsTotalCount,
        "orders_vat": ordersVat == null ? null : ordersVat,
        "orders_number_points":
            ordersNumberPoints == null ? null : ordersNumberPoints,
        "orders_discount_points": ordersDiscountPoints,
        "delivery_times_id": deliveryTimesId,
        "is_delivery": isDelivery == null ? null : isDelivery,
        "orders_updated_at":
            ordersUpdatedAt == null ? null : ordersUpdatedAt!.toIso8601String(),
        "orders_created_at":
            ordersCreatedAt == null ? null : ordersCreatedAt!.toIso8601String(),
        "orders_id": ordersId == null ? null : ordersId,
        "payment": payment == null ? null : payment!.toJson(),
        "account": account == null ? null : account!.toJson(),
      };
}

class Payment {
  Payment({
    this.paymentsId,
    this.paymentsName,
    this.translations,
  });

  int? paymentsId;
  String? paymentsName;
  List<PaymentTranslation>? translations;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentsId: json["payments_id"] == null ? null : json["payments_id"],
        paymentsName:
            json["payments_name"] == null ? null : json["payments_name"],
        translations: json["translations"] == null
            ? null
            : List<PaymentTranslation>.from(json["translations"]
                .map((x) => PaymentTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payments_id": paymentsId == null ? null : paymentsId,
        "payments_name": paymentsName == null ? null : paymentsName,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
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
        "locale": locale == null ? null : locale,
        "payments_name": paymentsName == null ? null : paymentsName,
      };
}
