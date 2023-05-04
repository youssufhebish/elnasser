// To parse this JSON data, do
//
//     final rEgisterModel = rEgisterModelFromJson(jsonString);

import 'dart:convert';

EditModel RegisterModelFromJson(String str) =>
    EditModel.fromJson(json.decode(str));

String RegisterModelToJson(EditModel data) => json.encode(data.toJson());

class EditModel {
  EditModel({
    this.accountId,
    this.customersName,
    this.customersEmail,
    this.customersPhone,
    this.customersCountryCode,
    this.customersGender,
    this.customersBirthday,
  });

  int? accountId;
  String? customersName;
  String? customersEmail;
  String? customersPhone;
  String? customersCountryCode;
  String? customersGender;
  String? customersBirthday;

  factory EditModel.fromJson(Map<String, dynamic> json) => EditModel(
        accountId: json["accountId"],
        customersName: json["customers_name"],
        customersEmail: json["customers_email"],
        customersPhone: json["customers_phone"],
        customersCountryCode: json["customers_country_code"],
        customersGender: json["customers_gender"],
        customersBirthday: json["customers_birthday"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "customers_name": customersName,
        "customers_email": customersEmail,
        "customers_phone": customersPhone,
        "customers_country_code": customersCountryCode,
        "customers_gender": customersGender,
        "customers_birthday": customersBirthday,
      };
}
