// To parse this JSON data, do
//
//     final rEgisterModel = rEgisterModelFromJson(jsonString);

import 'dart:convert';

LoginModel LoginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String LoginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel(
      {this.accountId,
      this.customersPhone,
      this.password,
      this.customersCountryCode,
      this.deviceToken});

  int? accountId;

  String? customersPhone;
  String? password;
  String? customersCountryCode;

  String? deviceToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accountId: json["accountId"],
        customersPhone: json["phone"],
        password: json["password"],
        customersCountryCode: json["customers_country_code"],
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "phone": customersPhone,
        "password": password,
        "customers_country_code": customersCountryCode,
        "device_token": deviceToken,
      };
}
