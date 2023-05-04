// To parse this JSON data, do
//
//     final rEgisterModel = rEgisterModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordModel ForgetPasswordModelFromJson(String str) =>
    ForgetPasswordModel.fromJson(json.decode(str));

String ForgetPasswordModelToJson(ForgetPasswordModel data) =>
    json.encode(data.toJson());

class ForgetPasswordModel {
  ForgetPasswordModel(
      {this.accountId,
      this.customersPhone,
      this.customersCountryCode,
      this.password});

  int? accountId;
  String? customersPhone;
  String? customersCountryCode;
  String? password;
  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordModel(
        accountId: json["accountId"],
        customersPhone: json["phone"],
        password: json["password"],
        customersCountryCode: json["customers_country_code"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "phone": customersPhone,
        "password": password,
        "customers_country_code": customersCountryCode,
      };
}
