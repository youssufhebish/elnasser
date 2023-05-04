import 'dart:convert';
import 'package:elnasser/models/home_model/atributes.dart';
import 'package:elnasser/models/home_model/offers.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import '../account_model.dart';
import '../cart_item_model.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  List<String>? errors;
  Data? data;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
  Data({this.cart, this.errors});

  Cart? cart;
  List<String>? errors;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
        errors: json["errors"] == null
            ? null
            : List<String>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cart": cart == null ? null : cart!.toJson(),
        "errors":
            errors == null ? null : List<dynamic>.from(errors!.map((x) => x)),
      };
}

class Cart {
  Cart({
    this.cartsId,
    this.fkAccountsId,
    this.fkBranchesId,
    this.fkAreasId,
    this.fkCustomersId,
    this.fkPaymentsId,
    this.fkShippingMethodsId,
    this.cartsPrice,
    this.cartsDeliveryCost,
    this.cartsFinalCost,
    this.cartsNotes,
    this.cartsNotesForItems,
    this.cartsDeliveryAddress,
    this.cartsPaymentMethod,
    this.cartsGps,
    this.cartsImg,
    this.shopsId,
    this.cartsPhone,
    this.cartsProductsTotalCount,
    this.cartsVat,
    this.cartsNumberPoints,
    this.cartsDiscountPoints,
    this.deliveryTimesId,
    this.isDelivery,
    this.deviceToken,
    this.cartsCreatedAt,
    this.cartsUpdatedAt,
    this.fkCouponsId,
    this.couponsValue,
    this.couponsCode,
    this.couponsType,
    this.items,
    this.account,
  });

  int? cartsId;
  String? fkAccountsId;
  String? fkBranchesId;
  dynamic fkAreasId;
  dynamic fkCustomersId;
  dynamic fkPaymentsId;
  dynamic fkShippingMethodsId;
  String? cartsPrice;
  String? cartsDeliveryCost;
  String? cartsFinalCost;
  dynamic cartsNotes;
  dynamic cartsNotesForItems;
  dynamic cartsDeliveryAddress;
  dynamic cartsPaymentMethod;
  dynamic cartsGps;
  dynamic cartsImg;
  dynamic shopsId;
  dynamic cartsPhone;
  dynamic cartsProductsTotalCount;
  String? cartsVat;
  dynamic cartsNumberPoints;
  dynamic cartsDiscountPoints;
  dynamic deliveryTimesId;
  String? isDelivery;
  String? deviceToken;
  DateTime? cartsCreatedAt;
  DateTime? cartsUpdatedAt;
  dynamic fkCouponsId;
  dynamic couponsValue;
  dynamic couponsCode;
  dynamic couponsType;
  List<CartItemsModel>? items;
  Account? account;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cartsId: json["carts_id"] == null ? null : json["carts_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkBranchesId:
            json["FK_branches_id"] == null ? null : json["FK_branches_id"],
        fkAreasId: json["FK_areas_id"],
        fkCustomersId: json["FK_customers_id"],
        fkPaymentsId: json["FK_payments_id"],
        fkShippingMethodsId: json["FK_shipping_methods_id"],
        cartsPrice: json["carts_price"] == null ? null : json["carts_price"],
        cartsDeliveryCost: json["carts_delivery_cost"] == null
            ? null
            : json["carts_delivery_cost"],
        cartsFinalCost:
            json["carts_final_cost"] == null ? null : json["carts_final_cost"],
        cartsNotes: json["carts_notes"],
        cartsNotesForItems: json["carts_notes_for_items"],
        cartsDeliveryAddress: json["carts_delivery_address"],
        cartsPaymentMethod: json["carts_payment_method"],
        cartsGps: json["carts_gps"],
        cartsImg: json["carts_img"],
        shopsId: json["shops_id"],
        cartsPhone: json["carts_phone"],
        cartsProductsTotalCount: json["carts_products_total_count"] == null
            ? null
            : json["carts_products_total_count"],
        cartsVat: json["carts_vat"] == null ? null : json["carts_vat"],
        cartsNumberPoints: json["carts_number_points"] == null
            ? null
            : json["carts_number_points"],
        cartsDiscountPoints: json["carts_total_order_products_points"],
        deliveryTimesId: json["delivery_times_id"],
        isDelivery: json["is_delivery"] == null ? null : json["is_delivery"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        cartsCreatedAt: json["carts_created_at"] == null
            ? null
            : DateTime.parse(json["carts_created_at"]),
        cartsUpdatedAt: json["carts_updated_at"] == null
            ? null
            : DateTime.parse(json["carts_updated_at"]),
        fkCouponsId: json["FK_coupons_id"],
        couponsValue: json["carts_discount_value"],
        couponsCode: json["coupons_code"],
        couponsType: json["coupons_type"],
        items: json["items"] == null
            ? null
            : List<CartItemsModel>.from(
                json["items"].map((x) => CartItemsModel.fromJson(x))),
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "carts_id": cartsId == null ? null : cartsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_branches_id": fkBranchesId == null ? null : fkBranchesId,
        "FK_areas_id": fkAreasId,
        "FK_customers_id": fkCustomersId,
        "FK_payments_id": fkPaymentsId,
        "FK_shipping_methods_id": fkShippingMethodsId,
        "carts_price": cartsPrice == null ? null : cartsPrice,
        "carts_delivery_cost":
            cartsDeliveryCost == null ? null : cartsDeliveryCost,
        "carts_final_cost": cartsFinalCost == null ? null : cartsFinalCost,
        "carts_notes": cartsNotes,
        "carts_notes_for_items": cartsNotesForItems,
        "carts_delivery_address": cartsDeliveryAddress,
        "carts_payment_method": cartsPaymentMethod,
        "carts_gps": cartsGps,
        "carts_img": cartsImg,
        "shops_id": shopsId,
        "carts_phone": cartsPhone,
        "carts_products_total_count":
            cartsProductsTotalCount == null ? null : cartsProductsTotalCount,
        "carts_vat": cartsVat == null ? null : cartsVat,
        "carts_number_points":
            cartsNumberPoints == null ? null : cartsNumberPoints,
        "carts_total_order_products_points": cartsDiscountPoints,
        "delivery_times_id": deliveryTimesId,
        "is_delivery": isDelivery == null ? null : isDelivery,
        "device_token": deviceToken == null ? null : deviceToken,
        "carts_created_at":
            cartsCreatedAt == null ? null : cartsCreatedAt!.toIso8601String(),
        "carts_updated_at":
            cartsUpdatedAt == null ? null : cartsUpdatedAt!.toIso8601String(),
        "FK_coupons_id": fkCouponsId,
        "carts_discount_value": couponsValue,
        "coupons_code": couponsCode,
        "coupons_type": couponsType,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "account": account == null ? null : account!.toJson(),
      };
}
