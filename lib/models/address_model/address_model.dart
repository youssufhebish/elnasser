// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

import '../account_model.dart';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
  Data(
      {this.addresses,
      this.paymentMethods,
      this.shippingMethod,
      this.customerPointsValue,
      this.customersWallet});

  List<AddressDataModel>? addresses;
  List<PaymentMethodModel>? paymentMethods;
  List<ShippingMethodModel>? shippingMethod;

  dynamic customerPointsValue;
  dynamic customersWallet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        addresses: json["addresses"] == null
            ? null
            : List<AddressDataModel>.from(
                json["addresses"].map((x) => AddressDataModel.fromJson(x))),
        paymentMethods: json["paymentMethods"] == null
            ? null
            : List<PaymentMethodModel>.from(json["paymentMethods"]
                .map((x) => PaymentMethodModel.fromJson(x))),
        shippingMethod: json["shippingMethod"] == null
            ? null
            : List<ShippingMethodModel>.from(json["shippingMethod"]
                .map((x) => ShippingMethodModel.fromJson(x))),
        customerPointsValue: json["customer_points_value"] == null
            ? null
            : json["customer_points_value"],
        customersWallet:
            json["customers_wallet"] == null ? null : json["customers_wallet"],
      );

  Map<String, dynamic> toJson() => {
        "addresses": addresses == null
            ? null
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "paymentMethods": paymentMethods == null
            ? null
            : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
        "shippingMethod": shippingMethod == null
            ? null
            : List<dynamic>.from(shippingMethod!.map((x) => x.toJson())),
        "customer_points_value":
            customerPointsValue == null ? null : customerPointsValue,
        "customers_wallet": customersWallet == null ? null : customersWallet,
      };
}

class AddressDataModel {
  AddressDataModel({
    this.customerAddressesId,
    this.fkCustomersId,
    this.customerAddressesName,
    this.customerAddressesPhone,
    this.customerAddressesArea,
    this.customerAddressesAddress,
    this.customerAddressesGps,
    this.customerAddressesNotes,
    this.customerAddressesDefault,
    this.customerAddressesCreatedAt,
    this.customerAddressesUpdatedAt,
  });

  int? customerAddressesId;
  String? fkCustomersId;
  String? customerAddressesName;
  String? customerAddressesPhone;
  dynamic customerAddressesArea;
  String? customerAddressesAddress;
  String? customerAddressesGps;
  String? customerAddressesNotes;
  String? customerAddressesDefault;
  DateTime? customerAddressesCreatedAt;
  DateTime? customerAddressesUpdatedAt;

  factory AddressDataModel.fromJson(Map<String, dynamic> json) =>
      AddressDataModel(
        customerAddressesId: json["customer_addresses_id"] == null
            ? null
            : json["customer_addresses_id"],
        fkCustomersId:
            json["FK_customers_id"] == null ? null : json["FK_customers_id"],
        customerAddressesName: json["customer_addresses_name"] == null
            ? null
            : json["customer_addresses_name"],
        customerAddressesPhone: json["customer_addresses_phone"] == null
            ? null
            : json["customer_addresses_phone"],
        customerAddressesArea: json["customer_addresses_area"],
        customerAddressesAddress: json["customer_addresses_address"] == null
            ? null
            : json["customer_addresses_address"],
        customerAddressesGps: json["customer_addresses_gps"] == null
            ? null
            : json["customer_addresses_gps"],
        customerAddressesNotes: json["customer_addresses_notes"] == null
            ? null
            : json["customer_addresses_notes"],
        customerAddressesDefault: json["customer_addresses_default"] == null
            ? null
            : json["customer_addresses_default"],
        customerAddressesCreatedAt:
            json["customer_addresses_created_at"] == null
                ? null
                : DateTime.parse(json["customer_addresses_created_at"]),
        customerAddressesUpdatedAt:
            json["customer_addresses_updated_at"] == null
                ? null
                : DateTime.parse(json["customer_addresses_updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_addresses_id":
            customerAddressesId == null ? null : customerAddressesId,
        "FK_customers_id": fkCustomersId == null ? null : fkCustomersId,
        "customer_addresses_name":
            customerAddressesName == null ? null : customerAddressesName,
        "customer_addresses_phone":
            customerAddressesPhone == null ? null : customerAddressesPhone,
        "customer_addresses_area": customerAddressesArea,
        "customer_addresses_address":
            customerAddressesAddress == null ? null : customerAddressesAddress,
        "customer_addresses_gps":
            customerAddressesGps == null ? null : customerAddressesGps,
        "customer_addresses_notes":
            customerAddressesNotes == null ? null : customerAddressesNotes,
        "customer_addresses_default":
            customerAddressesDefault == null ? null : customerAddressesDefault,
        "customer_addresses_created_at": customerAddressesCreatedAt == null
            ? null
            : customerAddressesCreatedAt!.toIso8601String(),
        "customer_addresses_updated_at": customerAddressesUpdatedAt == null
            ? null
            : customerAddressesUpdatedAt!.toIso8601String(),
      };
}

class PaymentMethodModel {
  PaymentMethodModel({
    this.paymentsId,
    this.paymentsSlug,
    this.paymentsName,
    this.translations,
  });

  int? paymentsId;
  String? paymentsSlug;
  String? paymentsName;
  List<PaymentMethodTranslation>? translations;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        paymentsId: json["payments_id"] == null ? null : json["payments_id"],
        paymentsSlug:
            json["payments_slug"] == null ? null : json["payments_slug"],
        paymentsName:
            json["payments_name"] == null ? null : json["payments_name"],
        translations: json["translations"] == null
            ? null
            : List<PaymentMethodTranslation>.from(json["translations"]
                .map((x) => PaymentMethodTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payments_id": paymentsId == null ? null : paymentsId,
        "payments_slug": paymentsSlug == null ? null : paymentsSlug,
        "payments_name": paymentsName == null ? null : paymentsName,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class PaymentMethodTranslation {
  PaymentMethodTranslation({
    this.paymentsTransId,
    this.paymentsId,
    this.locale,
    this.paymentsName,
  });

  int? paymentsTransId;
  String? paymentsId;
  String? locale;
  String? paymentsName;

  factory PaymentMethodTranslation.fromJson(Map<String, dynamic> json) =>
      PaymentMethodTranslation(
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

class ShippingMethodModel {
  ShippingMethodModel({
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
    this.account,
    this.translations,
  });

  int? shippingMethodsId;
  String? fkAccountsId;
  String? shippingMethodsOrderLimit;
  String? shippingMethodsDeliveryCost;
  String? shippingMethodsStatus;
  String? shippingMethodsPosition;
  DateTime? shippingMethodsCreatedAt;
  DateTime? shippingMethodsUpdatedAt;
  String? shippingMethodsTitle;
  String? shippingMethodsText;
  Account? account;
  List<ShippingMethodTranslation>? translations;

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) =>
      ShippingMethodModel(
        shippingMethodsId: json["shipping_methods_id"] == null
            ? null
            : json["shipping_methods_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        shippingMethodsOrderLimit: json["shipping_methods_order_limit"] == null
            ? null
            : json["shipping_methods_order_limit"],
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
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        translations: json["translations"] == null
            ? null
            : List<ShippingMethodTranslation>.from(json["translations"]
                .map((x) => ShippingMethodTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shipping_methods_id":
            shippingMethodsId == null ? null : shippingMethodsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "shipping_methods_order_limit": shippingMethodsOrderLimit == null
            ? null
            : shippingMethodsOrderLimit,
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
        "account": account == null ? null : account!.toJson(),
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
