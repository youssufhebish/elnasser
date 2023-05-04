// To parse this JSON data, do
//
//     final rEgisterModel = rEgisterModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel ContactUsModelFromJson(String str) =>
    ContactUsModel.fromJson(json.decode(str));

String ContactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    this.accountId,
    this.customersPhone,
    this.suggestion,
    this.name,
    this.suggestionId,
  });

  String? accountId;

  String? customersPhone;
  String? suggestion;
  String? name;
  String? suggestionId;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        accountId: json["accountId"],
        customersPhone: json["contacts_phone"],
        suggestion: json["contacts_message"],
        name: json["contacts_name"],
        suggestionId: json["contacts_subjects_id"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "contacts_phone": customersPhone,
        "contacts_message": suggestion,
        "contacts_name": name,
        "contacts_subjects_id": suggestionId,
      };
}
