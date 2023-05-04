// To parse this JSON data, do
//
//     final rEgisterModel = rEgisterModelFromJson(jsonString);

import 'dart:convert';

import 'social_model_response_model.dart';

SocilaLoginModel LoginModelFromJson(String str) =>
    SocilaLoginModel.fromJson(json.decode(str));

String LoginModelToJson(SocilaLoginModel data) => json.encode(data.toJson());

class SocilaLoginModel {
  SocilaLoginModel(
      {this.accountId,
      this.deviceToken,
      this.deviceType,
      this.socialResponseModel,
      this.customersName,
      this.customersEmail,
      this.provider,
      this.providerId});

  String? accountId;
  String? deviceToken;
  String? customersEmail;
  String? customersName;
  String? provider;
  String? providerId;
  String? deviceType;
  String? socialResponseModel;

  factory SocilaLoginModel.fromJson(Map<String, dynamic> json) =>
      SocilaLoginModel(
        accountId: json["accountId"],
        deviceType: json["device_type"],
        socialResponseModel: json["provider_response"],
        deviceToken: json["device_token"],
        customersEmail: json["customers_email"],
        customersName: json["customers_name"],
        provider: json["provider"],
        providerId: json["provider_id"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "device_token": deviceToken,
        "customers_email": customersEmail,
        "customers_name": customersName,
        "device_type": deviceType,
        "provider_response": socialResponseModel,
        "provider": provider,
        "provider_id": providerId,
      };
}
