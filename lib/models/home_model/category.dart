import 'package:easy_localization/easy_localization.dart';

class CategoryClass {
  CategoryClass({
    this.categoriesId,
    this.categoriesCode,
    this.categoriesParentId,
    this.categoriesImg,
    this.categoriesBannerImg,
    this.categoriesFollowDeliveryTime,
    this.trans,
    this.subcategories,
    this.isSelected = false,
  });

  int? categoriesId;
  String? categoriesCode;
  dynamic categoriesParentId;
  String? categoriesImg;
  String? categoriesBannerImg;
  String? categoriesFollowDeliveryTime;
  List<SubcategoryTran>? trans;
  List<CategoryClass>? subcategories;
  bool isSelected;

  factory CategoryClass.fromJson(Map<String, dynamic> json) => CategoryClass(
        categoriesId:
            json["categories_id"] == null ? null : json["categories_id"],
        categoriesCode:
            json["categories_code"] == null ? null : json["categories_code"],
        categoriesParentId: json["categories_parent_id"],
        categoriesImg:
            json["categories_img"] == null ? null : json["categories_img"],
        categoriesBannerImg: json["categories_banner_img"] == null
            ? null
            : json["categories_banner_img"],
        categoriesFollowDeliveryTime:
            json["categories_follow_delivery_time"] == null
                ? null
                : json["categories_follow_delivery_time"],
        trans: json["trans"] == null
            ? null
            : List<SubcategoryTran>.from(
                json["trans"].map((x) => SubcategoryTran.fromJson(x))),
        subcategories: json["subcategories"] == null
            ? null
            : List<CategoryClass>.from(
                json["subcategories"].map((x) => CategoryClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories_id": categoriesId == null ? null : categoriesId,
        "categories_code": categoriesCode == null ? null : categoriesCode,
        "categories_parent_id": categoriesParentId,
        "categories_img": categoriesImg == null ? null : categoriesImg,
        "categories_banner_img":
            categoriesBannerImg == null ? null : categoriesBannerImg,
        "categories_follow_delivery_time": categoriesFollowDeliveryTime == null
            ? null
            : categoriesFollowDeliveryTime,
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
        "subcategories": subcategories == null
            ? null
            : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
      };
}

class SubcategoryTran {
  SubcategoryTran({
    this.categoriesTransId,
    this.categoriesId,
    this.locale,
    this.categoriesTitle,
    this.categoriesDesc,
    this.categoriesSlug,
    this.categoriesSeoTitle,
    this.categoriesSeoDesc,
    this.categoriesSeoKeyword,
    this.categoriesFooterCode,
  });

  int? categoriesTransId;
  String? categoriesId;
  String? locale;
  String? categoriesTitle;
  String? categoriesDesc;
  String? categoriesSlug;
  String? categoriesSeoTitle;
  String? categoriesSeoDesc;
  String? categoriesSeoKeyword;
  String? categoriesFooterCode;

  factory SubcategoryTran.fromJson(Map<String, dynamic> json) =>
      SubcategoryTran(
        categoriesTransId: json["categories_trans_id"] == null
            ? null
            : json["categories_trans_id"],
        categoriesId:
            json["categories_id"] == null ? null : json["categories_id"],
        locale: json["locale"] == null ? null : json["locale"],
        categoriesTitle:
            json["categories_title"] == null ? null : json["categories_title"],
        categoriesDesc:
            json["categories_desc"] == null ? null : json["categories_desc"],
        categoriesSlug:
            json["categories_slug"] == null ? null : json["categories_slug"],
        categoriesSeoTitle: json["categories_seo_title"] == null
            ? null
            : json["categories_seo_title"],
        categoriesSeoDesc: json["categories_seo_desc"] == null
            ? null
            : json["categories_seo_desc"],
        categoriesSeoKeyword: json["categories_seo_keyword"] == null
            ? null
            : json["categories_seo_keyword"],
        categoriesFooterCode: json["categories_footer_code"] == null
            ? null
            : json["categories_footer_code"],
      );

  Map<String, dynamic> toJson() => {
        "categories_trans_id":
            categoriesTransId == null ? null : categoriesTransId,
        "categories_id": categoriesId == null ? null : categoriesId,
        "locale": locale == null ? null : locale!,
        "categories_title": categoriesTitle == null ? null : categoriesTitle,
        "categories_desc": categoriesDesc == null ? null : categoriesDesc,
        "categories_slug": categoriesSlug == null ? null : categoriesSlug,
        "categories_seo_title":
            categoriesSeoTitle == null ? null : categoriesSeoTitle,
        "categories_seo_desc":
            categoriesSeoDesc == null ? null : categoriesSeoDesc,
        "categories_seo_keyword":
            categoriesSeoKeyword == null ? null : categoriesSeoKeyword,
        "categories_footer_code":
            categoriesFooterCode == null ? null : categoriesFooterCode,
      };
}

// class Subcategory {
//   Subcategory({
//     this.categoriesId,
//     this.categoriesCode,
//     this.fkAccountsId,
//     this.categoriesParentId,
//     this.categoriesImg,
//     this.categoriesBannerImg,
//     this.categoriesFollowDeliveryTime,
//     this.categoriesDiscountRate,
//     this.categoriesAllowRatings,
//     this.categoriesAllowComparison,
//     this.categoriesStatus,
//     this.categoriesPosition,
//     this.categoriesCreatedAt,
//     this.categoriesUpdatedAt,
//     this.lft,
//     this.rgt,
//     this.depth,
//     this.categoriesTitle,
//     this.categoriesDesc,
//     this.categoriesSlug,
//     this.categoriesSeoTitle,
//     this.categoriesSeoDesc,
//     this.categoriesSeoKeyword,
//     this.categoriesFooterCode,
//     this.subcategories,
//     this.translations,
//   });
//
//   int? categoriesId;
//   String? categoriesCode;
//   String? fkAccountsId;
//   String? categoriesParentId;
//   String? categoriesImg;
//   dynamic categoriesBannerImg;
//   String? categoriesFollowDeliveryTime;
//   String? categoriesDiscountRate;
//   String? categoriesAllowRatings;
//   String? categoriesAllowComparison;
//   String? categoriesStatus;
//   String? categoriesPosition;
//   DateTime? categoriesCreatedAt;
//   DateTime? categoriesUpdatedAt;
//   String? lft;
//   String? rgt;
//   String? depth;
//   String? categoriesTitle;
//   String? categoriesDesc;
//   String? categoriesSlug;
//   String? categoriesSeoTitle;
//   String? categoriesSeoDesc;
//   String? categoriesSeoKeyword;
//   dynamic categoriesFooterCode;
//   List<Subcategory >? subcategories;
//   List<CategoryTranslation >? translations;
//
//   factory Subcategory.fromJson(Map<String , dynamic>  json) => Subcategory(
//     categoriesId: json["categories_id"],
//     categoriesCode: json["categories_code"],
//     fkAccountsId: json["FK_accounts_id"],
//     categoriesParentId: json["categories_parent_id"],
//     categoriesImg: json["categories_img"] == null ? null : json["categories_img"],
//     categoriesBannerImg: json["categories_banner_img"],
//     categoriesFollowDeliveryTime: json["categories_follow_delivery_time"],
//     categoriesDiscountRate: json["categories_discount_rate"] == null ? null : json["categories_discount_rate"],
//     categoriesAllowRatings: json["categories_allow_ratings"],
//     categoriesAllowComparison: json["categories_allow_comparison"],
//     categoriesStatus: json["categories_status"],
//     categoriesPosition: json["categories_position"],
//     categoriesCreatedAt: DateTime.parse(json["categories_created_at"]),
//     categoriesUpdatedAt: DateTime.parse(json["categories_updated_at"]),
//     lft: json["lft"],
//     rgt: json["rgt"],
//     depth: json["depth"],
//     categoriesTitle: json["categories_title"],
//     categoriesDesc: json["categories_desc"] == null ? null : json["categories_desc"],
//     categoriesSlug: json["categories_slug"] == null ? null : json["categories_slug"],
//     categoriesSeoTitle: json["categories_seo_title"] == null ? null : json["categories_seo_title"],
//     categoriesSeoDesc: json["categories_seo_desc"] == null ? null : json["categories_seo_desc"],
//     categoriesSeoKeyword: json["categories_seo_keyword"] == null ? null : json["categories_seo_keyword"],
//     categoriesFooterCode: json["categories_footer_code"],
//     subcategories: List<Subcategory >.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
//     translations: List<CategoryTranslation >.from(json["translations"].map((x) => CategoryTranslation.fromJson(x))),
//   );
//
//   Map<String , dynamic>  toJson() => {
//     "categories_id": categoriesId,
//     "categories_code": categoriesCode,
//     "FK_accounts_id": fkAccountsId,
//     "categories_parent_id": categoriesParentId,
//     "categories_img": categoriesImg == null ? null : categoriesImg,
//     "categories_banner_img": categoriesBannerImg,
//     "categories_follow_delivery_time": categoriesFollowDeliveryTime,
//     "categories_discount_rate": categoriesDiscountRate == null ? null : categoriesDiscountRate,
//     "categories_allow_ratings": categoriesAllowRatings,
//     "categories_allow_comparison": categoriesAllowComparison,
//     "categories_status": categoriesStatus,
//     "categories_position": categoriesPosition,
//     "categories_created_at": categoriesCreatedAt!.toIso8601String(),
//     "categories_updated_at": categoriesUpdatedAt!.toIso8601String(),
//     "lft": lft,
//     "rgt": rgt,
//     "depth": depth,
//     "categories_title": categoriesTitle,
//     "categories_desc": categoriesDesc == null ? null : categoriesDesc,
//     "categories_slug": categoriesSlug == null ? null : categoriesSlug,
//     "categories_seo_title": categoriesSeoTitle == null ? null : categoriesSeoTitle,
//     "categories_seo_desc": categoriesSeoDesc == null ? null : categoriesSeoDesc,
//     "categories_seo_keyword": categoriesSeoKeyword == null ? null : categoriesSeoKeyword,
//     "categories_footer_code": categoriesFooterCode,
//     "subcategories": List<dynamic>.from(subcategories!.map((x) => x.toJson())),
//     "translations": List<dynamic>.from(translations!.map((x) => x.toJson())),
//   };
// }
class CategoryTranslation {
  CategoryTranslation({
    this.categoriesTransId,
    this.categoriesId,
    this.locale,
    this.categoriesTitle,
    this.categoriesDesc,
    this.categoriesSlug,
    this.categoriesSeoTitle,
    this.categoriesSeoDesc,
    this.categoriesSeoKeyword,
    this.categoriesFooterCode,
  });

  int? categoriesTransId;
  String? categoriesId;
  String? locale;
  String? categoriesTitle;
  String? categoriesDesc;
  String? categoriesSlug;
  String? categoriesSeoTitle;
  String? categoriesSeoDesc;
  String? categoriesSeoKeyword;
  String? categoriesFooterCode;

  factory CategoryTranslation.fromJson(Map<String, dynamic> json) =>
      CategoryTranslation(
        categoriesTransId: json["categories_trans_id"],
        categoriesId: json["categories_id"],
        locale: json["locale"],
        categoriesTitle: json["categories_title"],
        categoriesDesc:
            json["categories_desc"] == null ? null : json["categories_desc"],
        categoriesSlug:
            json["categories_slug"] == null ? null : json["categories_slug"],
        categoriesSeoTitle: json["categories_seo_title"] == null
            ? null
            : json["categories_seo_title"],
        categoriesSeoDesc: json["categories_seo_desc"] == null
            ? null
            : json["categories_seo_desc"],
        categoriesSeoKeyword: json["categories_seo_keyword"] == null
            ? null
            : json["categories_seo_keyword"],
        categoriesFooterCode: json["categories_footer_code"] == null
            ? null
            : json["categories_footer_code"],
      );

  Map<String, dynamic> toJson() => {
        "categories_trans_id": categoriesTransId,
        "categories_id": categoriesId,
        "locale": locale,
        "categories_title": categoriesTitle,
        "categories_desc": categoriesDesc == null ? null : categoriesDesc,
        "categories_slug": categoriesSlug == null ? null : categoriesSlug,
        "categories_seo_title":
            categoriesSeoTitle == null ? null : categoriesSeoTitle,
        "categories_seo_desc":
            categoriesSeoDesc == null ? null : categoriesSeoDesc,
        "categories_seo_keyword":
            categoriesSeoKeyword == null ? null : categoriesSeoKeyword,
        "categories_footer_code":
            categoriesFooterCode == null ? null : categoriesFooterCode,
      };
}
