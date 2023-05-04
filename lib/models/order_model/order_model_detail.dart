// To parse this JSON data, do
//
//     final orderModelDetail = orderModelDetailFromJson(jsonString);

import 'dart:convert';

import 'package:elnasser/models/rating/get_rating.dart';

import '../account_model.dart';
import 'order_model.dart';

OrderModelDetail orderModelDetailFromJson(String str) =>
    OrderModelDetail.fromJson(json.decode(str));

String orderModelDetailToJson(OrderModelDetail data) =>
    json.encode(data.toJson());

class OrderModelDetail {
  OrderModelDetail({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory OrderModelDetail.fromJson(Map<String, dynamic> json) =>
      OrderModelDetail(
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
  Data({this.order, this.productRating, this.shippingStatus});
  String? shippingStatus;

  Order? order;
  List<RatingProduct>? productRating;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        productRating: json["products_rating"] == null
            ? null
            : List<RatingProduct>.from(
                json["products_rating"].map((x) => RatingProduct.fromJson(x))),
        shippingStatus: json["shipping_status"] ?? json["shipping_status"],
      );

  Map<String, dynamic> toJson() => {
        "order": order == null ? null : order!.toJson(),
        "products_rating": productRating == null
            ? null
            : List<dynamic>.from(productRating!.map((x) => x.toJson())),
        "shipping_status": shippingStatus ?? null,
      };
}

class Order {
  Order(
      {this.ordersId,
      this.fkAccountsId,
      this.fkBranchesId,
      this.fkAreasId,
      this.fkCustomersId,
      this.fkPaymentsId,
      this.fkShippingMethodsId,
      this.ordersPrice,
      this.ordersDeliveryCost,
      this.ordersFinalCost,
      this.ordersNotes,
      this.ordersNotesForItems,
      this.ordersDeliveryAddress,
      this.ordersPaymentMethod,
      this.ordersGps,
      this.ordersImg,
      this.ordersImgPrice,
      this.ordersStatus,
      this.ordersPaymentStatus,
      this.ordersRead,
      this.ordersTimeTaken,
      this.ordersFollowDeliveryTime,
      this.shopsId,
      this.ordersPhone,
      this.ordersProductsTotalCount,
      this.ordersVat,
      this.ordersNumberPoints,
      this.ordersDiscountPoints,
      this.deliveryTimesId,
      this.isDelivery,
      this.ordersFullResponseUrl,
      this.ordersTotalPayment,
      this.ordersCreatedAt,
      this.ordersUpdatedAt,
      this.fkCouponsId,
      this.couponsValue,
      this.couponsCode,
      this.couponsType,
      this.items,
      this.contacts,
      this.payment,
      this.account,
      this.shippingMethod,
      this.orderReturnModel,
      this.ordersDiscountValue,
      this.ordersTotalOrderProductsPoints,
      this.orderDetailsRating,
      this.ordersNo,
      this.deletedItems,
      this.refundedItems,
      this.shipping});
  String? ordersTotalOrderProductsPoints;

  dynamic ordersDiscountValue;
  int? ordersId;
  dynamic ordersNo;
  String? fkAccountsId;
  String? fkBranchesId;
  dynamic fkAreasId;
  String? fkCustomersId;
  String? fkPaymentsId;
  String? fkShippingMethodsId;
  String? ordersPrice;
  String? ordersDeliveryCost;
  String? ordersFinalCost;
  dynamic ordersNotes;
  dynamic ordersNotesForItems;
  String? ordersDeliveryAddress;
  String? ordersPaymentMethod;
  String? ordersGps;
  dynamic ordersImg;
  dynamic ordersImgPrice;
  String? ordersStatus;
  String? ordersPaymentStatus;
  String? ordersRead;
  dynamic ordersTimeTaken;
  String? ordersFollowDeliveryTime;
  dynamic shopsId;
  String? ordersPhone;
  String? ordersProductsTotalCount;
  String? ordersVat;
  String? ordersNumberPoints;
  dynamic ordersDiscountPoints;
  dynamic deliveryTimesId;
  String? isDelivery;
  dynamic ordersFullResponseUrl;
  dynamic ordersTotalPayment;
  DateTime? ordersCreatedAt;
  DateTime? ordersUpdatedAt;
  String? fkCouponsId;
  String? couponsValue;
  String? couponsCode;
  String? couponsType;
  List<OrderItemModel>? items;
  List<OrderItemModel>? refundedItems;
  List<OrderItemModel>? deletedItems;
  List<dynamic>? contacts;
  Payment? payment;
  ShippingMethod? shippingMethod;
  OrderDetailsRating? orderDetailsRating;
  Account? account;
  dynamic shipping;
  OrderReturnModel? orderReturnModel;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        ordersDiscountValue: json["orders_discount_value"],
        ordersId: json["orders_id"] == null ? null : json["orders_id"],
        shipping: json["shipping"] == null ? null : json["shipping"],
        ordersNo: json["orders_no"] == null ? null : json["orders_no"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkBranchesId:
            json["FK_branches_id"] == null ? null : json["FK_branches_id"],
        fkAreasId: json["FK_areas_id"],
        fkCustomersId:
            json["FK_customers_id"] == null ? null : json["FK_customers_id"],
        fkPaymentsId:
            json["FK_payments_id"] == null ? null : json["FK_payments_id"],
        fkShippingMethodsId: json["FK_shipping_methods_id"] == null
            ? null
            : json["FK_shipping_methods_id"],
        ordersPrice: json["orders_price"] == null ? null : json["orders_price"],
        ordersDeliveryCost: json["orders_delivery_cost"] == null
            ? null
            : json["orders_delivery_cost"],
        ordersFinalCost: json["orders_final_cost"] == null
            ? null
            : json["orders_final_cost"],
        ordersNotes: json["orders_notes"],
        ordersNotesForItems: json["orders_notes_for_items"],
        ordersDeliveryAddress: json["orders_delivery_address"] == null
            ? null
            : json["orders_delivery_address"],
        ordersPaymentMethod: json["orders_payment_method"] == null
            ? null
            : json["orders_payment_method"],
        ordersGps: json["orders_gps"] == null ? null : json["orders_gps"],
        ordersImg: json["orders_img"],
        ordersImgPrice: json["orders_img_price"],
        ordersStatus:
            json["orders_status"] == null ? null : json["orders_status"],
        ordersPaymentStatus: json["orders_payment_status"] == null
            ? null
            : json["orders_payment_status"],
        ordersRead: json["orders_read"] == null ? null : json["orders_read"],
        ordersTimeTaken: json["orders_time_taken"],
        ordersFollowDeliveryTime: json["orders_follow_delivery_time"] == null
            ? null
            : json["orders_follow_delivery_time"],
        shopsId: json["shops_id"],
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
        ordersFullResponseUrl: json["orders_full_response_url"],
        ordersTotalPayment: json["orders_total_payment"],
        ordersCreatedAt: json["orders_created_at"] == null
            ? null
            : DateTime.parse(json["orders_created_at"]),
        ordersUpdatedAt: json["orders_updated_at"] == null
            ? null
            : DateTime.parse(json["orders_updated_at"]),
        fkCouponsId:
            json["FK_coupons_id"] == null ? null : json["FK_coupons_id"],
        couponsValue:
            json["coupons_value"] == null ? null : json["coupons_value"],
        couponsCode: json["coupons_code"] == null ? null : json["coupons_code"],
        couponsType: json["coupons_type"] == null ? null : json["coupons_type"],
        items: json["items"] == null
            ? null
            : List<OrderItemModel>.from(
                json["items"].map((x) => OrderItemModel.fromJson(x))),
        refundedItems: json["refunded_items"] == null
            ? null
            : List<OrderItemModel>.from(
                json["refunded_items"].map((x) => OrderItemModel.fromJson(x))),
        deletedItems: json["deleted_items"] == null
            ? null
            : List<OrderItemModel>.from(
                json["deleted_items"].map((x) => OrderItemModel.fromJson(x))),
        contacts: json["contacts"] == null
            ? null
            : List<dynamic>.from(json["contacts"].map((x) => x)),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        shippingMethod: json["shipping_method"] == null
            ? null
            : ShippingMethod.fromJson(json["shipping_method"]),
        orderDetailsRating: json["rating"] == null
            ? null
            : OrderDetailsRating.fromJson(json["rating"]),
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        orderReturnModel: json["order_return"] == null
            ? null
            : OrderReturnModel.fromJson(json["order_return"]),
        ordersTotalOrderProductsPoints:
            json["orders_total_order_products_points"] == null
                ? null
                : json["orders_total_order_products_points"],
      );

  Map<String, dynamic> toJson() => {
        "orders_total_order_products_points":
            ordersTotalOrderProductsPoints == null
                ? null
                : ordersTotalOrderProductsPoints,
        "orders_discount_value": ordersDiscountValue,
        "orders_id": ordersId == null ? null : ordersId,
        "shipping": shipping == null ? null : shipping,
        "orders_no": ordersNo == null ? null : ordersNo,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_branches_id": fkBranchesId == null ? null : fkBranchesId,
        "FK_areas_id": fkAreasId,
        "FK_customers_id": fkCustomersId == null ? null : fkCustomersId,
        "FK_payments_id": fkPaymentsId == null ? null : fkPaymentsId,
        "FK_shipping_methods_id":
            fkShippingMethodsId == null ? null : fkShippingMethodsId,
        "orders_price": ordersPrice == null ? null : ordersPrice,
        "orders_delivery_cost":
            ordersDeliveryCost == null ? null : ordersDeliveryCost,
        "orders_final_cost": ordersFinalCost == null ? null : ordersFinalCost,
        "orders_notes": ordersNotes,
        "orders_notes_for_items": ordersNotesForItems,
        "orders_delivery_address":
            ordersDeliveryAddress == null ? null : ordersDeliveryAddress!,
        "orders_payment_method":
            ordersPaymentMethod == null ? null : ordersPaymentMethod!,
        "orders_gps": ordersGps == null ? null : ordersGps!,
        "orders_img": ordersImg,
        "orders_img_price": ordersImgPrice,
        "orders_status": ordersStatus == null ? null : ordersStatus,
        "orders_payment_status":
            ordersPaymentStatus == null ? null : ordersPaymentStatus,
        "orders_read": ordersRead == null ? null : ordersRead,
        "orders_time_taken": ordersTimeTaken,
        "orders_follow_delivery_time":
            ordersFollowDeliveryTime == null ? null : ordersFollowDeliveryTime,
        "shops_id": shopsId,
        "orders_phone": ordersPhone == null ? null : ordersPhone,
        "orders_products_total_count":
            ordersProductsTotalCount == null ? null : ordersProductsTotalCount,
        "orders_vat": ordersVat == null ? null : ordersVat,
        "orders_number_points":
            ordersNumberPoints == null ? null : ordersNumberPoints,
        "orders_discount_points": ordersDiscountPoints,
        "delivery_times_id": deliveryTimesId,
        "is_delivery": isDelivery == null ? null : isDelivery,
        "orders_full_response_url": ordersFullResponseUrl,
        "orders_total_payment": ordersTotalPayment,
        "orders_created_at":
            ordersCreatedAt == null ? null : ordersCreatedAt!.toIso8601String(),
        "orders_updated_at":
            ordersUpdatedAt == null ? null : ordersUpdatedAt!.toIso8601String(),
        "FK_coupons_id": fkCouponsId == null ? null : fkCouponsId,
        "coupons_value": couponsValue == null ? null : couponsValue,
        "coupons_code": couponsCode == null ? null : couponsCode,
        "coupons_type": couponsType == null ? null : couponsType,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "deleted_items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "refunded_items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "contacts": contacts == null
            ? null
            : List<dynamic>.from(contacts!.map((x) => x)),
        "payment": payment == null ? null : payment!.toJson(),
        "shipping_method":
            shippingMethod == null ? null : shippingMethod!.toJson(),
        "rating":
            orderDetailsRating == null ? null : orderDetailsRating!.toJson(),
        "account": account == null ? null : account!.toJson(),
        "order_return":
            orderReturnModel == null ? null : orderReturnModel!.toJson(),
      };
}

class Attribute {
  Attribute({
    this.attributesId,
    this.fkAccountsId,
    this.attributesCode,
    this.attributesImage,
    this.attributesStatus,
    this.attributesCreatedAt,
    this.attributesUpdatedAt,
    this.attributesTitle,
    this.translations,
  });

  int? attributesId;
  String? fkAccountsId;
  String? attributesCode;
  String? attributesImage;
  String? attributesStatus;
  DateTime? attributesCreatedAt;
  DateTime? attributesUpdatedAt;
  String? attributesTitle;
  List<AttributeTranslation>? translations;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        attributesId:
            json["attributes_id"] == null ? null : json["attributes_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        attributesCode:
            json["attributes_code"] == null ? null : json["attributes_code"],
        attributesImage:
            json["attributes_image"] == null ? null : json["attributes_image"],
        attributesStatus: json["attributes_status"] == null
            ? null
            : json["attributes_status"],
        attributesCreatedAt: json["attributes_created_at"] == null
            ? null
            : DateTime.parse(json["attributes_created_at"]),
        attributesUpdatedAt: json["attributes_updated_at"] == null
            ? null
            : DateTime.parse(json["attributes_updated_at"]),
        attributesTitle:
            json["attributes_title"] == null ? null : json["attributes_title"],
        translations: json["translations"] == null
            ? null
            : List<AttributeTranslation>.from(json["translations"]
                .map((x) => AttributeTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributes_id": attributesId == null ? null : attributesId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "attributes_code": attributesCode == null ? null : attributesCode,
        "attributes_image": attributesImage == null ? null : attributesImage,
        "attributes_status": attributesStatus == null ? null : attributesStatus,
        "attributes_created_at": attributesCreatedAt == null
            ? null
            : attributesCreatedAt!.toIso8601String(),
        "attributes_updated_at": attributesUpdatedAt == null
            ? null
            : attributesUpdatedAt!.toIso8601String(),
        "attributes_title": attributesTitle == null ? null : attributesTitle,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class AttributeTranslation {
  AttributeTranslation({
    this.attributesTransId,
    this.attributesId,
    this.locale,
    this.attributesTitle,
  });

  int? attributesTransId;
  String? attributesId;
  String? locale;
  String? attributesTitle;

  factory AttributeTranslation.fromJson(Map<String, dynamic> json) =>
      AttributeTranslation(
        attributesTransId: json["attributes_trans_id"] == null
            ? null
            : json["attributes_trans_id"],
        attributesId:
            json["attributes_id"] == null ? null : json["attributes_id"],
        locale: json["locale"] == null ? null : json["locale"],
        attributesTitle:
            json["attributes_title"] == null ? null : json["attributes_title"],
      );

  Map<String, dynamic> toJson() => {
        "attributes_trans_id":
            attributesTransId == null ? null : attributesTransId,
        "attributes_id": attributesId == null ? null : attributesId,
        "locale": locale == null ? null : locale,
        "attributes_title": attributesTitle == null ? null : attributesTitle,
      };
}

class ChoiceElement {
  ChoiceElement({
    this.choicesId,
    this.fkAccountsId,
    this.choicesCode,
    this.choicesParentId,
    this.choicesStatus,
    this.choicesPosition,
    this.choicesCreatedAt,
    this.choicesUpdatedAt,
    this.lft,
    this.rgt,
    this.depth,
    this.choicesTitle,
    this.translations,
  });

  int? choicesId;
  String? fkAccountsId;
  String? choicesCode;
  String? choicesParentId;
  String? choicesStatus;
  String? choicesPosition;
  DateTime? choicesCreatedAt;
  DateTime? choicesUpdatedAt;
  String? lft;
  String? rgt;
  String? depth;
  String? choicesTitle;
  List<ChoiceTranslation>? translations;

  factory ChoiceElement.fromJson(Map<String, dynamic> json) => ChoiceElement(
        choicesId: json["choices_id"] == null ? null : json["choices_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        choicesCode: json["choices_code"] == null ? null : json["choices_code"],
        choicesParentId: json["choices_parent_id"] == null
            ? null
            : json["choices_parent_id"],
        choicesStatus:
            json["choices_status"] == null ? null : json["choices_status"],
        choicesPosition:
            json["choices_position"] == null ? null : json["choices_position"],
        choicesCreatedAt: json["choices_created_at"] == null
            ? null
            : DateTime.parse(json["choices_created_at"]),
        choicesUpdatedAt: json["choices_updated_at"] == null
            ? null
            : DateTime.parse(json["choices_updated_at"]),
        lft: json["lft"] == null ? null : json["lft"],
        rgt: json["rgt"] == null ? null : json["rgt"],
        depth: json["depth"] == null ? null : json["depth"],
        choicesTitle:
            json["choices_title"] == null ? null : json["choices_title"],
        translations: json["translations"] == null
            ? null
            : List<ChoiceTranslation>.from(
                json["translations"].map((x) => ChoiceTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "choices_id": choicesId == null ? null : choicesId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "choices_code": choicesCode == null ? null : choicesCode,
        "choices_parent_id": choicesParentId == null ? null : choicesParentId,
        "choices_status": choicesStatus == null ? null : choicesStatus,
        "choices_position": choicesPosition == null ? null : choicesPosition,
        "choices_created_at": choicesCreatedAt == null
            ? null
            : choicesCreatedAt!.toIso8601String(),
        "choices_updated_at": choicesUpdatedAt == null
            ? null
            : choicesUpdatedAt!.toIso8601String(),
        "lft": lft == null ? null : lft,
        "rgt": rgt == null ? null : rgt,
        "depth": depth == null ? null : depth,
        "choices_title": choicesTitle == null ? null : choicesTitle,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class ChoiceTranslation {
  ChoiceTranslation({
    this.choicesTransId,
    this.choicesId,
    this.locale,
    this.choicesTitle,
  });

  int? choicesTransId;
  String? choicesId;
  String? locale;
  String? choicesTitle;

  factory ChoiceTranslation.fromJson(Map<String, dynamic> json) =>
      ChoiceTranslation(
        choicesTransId:
            json["choices_trans_id"] == null ? null : json["choices_trans_id"],
        choicesId: json["choices_id"] == null ? null : json["choices_id"],
        locale: json["locale"] == null ? null : json["locale"],
        choicesTitle:
            json["choices_title"] == null ? null : json["choices_title"],
      );

  Map<String, dynamic> toJson() => {
        "choices_trans_id": choicesTransId == null ? null : choicesTransId,
        "choices_id": choicesId == null ? null : choicesId,
        "locale": locale == null ? null : locale,
        "choices_title": choicesTitle == null ? null : choicesTitle,
      };
}

class Image {
  Image({
    this.productsImagesId,
    this.productsId,
    this.productsImagesName,
  });

  int? productsImagesId;
  String? productsId;
  String? productsImagesName;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        productsImagesId: json["products_images_id"] == null
            ? null
            : json["products_images_id"],
        productsId: json["products_id"] == null ? null : json["products_id"],
        productsImagesName: json["products_images_name"] == null
            ? null
            : json["products_images_name"],
      );

  Map<String, dynamic> toJson() => {
        "products_images_id":
            productsImagesId == null ? null : productsImagesId,
        "products_id": productsId == null ? null : productsId,
        "products_images_name":
            productsImagesName == null ? null : productsImagesName,
      };
}

class OfferOrderDetail {
  OfferOrderDetail({
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
    this.offersTitle,
    this.offersAlert,
    this.translations,
  });

  int? offersId;
  String? fkAccountsId;
  String? offersMainNumber;
  dynamic offersAdditionalNumber;
  String? offersDiscount;
  DateTime? offersFrom;
  DateTime? offersTo;
  String? offersStatus;
  String? accessLevel;
  String? offersImage;
  String? offersType;
  String? offersTitle;
  String? offersAlert;
  List<OfferTranslation>? translations;

  factory OfferOrderDetail.fromJson(Map<String, dynamic> json) =>
      OfferOrderDetail(
        offersId: json["offers_id"] == null ? null : json["offers_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        offersMainNumber: json["offers_main_number"] == null
            ? null
            : json["offers_main_number"],
        offersAdditionalNumber: json["offers_additional_number"],
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
        offersTitle: json["offers_title"] == null ? null : json["offers_title"],
        offersAlert: json["offers_alert"] == null ? null : json["offers_alert"],
        translations: json["translations"] == null
            ? null
            : List<OfferTranslation>.from(
                json["translations"].map((x) => OfferTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offers_id": offersId == null ? null : offersId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "offers_main_number":
            offersMainNumber == null ? null : offersMainNumber,
        "offers_additional_number": offersAdditionalNumber,
        "offers_discount": offersDiscount == null ? null : offersDiscount,
        "offers_from":
            offersFrom == null ? null : offersFrom!.toIso8601String(),
        "offers_to": offersTo == null ? null : offersTo!.toIso8601String(),
        "offers_status": offersStatus == null ? null : offersStatus,
        "access_level": accessLevel == null ? null : accessLevel,
        "offers_image": offersImage == null ? null : offersImage,
        "offers_type": offersType == null ? null : offersType,
        "offers_title": offersTitle == null ? null : offersTitle,
        "offers_alert": offersAlert == null ? null : offersAlert,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class OfferTranslation {
  OfferTranslation({
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

  factory OfferTranslation.fromJson(Map<String, dynamic> json) =>
      OfferTranslation(
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
        "locale": locale == null ? null : locale,
      };
}

class ProductChoiceStock {
  ProductChoiceStock({
    this.productsBranchesId,
    this.productsId,
    this.productsChoicesId,
    this.branchesId,
    this.productsStock,
  });

  int? productsBranchesId;
  String? productsId;
  String? productsChoicesId;
  String? branchesId;
  String? productsStock;

  factory ProductChoiceStock.fromJson(Map<String, dynamic> json) =>
      ProductChoiceStock(
        productsBranchesId: json["products_branches_id"] == null
            ? null
            : json["products_branches_id"],
        productsId: json["products_id"] == null ? null : json["products_id"],
        productsChoicesId: json["products_choices_id"] == null
            ? null
            : json["products_choices_id"],
        branchesId: json["branches_id"] == null ? null : json["branches_id"],
        productsStock:
            json["products_stock"] == null ? null : json["products_stock"],
      );

  Map<String, dynamic> toJson() => {
        "products_branches_id":
            productsBranchesId == null ? null : productsBranchesId,
        "products_id": productsId == null ? null : productsId,
        "products_choices_id":
            productsChoicesId == null ? null : productsChoicesId,
        "branches_id": branchesId == null ? null : branchesId,
        "products_stock": productsStock == null ? null : productsStock,
      };
}

class Product {
  Product({
    this.productsId,
    this.fkAccountsId,
    this.fkCategoriesId,
    this.companiesId,
    this.brandsId,
    this.productsCode,
    this.productsBarcode,
    this.productsImg,
    this.productsPrice,
    this.productsPoints,
    this.productsCalories,
    this.productsVideo,
    this.productsType,
    this.productsLowestWeightAvailable,
    this.productsHome,
    this.productsAvailable,
    this.productsStatus,
    this.productsPosition,
    this.shopsId,
    this.productsStocks,
    this.productsRating,
    this.productsStore,
    this.productsEcommerce,
    this.offersId,
    this.productsCreatedAt,
    this.productsUpdatedAt,
    this.productsTitle,
    this.productsDesc,
    this.productsSlug,
    this.productsTags,
    this.productsSeoTitle,
    this.productsSeoDesc,
    this.productsSeoKeyword,
    this.translations,
  });

  int? productsId;
  String? fkAccountsId;
  String? fkCategoriesId;
  dynamic companiesId;
  dynamic brandsId;
  String? productsCode;
  String? productsBarcode;
  String? productsImg;
  String? productsPrice;
  String? productsPoints;
  bool? productsCalories;
  dynamic productsVideo;
  String? productsType;
  dynamic productsLowestWeightAvailable;
  String? productsHome;
  String? productsAvailable;
  String? productsStatus;
  String? productsPosition;
  dynamic shopsId;
  dynamic productsStocks;
  String? productsRating;
  String? productsStore;
  String? productsEcommerce;
  String? offersId;
  DateTime? productsCreatedAt;
  DateTime? productsUpdatedAt;
  String? productsTitle;
  dynamic productsDesc;
  String? productsSlug;
  dynamic productsTags;
  dynamic productsSeoTitle;
  dynamic productsSeoDesc;
  dynamic productsSeoKeyword;
  List<ProductTranslation>? translations;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productsId: json["products_id"] == null ? null : json["products_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkCategoriesId:
            json["FK_categories_id"] == null ? null : json["FK_categories_id"],
        companiesId: json["companies_id"],
        brandsId: json["brands_id"],
        productsCode:
            json["products_code"] == null ? null : json["products_code"],
        productsBarcode:
            json["products_barcode"] == null ? null : json["products_barcode"],
        productsImg: json["products_img"] == null ? null : json["products_img"],
        productsPrice:
            json["products_price"] == null ? null : json["products_price"],
        productsPoints:
            json["products_points"] == null ? null : json["products_points"],
        productsCalories: json["products_calories"] == null
            ? null
            : json["products_calories"],
        productsVideo: json["products_video"],
        productsType:
            json["products_type"] == null ? null : json["products_type"],
        productsLowestWeightAvailable: json["products_lowest_weight_available"],
        productsHome:
            json["products_home"] == null ? null : json["products_home"],
        productsAvailable: json["products_available"] == null
            ? null
            : json["products_available"],
        productsStatus:
            json["products_status"] == null ? null : json["products_status"],
        productsPosition: json["products_position"] == null
            ? null
            : json["products_position"],
        shopsId: json["shops_id"],
        productsStocks: json["products_stocks"],
        productsRating:
            json["products_rating"] == null ? null : json["products_rating"],
        productsStore:
            json["products_store"] == null ? null : json["products_store"],
        productsEcommerce: json["products_ecommerce"] == null
            ? null
            : json["products_ecommerce"],
        offersId: json["offers_id"] == null ? null : json["offers_id"],
        productsCreatedAt: json["products_created_at"] == null
            ? null
            : DateTime.parse(json["products_created_at"]),
        productsUpdatedAt: json["products_updated_at"] == null
            ? null
            : DateTime.parse(json["products_updated_at"]),
        productsTitle:
            json["products_title"] == null ? null : json["products_title"],
        productsDesc: json["products_desc"],
        productsSlug:
            json["products_slug"] == null ? null : json["products_slug"],
        productsTags: json["products_tags"],
        productsSeoTitle: json["products_seo_title"],
        productsSeoDesc: json["products_seo_desc"],
        productsSeoKeyword: json["products_seo_keyword"],
        translations: json["translations"] == null
            ? null
            : List<ProductTranslation>.from(json["translations"]
                .map((x) => ProductTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products_id": productsId == null ? null : productsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_categories_id": fkCategoriesId == null ? null : fkCategoriesId,
        "companies_id": companiesId,
        "brands_id": brandsId,
        "products_code": productsCode == null ? null : productsCode,
        "products_barcode": productsBarcode == null ? null : productsBarcode,
        "products_img": productsImg == null ? null : productsImg,
        "products_price": productsPrice == null ? null : productsPrice,
        "products_points": productsPoints == null ? null : productsPoints,
        "products_calories": productsCalories == null ? null : productsCalories,
        "products_video": productsVideo,
        "products_type": productsType == null ? null : productsType,
        "products_lowest_weight_available": productsLowestWeightAvailable,
        "products_home": productsHome == null ? null : productsHome,
        "products_available":
            productsAvailable == null ? null : productsAvailable,
        "products_status": productsStatus == null ? null : productsStatus,
        "products_position": productsPosition == null ? null : productsPosition,
        "shops_id": shopsId,
        "products_stocks": productsStocks,
        "products_rating": productsRating == null ? null : productsRating,
        "products_store": productsStore == null ? null : productsStore,
        "products_ecommerce":
            productsEcommerce == null ? null : productsEcommerce,
        "offers_id": offersId == null ? null : offersId,
        "products_created_at": productsCreatedAt == null
            ? null
            : productsCreatedAt!.toIso8601String(),
        "products_updated_at": productsUpdatedAt == null
            ? null
            : productsUpdatedAt!.toIso8601String(),
        "products_title": productsTitle == null ? null : productsTitle,
        "products_desc": productsDesc,
        "products_slug": productsSlug == null ? null : productsSlug,
        "products_tags": productsTags,
        "products_seo_title": productsSeoTitle,
        "products_seo_desc": productsSeoDesc,
        "products_seo_keyword": productsSeoKeyword,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class ProductTranslation {
  ProductTranslation({
    this.productsTransId,
    this.productsId,
    this.locale,
    this.productsTitle,
    this.productsDesc,
    this.productsTags,
    this.productsSlug,
    this.productsSeoTitle,
    this.productsSeoDesc,
    this.productsSeoKeyword,
  });

  int? productsTransId;
  String? productsId;
  String? locale;
  String? productsTitle;
  dynamic productsDesc;
  dynamic productsTags;
  String? productsSlug;
  dynamic productsSeoTitle;
  dynamic productsSeoDesc;
  dynamic productsSeoKeyword;

  factory ProductTranslation.fromJson(Map<String, dynamic> json) =>
      ProductTranslation(
        productsTransId: json["products_trans_id"] == null
            ? null
            : json["products_trans_id"],
        productsId: json["products_id"] == null ? null : json["products_id"],
        locale: json["locale"] == null ? null : json["locale"],
        productsTitle:
            json["products_title"] == null ? null : json["products_title"],
        productsDesc: json["products_desc"],
        productsTags: json["products_tags"],
        productsSlug:
            json["products_slug"] == null ? null : json["products_slug"],
        productsSeoTitle: json["products_seo_title"],
        productsSeoDesc: json["products_seo_desc"],
        productsSeoKeyword: json["products_seo_keyword"],
      );

  Map<String, dynamic> toJson() => {
        "products_trans_id": productsTransId == null ? null : productsTransId,
        "products_id": productsId == null ? null : productsId,
        "locale": locale == null ? null : locale,
        "products_title": productsTitle == null ? null : productsTitle,
        "products_desc": productsDesc,
        "products_tags": productsTags,
        "products_slug": productsSlug == null ? null : productsSlug,
        "products_seo_title": productsSeoTitle,
        "products_seo_desc": productsSeoDesc,
        "products_seo_keyword": productsSeoKeyword,
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
        "payments_slug": paymentsSlug == null ? null : paymentsSlug,
        "payments_credentials":
            paymentsCredentials == null ? null : paymentsCredentials!.toJson(),
        "payments_status": paymentsStatus == null ? null : paymentsStatus,
        "payments_name": paymentsName == null ? null : paymentsName,
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
        "locale": locale == null ? null : locale,
        "payments_name": paymentsName == null ? null : paymentsName,
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
