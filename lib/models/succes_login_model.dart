import 'dart:convert';

LoginSuccessModel loginSuccessModelFromJson(String str) =>
    LoginSuccessModel.fromJson(json.decode(str));

String loginSuccessModelToJson(LoginSuccessModel data) =>
    json.encode(data.toJson());

class LoginSuccessModel {
  LoginSuccessModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory LoginSuccessModel.fromJson(Map<String, dynamic> json) =>
      LoginSuccessModel(
        status: json["status"],
        message: json["message"],
        errors: json["errors"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.customer,
    this.token,
  });

  Customer? customer;
  Token? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customer: Customer.fromJson(json["customer"]),
        token: Token.fromJson(json["token"]),
      );

  Map<String, dynamic> toJson() => {
        "customer": customer!.toJson(),
        "token": token!.toJson(),
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
    this.customersCreatedAt,
    this.customersUpdatedAt,
  });

  int? customersId;
  String? fkAccountsId;
  String? customersName;
  dynamic customersEmail;
  String? customersPhone;
  String? customersCountryCode;
  dynamic customersBirthday;
  dynamic customersGender;
  String? customersStatus;
  String? emailVerified;
  String? phoneVerified;
  String? customersWallet;
  String? customersDiscountPoints;
  String? customersLevelPoints;
  DateTime? customersCreatedAt;
  DateTime? customersUpdatedAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customersId: json["customers_id"],
        fkAccountsId: json["FK_accounts_id"],
        customersName: json["customers_name"],
        customersEmail: json["customers_email"],
        customersPhone: json["customers_phone"],
        customersCountryCode: json["customers_country_code"],
        customersBirthday: json["customers_birthday"],
        customersGender: json["customers_gender"],
        customersStatus: json["customers_status"],
        emailVerified: json["email_verified"],
        phoneVerified: json["phone_verified"],
        customersWallet: json["customers_wallet"],
        customersDiscountPoints: json["customers_discount_points"],
        customersLevelPoints: json["customers_level_points"],
        customersCreatedAt: DateTime.parse(json["customers_created_at"]),
        customersUpdatedAt: DateTime.parse(json["customers_updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "customers_id": customersId,
        "FK_accounts_id": fkAccountsId,
        "customers_name": customersName,
        "customers_email": customersEmail,
        "customers_phone": customersPhone,
        "customers_country_code": customersCountryCode,
        "customers_birthday": customersBirthday,
        "customers_gender": customersGender,
        "customers_status": customersStatus,
        "email_verified": emailVerified,
        "phone_verified": phoneVerified,
        "customers_wallet": customersWallet,
        "customers_discount_points": customersDiscountPoints,
        "customers_level_points": customersLevelPoints,
        "customers_created_at": customersCreatedAt!.toIso8601String(),
        "customers_updated_at": customersUpdatedAt!.toIso8601String(),
      };
}

class Token {
  Token({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
  });

  String? accessToken;
  String? tokenType;
  DateTime? expiresAt;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt!.toIso8601String(),
      };
}
