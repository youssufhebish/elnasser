// To parse this JSON data, do
//
//     final rEgisterModel = rEgisterModelFromJson(jsonString);

import 'dart:convert';

RegisterModel RegisterModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String RegisterModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel(
      {this.accountId,
      this.customersName,
      this.customersEmail,
      this.customersPhone,
      this.password,
      this.customersCountryCode,
      this.customersGender,
      this.customersBirthday,
      this.deviceToken});

  int? accountId;
  String? customersName;
  String? customersEmail;
  String? customersPhone;
  String? password;
  String? customersCountryCode;
  String? customersGender;
  String? customersBirthday;
  String? deviceToken;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        accountId: json["accountId"],
        customersName: json["customers_name"],
        customersEmail: json["customers_email"],
        customersPhone: json["customers_phone"],
        password: json["password"],
        customersCountryCode: json["customers_country_code"],
        customersGender: json["customers_gender"],
        customersBirthday: json["customers_birthday"],
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "customers_name": customersName,
        "customers_email": customersEmail,
        "customers_phone": customersPhone,
        "password": password,
        "customers_country_code": customersCountryCode,
        "customers_gender": customersGender,
        "customers_birthday": customersBirthday,
        "device_token": deviceToken,
      };
}
