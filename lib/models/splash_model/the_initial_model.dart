import 'dart:convert';

import 'package:elnasser/models/account_model.dart';

TheInitialModel theInitialModelFromJson(String str) =>
    TheInitialModel.fromJson(json.decode(str));

String theInitialModelToJson(TheInitialModel data) =>
    json.encode(data.toJson());

class TheInitialModel {
  TheInitialModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory TheInitialModel.fromJson(Map<String, dynamic> json) =>
      TheInitialModel(
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
  Data(
      {this.account,
      this.info,
      this.setting,
      this.promotionalMessages,
      this.defaultLang,
      this.hasRegistration,
      this.smsMethod,
      this.contactSubject});

  Account? account;
  SmsMethod? smsMethod;
  Info? info;
  Setting? setting;
  List<PromotionalMessage>? promotionalMessages;
  String? defaultLang;
  bool? hasRegistration;
  List<ContactSubject>? contactSubject;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        account: Account.fromJson(json["account"]),
        smsMethod: json["sms_method"] == null
            ? null
            : SmsMethod.fromJson(json["sms_method"]),
        info: Info.fromJson(json["info"]),
        setting: Setting.fromJson(json["setting"]),
        contactSubject: List<ContactSubject>.from(
            json["contact_subjects"].map((x) => ContactSubject.fromJson(x))),
        promotionalMessages: List<PromotionalMessage>.from(
            json["promotional_messages"]
                .map((x) => PromotionalMessage.fromJson(x))),
        defaultLang: json["defaultLang"],
        hasRegistration: json["hasRegistration"],
      );

  Map<String, dynamic> toJson() => {
        "account": account!.toJson(),
        "sms_method": smsMethod!.toJson(),
        "info": info!.toJson(),
        "setting": setting!.toJson(),
        "promotional_messages":
            List<dynamic>.from(promotionalMessages!.map((x) => x.toJson())),
        "contact_subjects":
            List<dynamic>.from(contactSubject!.map((x) => x.toJson())),
        "defaultLang": defaultLang,
        "hasRegistration": hasRegistration,
      };
}

class PromotionalMessage {
  PromotionalMessage({
    this.promotionalMessagesId,
    this.fkAccountsId,
    this.promotionalMessagesIcon,
    this.promotionalMessagesStatus,
    this.promotionalMessagesCreatedAt,
    this.promotionalMessagesUpdatedAt,
    this.promotionalMessagesText,
    this.translations,
  });

  int? promotionalMessagesId;
  String? fkAccountsId;
  String? promotionalMessagesIcon;
  String? promotionalMessagesStatus;
  DateTime? promotionalMessagesCreatedAt;
  DateTime? promotionalMessagesUpdatedAt;
  String? promotionalMessagesText;
  List<PromotionalMessageTranslation>? translations;

  factory PromotionalMessage.fromJson(Map<String, dynamic> json) =>
      PromotionalMessage(
        promotionalMessagesId: json["promotional_messages_id"],
        fkAccountsId: json["FK_accounts_id"],
        promotionalMessagesIcon: json["promotional_messages_icon"],
        promotionalMessagesStatus: json["promotional_messages_status"],
        promotionalMessagesCreatedAt:
            DateTime.parse(json["promotional_messages_created_at"]),
        promotionalMessagesUpdatedAt:
            DateTime.parse(json["promotional_messages_updated_at"]),
        promotionalMessagesText: json["promotional_messages_text"],
        translations: List<PromotionalMessageTranslation>.from(
            json["translations"]
                .map((x) => PromotionalMessageTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "promotional_messages_id": promotionalMessagesId,
        "FK_accounts_id": fkAccountsId,
        "promotional_messages_icon": promotionalMessagesIcon,
        "promotional_messages_status": promotionalMessagesStatus,
        "promotional_messages_created_at":
            promotionalMessagesCreatedAt!.toIso8601String(),
        "promotional_messages_updated_at":
            promotionalMessagesUpdatedAt!.toIso8601String(),
        "promotional_messages_text": promotionalMessagesText,
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class PromotionalMessageTranslation {
  PromotionalMessageTranslation({
    this.promotionalMessagesTransId,
    this.promotionalMessagesId,
    this.locale,
    this.promotionalMessagesText,
  });

  int? promotionalMessagesTransId;
  String? promotionalMessagesId;
  String? locale;
  String? promotionalMessagesText;

  factory PromotionalMessageTranslation.fromJson(Map<String, dynamic> json) =>
      PromotionalMessageTranslation(
        promotionalMessagesTransId: json["promotional_messages_trans_id"],
        promotionalMessagesId: json["promotional_messages_id"],
        locale: json["locale"],
        promotionalMessagesText: json["promotional_messages_text"],
      );

  Map<String, dynamic> toJson() => {
        "promotional_messages_trans_id": promotionalMessagesTransId,
        "promotional_messages_id": promotionalMessagesId,
        "locale": locale,
        "promotional_messages_text": promotionalMessagesText,
      };
}

class Info {
  Info(
      {this.infosId,
      this.fkAccountsId,
      this.infosPhone1,
      this.infosPhone2,
      this.infosPhone3,
      this.infosGps,
      this.infosFacebook,
      this.infosTwitter,
      this.infosYoutube,
      this.infosInstagram,
      this.infosSnapchat,
      this.infosWhatsapp,
      this.infosFoursquare,
      this.infosCreatedAt,
      this.infosUpdatedAt,
      this.infosTelegram,
      this.infosTiktok,
      this.infosEmail,
      this.infosAbout,
      this.infosPrivacyPolicy,
      this.infosReturnExchangePolicy,
      this.trans,
      this.translations,
      this.infosTermsConditions,
      this.infosMessengerAccount});

  int? infosId;
  String? fkAccountsId;
  String? infosPhone1;
  String? infosPhone2;
  String? infosPhone3;
  String? infosGps;
  String? infosFacebook;
  String? infosTwitter;
  String? infosYoutube;
  String? infosInstagram;
  String? infosSnapchat;
  String? infosWhatsapp;
  String? infosFoursquare;
  DateTime? infosCreatedAt;
  DateTime? infosUpdatedAt;
  String? infosTelegram;
  String? infosTiktok;
  String? infosEmail;
  String? infosAbout;
  String? infosPrivacyPolicy;
  String? infosReturnExchangePolicy;
  String? infosTermsConditions;
  String? infosMessengerAccount;
  List<InfoTran>? trans;
  List<InfoTran>? translations;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        infosId: json["infos_id"],
        fkAccountsId: json["FK_accounts_id"],
        infosPhone1: json["infos_phone1"],
        infosPhone2: json["infos_phone2"],
        infosPhone3: json["infos_phone3"],
        infosGps: json["infos_gps"],
        infosFacebook: json["infos_facebook"],
        infosTwitter: json["infos_twitter"],
        infosYoutube: json["infos_youtube"],
        infosInstagram: json["infos_instagram"],
        infosSnapchat: json["infos_snapchat"],
        infosWhatsapp: json["infos_whatsapp"],
        infosFoursquare: json["infos_foursquare"],
        infosCreatedAt: DateTime.parse(json["infos_created_at"]),
        infosUpdatedAt: DateTime.parse(json["infos_updated_at"]),
        infosTelegram: json["infos_telegram"],
        infosTiktok: json["infos_tiktok"],
        infosEmail: json["infos_email"],
        infosAbout: json["infos_about"],
        infosMessengerAccount: json["infos_messenger_account"],
        infosPrivacyPolicy: json["infos_privacy_policy"],
        infosReturnExchangePolicy: json["infos_return_exchange_policy"],
        infosTermsConditions: json["infos_terms_conditions"],
        trans:
            List<InfoTran>.from(json["trans"].map((x) => InfoTran.fromJson(x))),
        translations: List<InfoTran>.from(
            json["translations"].map((x) => InfoTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "infos_id": infosId,
        "FK_accounts_id": fkAccountsId,
        "infos_phone1": infosPhone1,
        "infos_phone2": infosPhone2,
        "infos_phone3": infosPhone3,
        "infos_gps": infosGps,
        "infos_facebook": infosFacebook,
        "infos_twitter": infosTwitter,
        "infos_youtube": infosYoutube,
        "infos_instagram": infosInstagram,
        "infos_snapchat": infosSnapchat,
        "infos_whatsapp": infosWhatsapp,
        "infos_foursquare": infosFoursquare,
        "infos_created_at": infosCreatedAt!.toIso8601String(),
        "infos_updated_at": infosUpdatedAt!.toIso8601String(),
        "infos_telegram": infosTelegram,
        "infos_tiktok": infosTiktok,
        "infos_email": infosEmail,
        "infos_about": infosAbout,
        "infos_privacy_policy": infosPrivacyPolicy,
        "infos_messenger_account": infosMessengerAccount,
        "infos_terms_conditions": infosTermsConditions,
        "infos_return_exchange_policy": infosReturnExchangePolicy,
        "trans": List<dynamic>.from(trans!.map((x) => x.toJson())),
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class InfoTran {
  InfoTran({
    this.infosTransId,
    this.infosId,
    this.locale,
    this.infosAbout,
    this.infosPrivacyPolicy,
    this.infosReturnExchangePolicy,
  });

  int? infosTransId;
  String? infosId;
  String? locale;
  String? infosAbout;
  String? infosPrivacyPolicy;
  String? infosReturnExchangePolicy;

  factory InfoTran.fromJson(Map<String, dynamic> json) => InfoTran(
        infosTransId: json["infos_trans_id"],
        infosId: json["infos_id"],
        locale: json["locale"],
        infosAbout: json["infos_about"],
        infosPrivacyPolicy: json["infos_privacy_policy"],
        infosReturnExchangePolicy: json["infos_return_exchange_policy"],
      );

  Map<String, dynamic> toJson() => {
        "infos_trans_id": infosTransId,
        "infos_id": infosId,
        "locale": locale,
        "infos_about": infosAbout,
        "infos_privacy_policy": infosPrivacyPolicy,
        "infos_return_exchange_policy": infosReturnExchangePolicy,
      };
}

class Setting {
  Setting(
      {this.settingsId,
      this.fkAccountsId,
      this.settingsDefaultLanguage,
      this.settingsPaginationCount,
      this.settingsPaginationCountDashboard,
      this.settingsDeliveryCost,
      this.settingsMinOrder,
      this.stopOrder,
      this.websiteStatus,
      this.accountsEmail,
      this.clientsCodeType,
      this.clientsCodeValue,
      this.clientsCodeLimit,
      this.clientsCodeAmount,
      this.robotTxt,
      this.sitemap,
      this.menuShowLang,
      this.settingsCreatedAt,
      this.settingsUpdatedAt,
      this.settingsDeliveryCostNew,
      this.settingsCurrency,
      this.orderTimeMsg,
      this.stopOrderMsg,
      this.stopWebsiteMsg,
      this.trans,
      this.account,
      this.translations,
      this.homeProductsTitle});

  int? settingsId;
  String? fkAccountsId;
  String? settingsDefaultLanguage;
  String? settingsPaginationCount;
  String? settingsPaginationCountDashboard;
  String? settingsDeliveryCost;
  String? settingsMinOrder;
  String? stopOrder;
  String? websiteStatus;
  String? accountsEmail;
  String? clientsCodeType;
  String? clientsCodeValue;
  String? clientsCodeLimit;
  String? clientsCodeAmount;
  String? robotTxt;
  String? sitemap;
  String? menuShowLang;
  DateTime? settingsCreatedAt;
  DateTime? settingsUpdatedAt;
  String? settingsDeliveryCostNew;
  String? settingsCurrency;
  String? orderTimeMsg;
  String? stopOrderMsg;
  String? homeProductsTitle;
  dynamic stopWebsiteMsg;
  List<SettingTran>? trans;
  Account? account;
  List<SettingTran>? translations;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        settingsId: json["settings_id"],
        fkAccountsId: json["FK_accounts_id"],
        settingsDefaultLanguage: json["settings_default_language"],
        settingsPaginationCount: json["settings_pagination_count"],
        settingsPaginationCountDashboard:
            json["settings_pagination_count_dashboard"],
        settingsDeliveryCost: json["settings_delivery_cost"],
        settingsMinOrder: json["settings_min_order"],
        stopOrder: json["stop_order"],
        websiteStatus: json["website_status"],
        accountsEmail: json["accounts_email"],
        clientsCodeType: json["clients_code_type"],
        clientsCodeValue: json["clients_code_value"],
        clientsCodeLimit: json["clients_code_limit"],
        clientsCodeAmount: json["clients_code_amount"],
        robotTxt: json["robotTxt"],
        sitemap: json["sitemap"],
        menuShowLang: json["menu_show_lang"],
        settingsCreatedAt: DateTime.parse(json["settings_created_at"]),
        settingsUpdatedAt: DateTime.parse(json["settings_updated_at"]),
        settingsDeliveryCostNew: json["settings_delivery_cost_new"],
        settingsCurrency: json["settings_currency"],
        orderTimeMsg: json["order_time_msg"],
        stopOrderMsg: json["stop_order_msg"],
        homeProductsTitle: json["home_products_title"],
        stopWebsiteMsg: json["stop_website_msg"],
        trans: List<SettingTran>.from(
            json["trans"].map((x) => SettingTran.fromJson(x))),
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        translations: List<SettingTran>.from(
            json["translations"].map((x) => SettingTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "settings_id": settingsId,
        "FK_accounts_id": fkAccountsId,
        "settings_default_language": settingsDefaultLanguage,
        "settings_pagination_count": settingsPaginationCount,
        "settings_pagination_count_dashboard": settingsPaginationCountDashboard,
        "settings_delivery_cost": settingsDeliveryCost,
        "settings_min_order": settingsMinOrder,
        "stop_order": stopOrder,
        "website_status": websiteStatus,
        "accounts_email": accountsEmail,
        "clients_code_type": clientsCodeType,
        "clients_code_value": clientsCodeValue,
        "clients_code_limit": clientsCodeLimit,
        "clients_code_amount": clientsCodeAmount,
        "robotTxt": robotTxt,
        "sitemap": sitemap,
        "menu_show_lang": menuShowLang,
        "settings_created_at": settingsCreatedAt!.toIso8601String(),
        "settings_updated_at": settingsUpdatedAt!.toIso8601String(),
        "settings_delivery_cost_new": settingsDeliveryCostNew,
        "settings_currency": settingsCurrency,
        "order_time_msg": orderTimeMsg,
        "stop_order_msg": stopOrderMsg,
        "home_products_title": homeProductsTitle,
        "stop_website_msg": stopWebsiteMsg,
        "trans": List<dynamic>.from(trans!.map((x) => x.toJson())),
        "account": account == null ? null : account!.toJson(),
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class SettingTran {
  SettingTran({
    this.settingsTransId,
    this.settingsId,
    this.locale,
    this.settingsCurrency,
    this.stopWebsiteMsg,
    this.stopOrderMsg,
    this.orderTimeMsg,
  });

  int? settingsTransId;
  String? settingsId;
  String? locale;
  String? settingsCurrency;
  dynamic stopWebsiteMsg;
  String? stopOrderMsg;
  String? orderTimeMsg;

  factory SettingTran.fromJson(Map<String, dynamic> json) => SettingTran(
        settingsTransId: json["settings_trans_id"],
        settingsId: json["settings_id"],
        locale: json["locale"],
        settingsCurrency: json["settings_currency"],
        stopWebsiteMsg: json["stop_website_msg"],
        stopOrderMsg: json["stop_order_msg"],
        orderTimeMsg: json["order_time_msg"],
      );

  Map<String, dynamic> toJson() => {
        "settings_trans_id": settingsTransId,
        "settings_id": settingsId,
        "locale": locale,
        "settings_currency": settingsCurrency,
        "stop_website_msg": stopWebsiteMsg,
        "stop_order_msg": stopOrderMsg,
        "order_time_msg": orderTimeMsg,
      };
}

class SmsMethod {
  SmsMethod({
    this.smsMethodsId,
    this.fkAccountsId,
    this.smsMethodsSlug,
    this.smsMethodsCredentials,
    this.smsMethodsStatus,
    this.smsMethodsName,
    this.translations,
  });

  int? smsMethodsId;
  String? fkAccountsId;
  String? smsMethodsSlug;
  SmsMethodsCredentials? smsMethodsCredentials;
  String? smsMethodsStatus;
  String? smsMethodsName;
  List<Translation>? translations;

  factory SmsMethod.fromJson(Map<String, dynamic> json) => SmsMethod(
        smsMethodsId: json["sms_methods_id"],
        fkAccountsId: json["FK_accounts_id"],
        smsMethodsSlug: json["sms_methods_slug"],
        smsMethodsCredentials:
            SmsMethodsCredentials.fromJson(json["sms_methods_credentials"]),
        smsMethodsStatus: json["sms_methods_status"],
        smsMethodsName: json["sms_methods_name"],
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sms_methods_id": smsMethodsId,
        "FK_accounts_id": fkAccountsId,
        "sms_methods_slug": smsMethodsSlug,
        "sms_methods_credentials": smsMethodsCredentials!.toJson(),
        "sms_methods_status": smsMethodsStatus,
        "sms_methods_name": smsMethodsName,
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class SmsMethodsCredentials {
  SmsMethodsCredentials({
    this.smsUsername,
    this.smsPassword,
    this.smsSender,
  });

  String? smsUsername;
  String? smsPassword;
  String? smsSender;

  factory SmsMethodsCredentials.fromJson(Map<String, dynamic> json) =>
      SmsMethodsCredentials(
        smsUsername: json["SMS_USERNAME"],
        smsPassword: json["SMS_PASSWORD"],
        smsSender: json["SMS_SENDER"],
      );

  Map<String, dynamic> toJson() => {
        "SMS_USERNAME": smsUsername,
        "SMS_PASSWORD": smsPassword,
        "SMS_SENDER": smsSender,
      };
}

class Translation {
  Translation({
    this.smsMethodsTransId,
    this.smsMethodsId,
    this.locale,
    this.smsMethodsName,
  });

  int? smsMethodsTransId;
  String? smsMethodsId;
  String? locale;
  String? smsMethodsName;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        smsMethodsTransId: json["sms_methods_trans_id"],
        smsMethodsId: json["sms_methods_id"],
        locale: json["locale"],
        smsMethodsName: json["sms_methods_name"],
      );

  Map<String, dynamic> toJson() => {
        "sms_methods_trans_id": smsMethodsTransId,
        "sms_methods_id": smsMethodsId,
        "locale": locale,
        "sms_methods_name": smsMethodsName,
      };
}

class ContactSubject {
  ContactSubject({
    this.contactsSubjectsId,
    this.fkAccountsId,
    this.contactsSubjectsStatus,
    this.contactsSubjectsPosition,
    this.contactsSubjectsTitle,
    this.translations,
  });

  int? contactsSubjectsId;
  String? fkAccountsId;
  String? contactsSubjectsStatus;
  String? contactsSubjectsPosition;
  String? contactsSubjectsTitle;
  List<Translation>? translations;

  factory ContactSubject.fromJson(Map<String, dynamic> json) => ContactSubject(
        contactsSubjectsId: json["contacts_subjects_id"] == null
            ? null
            : json["contacts_subjects_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        contactsSubjectsStatus: json["contacts_subjects_status"] == null
            ? null
            : json["contacts_subjects_status"],
        contactsSubjectsPosition: json["contacts_subjects_position"] == null
            ? null
            : json["contacts_subjects_position"],
        contactsSubjectsTitle: json["contacts_subjects_title"] == null
            ? null
            : json["contacts_subjects_title"],
        translations: json["translations"] == null
            ? null
            : List<Translation>.from(
                json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contacts_subjects_id":
            contactsSubjectsId == null ? null : contactsSubjectsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "contacts_subjects_status":
            contactsSubjectsStatus == null ? null : contactsSubjectsStatus,
        "contacts_subjects_position":
            contactsSubjectsPosition == null ? null : contactsSubjectsPosition,
        "contacts_subjects_title":
            contactsSubjectsTitle == null ? null : contactsSubjectsTitle,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}
