import 'colors_colors_value.dart';
import 'initial_language.dart';
import 'initial_translation.dart';

class Account {
  Account(
      {this.accountsId,
      this.accountsName,
      this.accountsSlug,
      this.accountsImgDashboard,
      this.accountsImgRtl,
      this.accountsImgLtr,
      this.accountsImgHeader,
      this.accountsImgApp,
      this.accountsShowBranches,
      this.accountsShowHierarchy,
      this.accountsShowAreas,
      this.accountsShowCoupons,
      this.accountsShowShippingMethods,
      this.accountsShowOrdersRatings,
      this.accountsSingleMenu,
      this.accountsCountry,
      this.accountsCountryCode,
      this.accountsMultipleCountries,
      this.accountsCountryMobileDigitsCount,
      this.accountsTimezone,
      this.accountsCountryLatLong,
      this.accountsNoreplyEmail,
      this.accountsShowCalories,
      this.accountsShowProductType,
      this.accountsShowTestimonials,
      this.accountsShowQuestions,
      this.accountsShowPartners,
      this.accountsShowNews,
      this.accountsShowJobs,
      this.accountsShowArticles,
      this.accountsShowAlbums,
      this.accountsShowWallet,
      this.accountsShowLostSales,
      this.accountsShowPointsLevels,
      this.accountsShowChoices,
      this.accountsShowProductsNotifications,
      this.accountsShowProductsRatings,
      this.accountsShowOffersMagazines,
      this.accountsFcmKey,
      this.accountsFcmApiKey,
      this.accountsFcmAuthDomain,
      this.accountsFcmDatabaseUrl,
      this.accountsFcmProjectId,
      this.accountsFcmStorageBucket,
      this.accountsFcmMessagingSenderId,
      this.accountsFcmAppId,
      this.accountsFcmMeasurementId,
      this.accountsAndroidUrl,
      this.accountsIosUrl,
      this.accountsProductUrl,
      this.accountsNumberDecimalDigits,
      this.accountsStatus,
      this.accountsPosition,
      this.accountsWebServiceToken,
      this.accountsCreatedAt,
      this.accountsUpdatedAt,
      this.productsTitle,
      this.websiteColors,
      this.mobileAppColors,
      this.langs,
      this.translations,
      this.accountsSocialLoginBtns,
      this.accountsWebsiteUrl});

  int? accountsId;
  String? accountsName;
  String? accountsSlug;
  String? accountsImgDashboard;
  String? accountsImgRtl;
  String? accountsImgLtr;
  String? accountsImgHeader;
  dynamic accountsImgApp;
  String? accountsShowBranches;
  String? accountsWebsiteUrl;
  String? accountsShowHierarchy;
  String? accountsShowAreas;
  String? accountsShowCoupons;
  String? accountsShowShippingMethods;
  String? accountsShowOrdersRatings;
  String? accountsSingleMenu;
  String? accountsCountry;
  String? accountsCountryCode;
  String? accountsMultipleCountries;
  String? accountsCountryMobileDigitsCount;
  String? accountsTimezone;
  String? accountsCountryLatLong;
  String? accountsNoreplyEmail;
  String? accountsShowCalories;
  String? accountsShowProductType;
  String? accountsShowTestimonials;
  String? accountsShowQuestions;
  String? accountsShowPartners;
  String? accountsShowNews;
  String? accountsShowJobs;
  String? accountsShowArticles;
  String? accountsShowAlbums;
  String? accountsShowWallet;
  String? accountsShowLostSales;
  String? accountsShowPointsLevels;
  String? accountsShowChoices;
  String? accountsShowProductsNotifications;
  String? accountsShowProductsRatings;
  String? accountsShowOffersMagazines;
  dynamic accountsFcmKey;
  dynamic accountsFcmApiKey;
  dynamic accountsFcmAuthDomain;
  dynamic accountsFcmDatabaseUrl;
  dynamic accountsFcmProjectId;
  dynamic accountsFcmStorageBucket;
  dynamic accountsFcmMessagingSenderId;
  dynamic accountsFcmAppId;
  dynamic accountsFcmMeasurementId;
  dynamic accountsAndroidUrl;
  dynamic accountsIosUrl;
  dynamic accountsProductUrl;
  String? accountsNumberDecimalDigits;
  String? accountsStatus;
  String? accountsPosition;
  dynamic accountsWebServiceToken;
  DateTime? accountsCreatedAt;
  DateTime? accountsUpdatedAt;
  String? productsTitle;
  ColorsInitialValue? websiteColors;
  ColorsInitialValue? mobileAppColors;
  List<InitialLang>? langs;
  List<InitialTranslation>? translations;
  String? accountsSocialLoginBtns;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountsId: json["accounts_id"],
        accountsName: json["accounts_name"],
        accountsSocialLoginBtns: json["accounts_social_login_btns"],
        accountsWebsiteUrl: json["accounts_website_url"],
        accountsSlug: json["accounts_slug"],
        accountsImgDashboard: json["accounts_img_dashboard"],
        accountsImgRtl: json["accounts_img_rtl"],
        accountsImgLtr: json["accounts_img_ltr"],
        accountsImgHeader: json["accounts_img_header"],
        accountsImgApp: json["accounts_img_app"],
        accountsShowBranches: json["accounts_show_branches"],
        accountsShowHierarchy: json["accounts_show_hierarchy"],
        accountsShowAreas: json["accounts_show_areas"],
        accountsShowCoupons: json["accounts_show_coupons"],
        accountsShowShippingMethods: json["accounts_show_shipping_methods"],
        accountsShowOrdersRatings: json["accounts_show_orders_ratings"],
        accountsSingleMenu: json["accounts_single_menu"],
        accountsCountry: json["accounts_country"],
        accountsCountryCode: json["accounts_country_code"],
        accountsMultipleCountries: json["accounts_multiple_countries"],
        accountsCountryMobileDigitsCount: json["accounts_country_mobile_digits_count"],
        accountsTimezone: json["accounts_timezone"],
        accountsCountryLatLong: json["accounts_country_lat_long"],
        accountsNoreplyEmail: json["accounts_noreply_email"],
        accountsShowCalories: json["accounts_show_calories"],
        accountsShowProductType: json["accounts_show_product_type"],
        accountsShowTestimonials: json["accounts_show_testimonials"],
        accountsShowQuestions: json["accounts_show_questions"],
        accountsShowPartners: json["accounts_show_partners"],
        accountsShowNews: json["accounts_show_news"],
        accountsShowJobs: json["accounts_show_jobs"],
        accountsShowArticles: json["accounts_show_articles"],
        accountsShowAlbums: json["accounts_show_albums"],
        accountsShowWallet: json["accounts_show_wallet"],
        accountsShowLostSales: json["accounts_show_lost_sales"],
        accountsShowPointsLevels: json["accounts_show_points_levels"],
        accountsShowChoices: json["accounts_show_choices"],
        accountsShowProductsNotifications: json["accounts_show_products_notifications"],
        accountsShowProductsRatings: json["accounts_show_products_ratings"],
        accountsShowOffersMagazines: json["accounts_show_offers_magazines"],
        accountsFcmKey: json["accounts_fcm_key"],
        accountsFcmApiKey: json["accounts_fcm_apiKey"],
        accountsFcmAuthDomain: json["accounts_fcm_authDomain"],
        accountsFcmDatabaseUrl: json["accounts_fcm_databaseURL"],
        accountsFcmProjectId: json["accounts_fcm_projectId"],
        accountsFcmStorageBucket: json["accounts_fcm_storageBucket"],
        accountsFcmMessagingSenderId: json["accounts_fcm_messagingSenderId"],
        accountsFcmAppId: json["accounts_fcm_appId"],
        accountsFcmMeasurementId: json["accounts_fcm_measurementId"],
        accountsAndroidUrl: json["accounts_android_url"],
        accountsIosUrl: json["accounts_ios_url"],
        accountsProductUrl: json["accounts_product_url"],
        accountsNumberDecimalDigits: json["accounts_number_decimal_digits"],
        accountsStatus: json["accounts_status"],
        accountsPosition: json["accounts_position"],
        accountsWebServiceToken: json["accounts_web_service_token"],
        accountsCreatedAt: DateTime.parse(json["accounts_created_at"]),
        accountsUpdatedAt: DateTime.parse(json["accounts_updated_at"]),
        productsTitle: json["products_title"],
        websiteColors: json["website_colors"] == null ? null : ColorsInitialValue.fromJson(json["website_colors"]),
        mobileAppColors: json["mobile_app_colors"] == null ? null : ColorsInitialValue.fromJson(json["mobile_app_colors"]),
        langs: json["langs"] == null ? null : List<InitialLang>.from(json["langs"].map((x) => InitialLang.fromJson(x))),
        translations: List<InitialTranslation>.from(json["translations"].map((x) => InitialTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "accounts_id": accountsId,
        "accounts_social_login_btns": accountsSocialLoginBtns,
        "accounts_name": accountsName,
        "accounts_website_url": accountsWebsiteUrl,
        "accounts_slug": accountsSlug,
        "accounts_img_dashboard": accountsImgDashboard,
        "accounts_img_rtl": accountsImgRtl,
        "accounts_img_ltr": accountsImgLtr,
        "accounts_img_header": accountsImgHeader,
        "accounts_img_app": accountsImgApp,
        "accounts_show_branches": accountsShowBranches,
        "accounts_show_hierarchy": accountsShowHierarchy,
        "accounts_show_areas": accountsShowAreas,
        "accounts_show_coupons": accountsShowCoupons,
        "accounts_show_shipping_methods": accountsShowShippingMethods,
        "accounts_show_orders_ratings": accountsShowOrdersRatings,
        "accounts_single_menu": accountsSingleMenu,
        "accounts_country": accountsCountry,
        "accounts_country_code": accountsCountryCode,
        "accounts_multiple_countries": accountsMultipleCountries,
        "accounts_country_mobile_digits_count": accountsCountryMobileDigitsCount,
        "accounts_timezone": accountsTimezone,
        "accounts_country_lat_long": accountsCountryLatLong,
        "accounts_noreply_email": accountsNoreplyEmail,
        "accounts_show_calories": accountsShowCalories,
        "accounts_show_product_type": accountsShowProductType,
        "accounts_show_testimonials": accountsShowTestimonials,
        "accounts_show_questions": accountsShowQuestions,
        "accounts_show_partners": accountsShowPartners,
        "accounts_show_news": accountsShowNews,
        "accounts_show_jobs": accountsShowJobs,
        "accounts_show_articles": accountsShowArticles,
        "accounts_show_albums": accountsShowAlbums,
        "accounts_show_wallet": accountsShowWallet,
        "accounts_show_lost_sales": accountsShowLostSales,
        "accounts_show_points_levels": accountsShowPointsLevels,
        "accounts_show_choices": accountsShowChoices,
        "accounts_show_products_notifications": accountsShowProductsNotifications,
        "accounts_show_products_ratings": accountsShowProductsRatings,
        "accounts_show_offers_magazines": accountsShowOffersMagazines,
        "accounts_fcm_key": accountsFcmKey,
        "accounts_fcm_apiKey": accountsFcmApiKey,
        "accounts_fcm_authDomain": accountsFcmAuthDomain,
        "accounts_fcm_databaseURL": accountsFcmDatabaseUrl,
        "accounts_fcm_projectId": accountsFcmProjectId,
        "accounts_fcm_storageBucket": accountsFcmStorageBucket,
        "accounts_fcm_messagingSenderId": accountsFcmMessagingSenderId,
        "accounts_fcm_appId": accountsFcmAppId,
        "accounts_fcm_measurementId": accountsFcmMeasurementId,
        "accounts_android_url": accountsAndroidUrl,
        "accounts_ios_url": accountsIosUrl,
        "accounts_product_url": accountsProductUrl,
        "accounts_number_decimal_digits": accountsNumberDecimalDigits,
        "accounts_status": accountsStatus,
        "accounts_position": accountsPosition,
        "accounts_web_service_token": accountsWebServiceToken,
        "accounts_created_at": accountsCreatedAt!.toIso8601String(),
        "accounts_updated_at": accountsUpdatedAt!.toIso8601String(),
        "products_title": productsTitle,
        "website_colors": websiteColors == null ? null : websiteColors!.toJson(),
        "mobile_app_colors": mobileAppColors == null ? null : mobileAppColors!.toJson(),
        "langs": langs == null ? null : List<dynamic>.from(langs!.map((x) => x.toJson())),
        "translations": List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}
