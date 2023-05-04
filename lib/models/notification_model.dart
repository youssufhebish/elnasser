import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  NotificationModelData? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        errors: json["errors"],
        data: json["data"] == null
            ? null
            : NotificationModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "errors": errors,
        "data": data == null ? null : data!.toJson(),
      };
}

class NotificationModelData {
  NotificationModelData({
    this.notifications,
    this.pagination,
  });

  List<NotificationClassModel>? notifications;
  Pagination? pagination;

  factory NotificationModelData.fromJson(Map<String, dynamic> json) =>
      NotificationModelData(
        notifications: json["notifications"] == null
            ? null
            : List<NotificationClassModel>.from(json["notifications"]
                .map((x) => NotificationClassModel.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? null
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "pagination": pagination == null ? null : pagination!.toJson(),
      };
}

class NotificationClassModel {
  NotificationClassModel({
    this.id,
    this.data,
    this.readAt,
    this.createdAt,
  });

  String? id;
  NotificationData? data;
  dynamic readAt;
  DateTime? createdAt;

  factory NotificationClassModel.fromJson(Map<String, dynamic> json) =>
      NotificationClassModel(
        id: json["id"] == null ? null : json["id"],
        data: json["data"] == null
            ? null
            : NotificationData.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "data": data == null ? null : data!.toJson(),
        "read_at": readAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}

class NotificationData {
  NotificationData({
    this.data,
    this.type,
    this.sender,
  });

  DataData? data;
  String? type;
  dynamic sender;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
        type: json["type"] == null ? null : json["type"],
        sender: json["sender"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "type": type == null ? null : type,
        "sender": sender,
      };
}

class DataData {
  DataData({
    this.orderId,
    this.ar,
    this.en,
    this.createdAt,
  });

  int? orderId;
  String? ar;
  String? en;
  String? createdAt;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        orderId: json["orderId"] == null ? null : json["orderId"],
        ar: json["ar"] == null ? null : json["ar"],
        en: json["en"] == null ? null : json["en"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId == null ? null : orderId,
        "ar": ar == null ? null : ar,
        "en": en == null ? null : en,
        "created_at": createdAt == null ? null : createdAt!,
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
