// To parse this JSON data, do
//
//     final rEgisterModel = rEgisterModelFromJson(jsonString);

import 'dart:convert';

CheckPhoneNumberModel CheckPhoneNumberModelFromJson(String str) =>
    CheckPhoneNumberModel.fromJson(json.decode(str));

String CheckPhoneNumberModelToJson(CheckPhoneNumberModel data) =>
    json.encode(data.toJson());

class CheckPhoneNumberModel {
  CheckPhoneNumberModel({
    this.accountId,
    this.customersPhone,
    this.customersCountryCode,
  });

  int? accountId;

  String? customersPhone;

  String? customersCountryCode;

  factory CheckPhoneNumberModel.fromJson(Map<String, dynamic> json) =>
      CheckPhoneNumberModel(
        accountId: json["accountId"],
        customersPhone: json["customers_phone"],
        customersCountryCode: json["customers_country_code"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "customers_phone": customersPhone,
        "customers_country_code": customersCountryCode,
      };
}
