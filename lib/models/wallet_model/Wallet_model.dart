import 'dart:convert';

import 'package:elnasser/models/order_model/order_model_detail.dart';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  WalletModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
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
    this.clientWalletOperations,
    this.pagination,
    this.customersWallet,
  });

  List<ClientWalletOperation>? clientWalletOperations;
  Pagination? pagination;
  dynamic customersWallet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        clientWalletOperations: json["ClientWalletOperations"] == null
            ? null
            : List<ClientWalletOperation>.from(json["ClientWalletOperations"]
                .map((x) => ClientWalletOperation.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        customersWallet:
            json["customers_wallet"] == null ? null : json["customers_wallet"],
      );

  Map<String, dynamic> toJson() => {
        "ClientWalletOperations": clientWalletOperations == null
            ? null
            : List<dynamic>.from(
                clientWalletOperations!.map((x) => x.toJson())),
        "pagination": pagination == null ? null : pagination!.toJson(),
        "customers_wallet": customersWallet == null ? null : customersWallet,
      };
}

class ClientWalletOperation {
  ClientWalletOperation(
      {this.clientWalletOperationsId,
      this.clientWalletOperationsType,
      this.clientWalletOperationsValue,
      this.couponsId,
      this.couponsCode,
      this.clientsId,
      this.ordersId,
      this.walletOperationsId,
      this.clientWalletOperationsCreatedAt,
      this.clientWalletOperationsUpdatedAt,
      this.coupon,
      this.order});

  int? clientWalletOperationsId;
  String? clientWalletOperationsType;
  String? clientWalletOperationsValue;
  dynamic couponsId;
  dynamic couponsCode;
  String? clientsId;
  dynamic ordersId;
  String? walletOperationsId;
  DateTime? clientWalletOperationsCreatedAt;
  DateTime? clientWalletOperationsUpdatedAt;
  Order? order;
  dynamic coupon;

  factory ClientWalletOperation.fromJson(Map<String, dynamic> json) =>
      ClientWalletOperation(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        clientWalletOperationsId: json["client_wallet_operations_id"] == null
            ? null
            : json["client_wallet_operations_id"],
        clientWalletOperationsType:
            json["client_wallet_operations_type"] == null
                ? null
                : json["client_wallet_operations_type"],
        clientWalletOperationsValue:
            json["client_wallet_operations_value"] == null
                ? null
                : json["client_wallet_operations_value"],
        couponsId: json["coupons_id"],
        couponsCode: json["coupons_code"],
        clientsId: json["clients_id"] == null ? null : json["clients_id"],
        ordersId: json["orders_id"],
        walletOperationsId: json["wallet_operations_id"] == null
            ? null
            : json["wallet_operations_id"],
        clientWalletOperationsCreatedAt:
            json["client_wallet_operations_created_at"] == null
                ? null
                : DateTime.parse(json["client_wallet_operations_created_at"]),
        clientWalletOperationsUpdatedAt:
            json["client_wallet_operations_updated_at"] == null
                ? null
                : DateTime.parse(json["client_wallet_operations_updated_at"]),
        coupon: json["coupon"],
      );

  Map<String, dynamic> toJson() => {
        "order": order == null ? null : order!.toJson(),
        "client_wallet_operations_id":
            clientWalletOperationsId == null ? null : clientWalletOperationsId,
        "client_wallet_operations_type": clientWalletOperationsType == null
            ? null
            : clientWalletOperationsType,
        "client_wallet_operations_value": clientWalletOperationsValue == null
            ? null
            : clientWalletOperationsValue,
        "coupons_id": couponsId,
        "coupons_code": couponsCode,
        "clients_id": clientsId == null ? null : clientsId,
        "orders_id": ordersId,
        "wallet_operations_id":
            walletOperationsId == null ? null : walletOperationsId,
        "client_wallet_operations_created_at":
            clientWalletOperationsCreatedAt == null
                ? null
                : clientWalletOperationsCreatedAt!.toIso8601String(),
        "client_wallet_operations_updated_at":
            clientWalletOperationsUpdatedAt == null
                ? null
                : clientWalletOperationsUpdatedAt!.toIso8601String(),
        "coupon": coupon,
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
  dynamic nextPageUrl;
  String? path;
  String? perPage;
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
        nextPageUrl: json["next_page_url"],
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
        "next_page_url": nextPageUrl,
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
