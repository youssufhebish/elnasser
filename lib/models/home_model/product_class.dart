import 'package:equatable/equatable.dart';

import '../account_model.dart';
import 'atributes.dart';
import 'category.dart';
import 'offers.dart';
import 'product_images_list.dart';

import 'dart:convert';

class Pagination {
  Pagination({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
      };
}

class ProductClass {
  ProductClass({
    this.productsId,
    this.fkCategoriesId,
    this.productsCode,
    this.productsBarcode,
    this.productsImg,
    this.productsPrice,
    this.productsPoints,
    this.productsCalories,
    this.productsVideo,
    this.productsType,
    this.productsLowestWeightAvailable,
    this.productsStocks,
    this.productsRating,
    this.offersId,
    this.isFav,
    this.isNotify,
    this.isNew,
    this.mostWanted,
    this.stock,
    this.attributes,
    this.categorySeries,
    this.trans,
    this.category,
    this.suggestions,
    this.similarProducts,
    this.productsChoices,
    this.offer,
    this.images,
  });

  int? productsId;
  String? fkCategoriesId;
  String? productsCode;
  String? productsBarcode;
  String? productsImg;
  String? productsPrice;
  String? productsPoints;
  bool? productsCalories;
  String? productsVideo;
  String? productsType;
  String? productsLowestWeightAvailable;
  dynamic productsStocks;
  String? productsRating;
  String? offersId;
  int? isFav;
  int? isNotify;
  int? isNew;
  int? mostWanted;
  dynamic stock;
  List<AttributeElement>? attributes;
  List<CategorySery>? categorySeries;
  List<SimilarProductTran>? trans;
  Category? category;
  List<ProductClass>? suggestions;
  List<SimilarProduct>? similarProducts;
  List<ProductsChoice>? productsChoices;
  Offer? offer;
  List<ProductImagesList>? images;

  factory ProductClass.fromJson(Map<String, dynamic> json) => ProductClass(
        productsId: json["products_id"] == null ? null : json["products_id"],
        fkCategoriesId:
            json["FK_categories_id"] == null ? null : json["FK_categories_id"],
        productsCode:
            json["products_code"] == null ? null : json["products_code"],
        productsBarcode:
            json["products_barcode"] == null ? null : json["products_barcode"],
        productsImg: json["products_img"] == null ? null : json["products_img"],
        productsPrice:
            json["products_price"] == null ? null : json["products_price"],
        productsPoints:
            json["products_points"] == null ? null : json["products_points"],
        productsCalories: json["products_calories"] == null
            ? null
            : json["products_calories"],
        productsVideo:
            json["products_video"] == null ? null : json["products_video"],
        productsType:
            json["products_type"] == null ? null : json["products_type"],
        productsLowestWeightAvailable:
            json["products_lowest_weight_available"] == null
                ? null
                : json["products_lowest_weight_available"],
        productsStocks:
            json["products_stocks"] == null ? null : json["products_stocks"],
        productsRating:
            json["products_rating"] == null ? null : json["products_rating"],
        offersId: json["offers_id"] == null ? null : json["offers_id"],
        isFav: json["is_fav"] == null ? null : json["is_fav"],
        isNotify: json["is_notify"] == null ? null : json["is_notify"],
        isNew: json["is_new"] == null ? null : json["is_new"],
        mostWanted: json["most_wanted"] == null ? null : json["most_wanted"],
        stock: json["stock"] == null ? null : json["stock"],
        attributes: json["attributes"] == null
            ? null
            : List<AttributeElement>.from(
                json["attributes"].map((x) => AttributeElement.fromJson(x))),
        categorySeries: json["category_series"] == null
            ? null
            : List<CategorySery>.from(
                json["category_series"].map((x) => CategorySery.fromJson(x))),
        trans: json["trans"] == null
            ? null
            : List<SimilarProductTran>.from(
                json["trans"].map((x) => SimilarProductTran.fromJson(x))),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        suggestions: json["suggestions"] == null
            ? null
            : List<ProductClass>.from(
                json["suggestions"].map((x) => ProductClass.fromJson(x))),
        similarProducts: json["similar_products"] == null
            ? null
            : List<SimilarProduct>.from(json["similar_products"]
                .map((x) => SimilarProduct.fromJson(x))),
        productsChoices: json["products_choices"] == null
            ? null
            : List<ProductsChoice>.from(json["products_choices"]
                .map((x) => ProductsChoice.fromJson(x))),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        images: json["images"] == null
            ? null
            : List<ProductImagesList>.from(
                json["images"].map((x) => ProductImagesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products_id": productsId == null ? null : productsId,
        "FK_categories_id": fkCategoriesId == null ? null : fkCategoriesId,
        "products_code": productsCode == null ? null : productsCode,
        "products_barcode": productsBarcode == null ? null : productsBarcode,
        "products_img": productsImg == null ? null : productsImg,
        "products_price": productsPrice == null ? null : productsPrice,
        "products_points": productsPoints == null ? null : productsPoints,
        "products_calories": productsCalories == null ? null : productsCalories,
        "products_video": productsVideo == null ? null : productsVideo,
        "products_type": productsType == null ? null : productsType,
        "products_lowest_weight_available":
            productsLowestWeightAvailable == null
                ? null
                : productsLowestWeightAvailable,
        "products_stocks": productsStocks == null ? null : productsStocks,
        "products_rating": productsRating == null ? null : productsRating,
        "offers_id": offersId == null ? null : offersId,
        "is_fav": isFav == null ? null : isFav,
        "is_notify": isNotify == null ? null : isNotify,
        "is_new": isNew == null ? null : isNew,
        "most_wanted": mostWanted == null ? null : mostWanted,
        "stock": stock == null ? null : stock,
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "category_series": categorySeries == null
            ? null
            : List<dynamic>.from(categorySeries!.map((x) => x.toJson())),
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
        "category": category == null ? null : category!.toJson(),
        "suggestions": suggestions == null
            ? null
            : List<dynamic>.from(suggestions!.map((x) => x.toJson())),
        "similar_products": similarProducts == null
            ? null
            : List<dynamic>.from(similarProducts!.map((x) => x.toJson())),
        "products_choices": productsChoices == null
            ? null
            : List<dynamic>.from(productsChoices!.map((x) => x.toJson())),
        "offer": offer == null ? null : offer!.toJson(),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class AttributeElement {
  AttributeElement({
    this.attributesId,
    this.attributesImage,
    this.productsChoicesIds,
    this.productsChoicesImages,
    this.trans,
  });

  int? attributesId;
  String? attributesImage;
  List<int>? productsChoicesIds;
  List<int>? productsChoicesImages;
  List<AttributeTran>? trans;

  factory AttributeElement.fromJson(Map<String, dynamic> json) =>
      AttributeElement(
        attributesId:
            json["attributes_id"] == null ? null : json["attributes_id"],
        attributesImage:
            json["attributes_image"] == null ? null : json["attributes_image"],
        productsChoicesIds: json["products_choices_ids"] == null
            ? null
            : List<int>.from(json["products_choices_ids"].map((x) => x)),
        productsChoicesImages: json["products_choices_images"] == null
            ? null
            : List<int>.from(json["products_choices_images"].map((x) => x)),
        trans: json["trans"] == null
            ? null
            : List<AttributeTran>.from(
                json["trans"].map((x) => AttributeTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributes_id": attributesId == null ? null : attributesId,
        "attributes_image": attributesImage == null ? null : attributesImage,
        "products_choices_ids": productsChoicesIds == null
            ? null
            : List<dynamic>.from(productsChoicesIds!.map((x) => x)),
        "products_choices_images": productsChoicesImages == null
            ? null
            : List<dynamic>.from(productsChoicesImages!.map((x) => x)),
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
      };
}

class AttributeTran {
  AttributeTran({
    this.attributesTransId,
    this.attributesId,
    this.locale,
    this.attributesTitle,
  });

  int? attributesTransId;
  String? attributesId;
  String? locale;
  String? attributesTitle;

  factory AttributeTran.fromJson(Map<String, dynamic> json) => AttributeTran(
        attributesTransId: json["attributes_trans_id"] == null
            ? null
            : json["attributes_trans_id"],
        attributesId:
            json["attributes_id"] == null ? null : json["attributes_id"],
        locale: json["locale"] == null ? null : json["locale"],
        attributesTitle:
            json["attributes_title"] == null ? null : json["attributes_title"],
      );

  Map<String, dynamic> toJson() => {
        "attributes_trans_id":
            attributesTransId == null ? null : attributesTransId,
        "attributes_id": attributesId == null ? null : attributesId,
        "locale": locale == null ? null : locale!,
        "attributes_title": attributesTitle == null ? null : attributesTitle!,
      };
}

class Category {
  Category({
    this.categoriesId,
    this.categoriesCode,
    this.categoriesParentId,
    this.categoriesImg,
    this.categoriesBannerImg,
    this.categoriesFollowDeliveryTime,
    this.trans,
  });

  int? categoriesId;
  String? categoriesCode;
  String? categoriesParentId;
  dynamic categoriesImg;
  dynamic categoriesBannerImg;
  String? categoriesFollowDeliveryTime;
  List<CategoryTran>? trans;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoriesId:
            json["categories_id"] == null ? null : json["categories_id"],
        categoriesCode:
            json["categories_code"] == null ? null : json["categories_code"],
        categoriesParentId: json["categories_parent_id"] == null
            ? null
            : json["categories_parent_id"],
        categoriesImg: json["categories_img"],
        categoriesBannerImg: json["categories_banner_img"],
        categoriesFollowDeliveryTime:
            json["categories_follow_delivery_time"] == null
                ? null
                : json["categories_follow_delivery_time"],
        trans: json["trans"] == null
            ? null
            : List<CategoryTran>.from(
                json["trans"].map((x) => CategoryTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories_id": categoriesId == null ? null : categoriesId,
        "categories_code": categoriesCode == null ? null : categoriesCode,
        "categories_parent_id":
            categoriesParentId == null ? null : categoriesParentId,
        "categories_img": categoriesImg,
        "categories_banner_img": categoriesBannerImg,
        "categories_follow_delivery_time": categoriesFollowDeliveryTime == null
            ? null
            : categoriesFollowDeliveryTime,
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
      };
}

class CategoryTran {
  CategoryTran({
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

  factory CategoryTran.fromJson(Map<String, dynamic> json) => CategoryTran(
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
            categoriesSeoTitle == null ? null : categoriesSeoTitle!,
        "categories_seo_desc":
            categoriesSeoDesc == null ? null : categoriesSeoDesc!,
        "categories_seo_keyword":
            categoriesSeoKeyword == null ? null : categoriesSeoKeyword!,
        "categories_footer_code":
            categoriesFooterCode == null ? null : categoriesFooterCode,
      };
}

class CategorySery {
  CategorySery({
    this.categoriesId,
    this.trans,
  });

  int? categoriesId;
  List<CategoryTran>? trans;

  factory CategorySery.fromJson(Map<String, dynamic> json) => CategorySery(
        categoriesId:
            json["categories_id"] == null ? null : json["categories_id"],
        trans: json["trans"] == null
            ? null
            : List<CategoryTran>.from(
                json["trans"].map((x) => CategoryTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories_id": categoriesId == null ? null : categoriesId,
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
      };
}

class ProductsChoice {
  ProductsChoice({
    this.productsChoicesId,
    this.fkAccountsId,
    this.fkProductsId,
    this.fkChoicesIds,
    this.fkAttributesId,
    this.productsChoicesCode,
    this.productsChoicesPrice,
    this.offersId,
    this.productsChoicesType,
    this.productsChoicesImages,
    this.stock,
    this.images,
    this.choices,
    this.attribute,
    this.productChoiceStock,
  });

  int? productsChoicesId;
  String? fkAccountsId;
  String? fkProductsId;
  List<int>? fkChoicesIds;
  String? fkAttributesId;
  String? productsChoicesCode;
  String? productsChoicesPrice;
  dynamic offersId;
  String? productsChoicesType;
  List<int>? productsChoicesImages;
  dynamic stock;
  List<ProductImagesList>? images;
  List<Choice>? choices;
  ProductsChoiceAttribute? attribute;
  ProductChoiceStock? productChoiceStock;

  factory ProductsChoice.fromJson(Map<String, dynamic> json) => ProductsChoice(
        productsChoicesId: json["products_choices_id"] == null
            ? null
            : json["products_choices_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkProductsId:
            json["FK_products_id"] == null ? null : json["FK_products_id"],
        fkChoicesIds: json["FK_choices_ids"] == null
            ? null
            : List<int>.from(json["FK_choices_ids"].map((x) => x)),
        fkAttributesId:
            json["FK_attributes_id"] == null ? null : json["FK_attributes_id"],
        productsChoicesCode: json["products_choices_code"] == null
            ? null
            : json["products_choices_code"],
        productsChoicesPrice: json["products_choices_price"] == null
            ? null
            : json["products_choices_price"],
        offersId: json["offers_id"],
        productsChoicesType: json["products_choices_type"] == null
            ? null
            : json["products_choices_type"],
        productsChoicesImages: json["products_choices_images"] == null
            ? null
            : List<int>.from(json["products_choices_images"].map((x) => x)),
        stock: json["stock"],
        images: json["images"] == null
            ? null
            : List<ProductImagesList>.from(
                json["images"].map((x) => ProductImagesList.fromJson(x))),
        choices: json["choices"] == null
            ? null
            : List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        attribute: json["attribute"] == null
            ? null
            : ProductsChoiceAttribute.fromJson(json["attribute"]),
        productChoiceStock: json["product_choice_stock"] == null
            ? null
            : ProductChoiceStock.fromJson(json["product_choice_stock"]),
      );

  Map<String, dynamic> toJson() => {
        "products_choices_id":
            productsChoicesId == null ? null : productsChoicesId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_products_id": fkProductsId == null ? null : fkProductsId,
        "FK_choices_ids": fkChoicesIds == null
            ? null
            : List<dynamic>.from(fkChoicesIds!.map((x) => x)),
        "FK_attributes_id": fkAttributesId == null ? null : fkAttributesId,
        "products_choices_code":
            productsChoicesCode == null ? null : productsChoicesCode,
        "products_choices_price":
            productsChoicesPrice == null ? null : productsChoicesPrice,
        "offers_id": offersId,
        "products_choices_type":
            productsChoicesType == null ? null : productsChoicesType,
        "products_choices_images": productsChoicesImages == null
            ? null
            : List<dynamic>.from(productsChoicesImages!.map((x) => x)),
        "stock": stock,
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "choices": choices == null
            ? null
            : List<dynamic>.from(choices!.map((x) => x.toJson())),
        "attribute": attribute == null ? null : attribute!.toJson(),
        "product_choice_stock":
            productChoiceStock == null ? null : productChoiceStock!.toJson(),
      };
}

class ProductsChoiceAttribute {
  ProductsChoiceAttribute({
    this.attributesId,
    this.attributesImage,
    this.trans,
  });

  int? attributesId;
  String? attributesImage;
  List<AttributeTran>? trans;

  factory ProductsChoiceAttribute.fromJson(Map<String, dynamic> json) =>
      ProductsChoiceAttribute(
        attributesId:
            json["attributes_id"] == null ? null : json["attributes_id"],
        attributesImage:
            json["attributes_image"] == null ? null : json["attributes_image"],
        trans: json["trans"] == null
            ? null
            : List<AttributeTran>.from(
                json["trans"].map((x) => AttributeTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributes_id": attributesId == null ? null : attributesId,
        "attributes_image": attributesImage == null ? null : attributesImage,
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
      };
}

class SimilarProduct {
  SimilarProduct({
    this.productsId,
    this.fkCategoriesId,
    this.productsCode,
    this.productsBarcode,
    this.productsImg,
    this.productsPrice,
    this.productsPoints,
    this.productsCalories,
    this.productsVideo,
    this.productsType,
    this.productsLowestWeightAvailable,
    this.productsStocks,
    this.productsRating,
    this.offersId,
    this.isFav,
    this.isNotify,
    this.isNew,
    this.mostWanted,
    this.stock,
    this.attributes,
    this.categorySeries,
    this.pivot,
    this.trans,
    this.productsChoices,
    this.images,
    this.offer,
    this.category,
  });

  int? productsId;
  String? fkCategoriesId;
  String? productsCode;
  String? productsBarcode;
  String? productsImg;
  String? productsPrice;
  String? productsPoints;
  bool? productsCalories;
  String? productsVideo;
  String? productsType;
  String? productsLowestWeightAvailable;
  dynamic productsStocks;
  String? productsRating;
  String? offersId;
  int? isFav;
  int? isNotify;
  int? isNew;
  int? mostWanted;
  dynamic stock;
  List<AttributeElement>? attributes;
  List<CategorySery>? categorySeries;
  SimilarProductPivot? pivot;
  List<SimilarProductTran>? trans;
  List<ProductsChoice>? productsChoices;
  List<ProductImagesList>? images;
  Offer? offer;
  Category? category;

  factory SimilarProduct.fromJson(Map<String, dynamic> json) => SimilarProduct(
        productsId: json["products_id"] == null ? null : json["products_id"],
        fkCategoriesId:
            json["FK_categories_id"] == null ? null : json["FK_categories_id"],
        productsCode:
            json["products_code"] == null ? null : json["products_code"],
        productsBarcode:
            json["products_barcode"] == null ? null : json["products_barcode"],
        productsImg: json["products_img"] == null ? null : json["products_img"],
        productsPrice:
            json["products_price"] == null ? null : json["products_price"],
        productsPoints:
            json["products_points"] == null ? null : json["products_points"],
        productsCalories: json["products_calories"] == null
            ? null
            : json["products_calories"],
        productsVideo:
            json["products_video"] == null ? null : json["products_video"],
        productsType:
            json["products_type"] == null ? null : json["products_type"],
        productsLowestWeightAvailable:
            json["products_lowest_weight_available"] == null
                ? null
                : json["products_lowest_weight_available"],
        productsStocks: json["products_stocks"],
        productsRating:
            json["products_rating"] == null ? null : json["products_rating"],
        offersId: json["offers_id"] == null ? null : json["offers_id"],
        isFav: json["is_fav"] == null ? null : json["is_fav"],
        isNotify: json["is_notify"] == null ? null : json["is_notify"],
        isNew: json["is_new"] == null ? null : json["is_new"],
        mostWanted: json["most_wanted"] == null ? null : json["most_wanted"],
        stock: json["stock"],
        attributes: json["attributes"] == null
            ? null
            : List<AttributeElement>.from(
                json["attributes"].map((x) => AttributeElement.fromJson(x))),
        categorySeries: json["category_series"] == null
            ? null
            : List<CategorySery>.from(
                json["category_series"].map((x) => CategorySery.fromJson(x))),
        pivot: json["pivot"] == null
            ? null
            : SimilarProductPivot.fromJson(json["pivot"]),
        trans: json["trans"] == null
            ? null
            : List<SimilarProductTran>.from(
                json["trans"].map((x) => SimilarProductTran.fromJson(x))),
        images: json["images"] == null
            ? null
            : List<ProductImagesList>.from(
                json["images"].map((x) => ProductImagesList.fromJson(x))),
        productsChoices: json["products_choices"] == null
            ? null
            : List<ProductsChoice>.from(json["products_choices"]
                .map((x) => ProductsChoice.fromJson(x))),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "products_id": productsId == null ? null : productsId,
        "FK_categories_id": fkCategoriesId == null ? null : fkCategoriesId,
        "products_code": productsCode == null ? null : productsCode,
        "products_barcode": productsBarcode == null ? null : productsBarcode,
        "products_img": productsImg == null ? null : productsImg,
        "products_price": productsPrice == null ? null : productsPrice,
        "products_points": productsPoints == null ? null : productsPoints,
        "products_calories": productsCalories == null ? null : productsCalories,
        "products_video": productsVideo == null ? null : productsVideo,
        "products_type": productsType == null ? null : productsType,
        "products_lowest_weight_available":
            productsLowestWeightAvailable == null
                ? null
                : productsLowestWeightAvailable,
        "products_stocks": productsStocks,
        "products_rating": productsRating == null ? null : productsRating,
        "offers_id": offersId == null ? null : offersId,
        "is_fav": isFav == null ? null : isFav,
        "is_notify": isNotify == null ? null : isNotify,
        "is_new": isNew == null ? null : isNew,
        "most_wanted": mostWanted == null ? null : mostWanted,
        "stock": stock,
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "category_series": categorySeries == null
            ? null
            : List<dynamic>.from(categorySeries!.map((x) => x.toJson())),
        "pivot": pivot == null ? null : pivot!.toJson(),
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
        "products_choices": productsChoices == null
            ? null
            : List<dynamic>.from(productsChoices!.map((x) => x.toJson())),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "offer": offer == null ? null : offer!.toJson(),
        "category": category == null ? null : category!.toJson(),
      };
}

class SimilarProductPivot {
  SimilarProductPivot({
    this.productsId,
    this.similarProductsId,
  });

  String? productsId;
  String? similarProductsId;

  factory SimilarProductPivot.fromJson(Map<String, dynamic> json) =>
      SimilarProductPivot(
        productsId: json["products_id"] == null ? null : json["products_id"],
        similarProductsId: json["similar_products_id"] == null
            ? null
            : json["similar_products_id"],
      );

  Map<String, dynamic> toJson() => {
        "products_id": productsId == null ? null : productsId,
        "similar_products_id":
            similarProductsId == null ? null : similarProductsId,
      };
}

class SimilarProductTran {
  SimilarProductTran({
    this.productsTransId,
    this.productsId,
    this.locale,
    this.productsTitle,
    this.productsDesc,
    this.productsTags,
    this.productsSlug,
    this.productsSeoTitle,
    this.productsSeoDesc,
    this.productsSeoKeyword,
  });

  int? productsTransId;
  String? productsId;
  String? locale;
  String? productsTitle;
  String? productsDesc;
  String? productsTags;
  String? productsSlug;
  String? productsSeoTitle;
  String? productsSeoDesc;
  String? productsSeoKeyword;

  factory SimilarProductTran.fromJson(Map<String, dynamic> json) =>
      SimilarProductTran(
        productsTransId: json["products_trans_id"] == null
            ? null
            : json["products_trans_id"],
        productsId: json["products_id"] == null ? null : json["products_id"],
        locale: json["locale"] == null ? null : json["locale"],
        productsTitle:
            json["products_title"] == null ? null : json["products_title"],
        productsDesc:
            json["products_desc"] == null ? null : json["products_desc"],
        productsTags:
            json["products_tags"] == null ? null : json["products_tags"],
        productsSlug:
            json["products_slug"] == null ? null : json["products_slug"],
        productsSeoTitle: json["products_seo_title"] == null
            ? null
            : json["products_seo_title"],
        productsSeoDesc: json["products_seo_desc"] == null
            ? null
            : json["products_seo_desc"],
        productsSeoKeyword: json["products_seo_keyword"] == null
            ? null
            : json["products_seo_keyword"],
      );

  Map<String, dynamic> toJson() => {
        "products_trans_id": productsTransId == null ? null : productsTransId,
        "products_id": productsId == null ? null : productsId,
        "locale": locale == null ? null : locale!,
        "products_title": productsTitle == null ? null : productsTitle,
        "products_desc": productsDesc == null ? null : productsDesc,
        "products_tags": productsTags == null ? null : productsTags,
        "products_slug": productsSlug == null ? null : productsSlug,
        "products_seo_title":
            productsSeoTitle == null ? null : productsSeoTitle,
        "products_seo_desc": productsSeoDesc == null ? null : productsSeoDesc,
        "products_seo_keyword":
            productsSeoKeyword == null ? null : productsSeoKeyword,
      };
}

class Rating {
  Rating({
    this.ratingsId,
    this.fkAccountsId,
    this.fkCustomersId,
    this.productsId,
    this.ratingsQuality,
    this.ratingsPrice,
    this.ratingsSize,
    this.ratingsMatchPicture,
    this.ratingsValue,
    this.ratingsText,
    this.ratingsStatus,
    this.accessLevel,
    this.ratingsCreatedAt,
    this.ratingsUpdatedAt,
    this.customer,
  });

  int? ratingsId;
  String? fkAccountsId;
  String? fkCustomersId;
  String? productsId;
  String? ratingsQuality;
  String? ratingsPrice;
  String? ratingsSize;
  String? ratingsMatchPicture;
  String? ratingsValue;
  String? ratingsText;
  String? ratingsStatus;
  String? accessLevel;
  DateTime? ratingsCreatedAt;
  DateTime? ratingsUpdatedAt;
  Customer? customer;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        ratingsId: json["ratings_id"] == null ? null : json["ratings_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        fkCustomersId:
            json["FK_customers_id"] == null ? null : json["FK_customers_id"],
        productsId: json["products_id"] == null ? null : json["products_id"],
        ratingsQuality:
            json["ratings_quality"] == null ? null : json["ratings_quality"],
        ratingsPrice:
            json["ratings_price"] == null ? null : json["ratings_price"],
        ratingsSize: json["ratings_size"] == null ? null : json["ratings_size"],
        ratingsMatchPicture: json["ratings_match_picture"] == null
            ? null
            : json["ratings_match_picture"],
        ratingsValue:
            json["ratings_value"] == null ? null : json["ratings_value"],
        ratingsText: json["ratings_text"] == null ? null : json["ratings_text"],
        ratingsStatus:
            json["ratings_status"] == null ? null : json["ratings_status"],
        accessLevel: json["access_level"] == null ? null : json["access_level"],
        ratingsCreatedAt: json["ratings_created_at"] == null
            ? null
            : DateTime.parse(json["ratings_created_at"]),
        ratingsUpdatedAt: json["ratings_updated_at"] == null
            ? null
            : DateTime.parse(json["ratings_updated_at"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "ratings_id": ratingsId == null ? null : ratingsId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "FK_customers_id": fkCustomersId == null ? null : fkCustomersId,
        "products_id": productsId == null ? null : productsId,
        "ratings_quality": ratingsQuality == null ? null : ratingsQuality,
        "ratings_price": ratingsPrice == null ? null : ratingsPrice,
        "ratings_size": ratingsSize == null ? null : ratingsSize,
        "ratings_match_picture":
            ratingsMatchPicture == null ? null : ratingsMatchPicture,
        "ratings_value": ratingsValue == null ? null : ratingsValue,
        "ratings_text": ratingsText == null ? null : ratingsText,
        "ratings_status": ratingsStatus == null ? null : ratingsStatus,
        "access_level": accessLevel == null ? null : accessLevel,
        "ratings_created_at": ratingsCreatedAt == null
            ? null
            : ratingsCreatedAt!.toIso8601String(),
        "ratings_updated_at": ratingsUpdatedAt == null
            ? null
            : ratingsUpdatedAt!.toIso8601String(),
        "customer": customer == null ? null : customer!.toJson(),
      };
}

class Customer {
  Customer({
    this.customersId,
    this.fkAccountsId,
    this.customersName,
    this.customersEmail,
    this.customersPhone,
    this.customersCountryCode,
    this.customersBirthday,
    this.customersGender,
    this.customersStatus,
    this.emailVerified,
    this.phoneVerified,
    this.customersWallet,
    this.customersDiscountPoints,
    this.customersLevelPoints,
    this.provider,
    this.providerId,
    this.customersCreatedAt,
    this.customersUpdatedAt,
  });

  int? customersId;
  String? fkAccountsId;
  String? customersName;
  String? customersEmail;
  String? customersPhone;
  String? customersCountryCode;
  DateTime? customersBirthday;
  String? customersGender;
  String? customersStatus;
  String? emailVerified;
  String? phoneVerified;
  String? customersWallet;
  String? customersDiscountPoints;
  String? customersLevelPoints;
  dynamic provider;
  dynamic providerId;
  DateTime? customersCreatedAt;
  DateTime? customersUpdatedAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customersId: json["customers_id"] == null ? null : json["customers_id"],
        fkAccountsId:
            json["FK_accounts_id"] == null ? null : json["FK_accounts_id"],
        customersName:
            json["customers_name"] == null ? null : json["customers_name"],
        customersEmail:
            json["customers_email"] == null ? null : json["customers_email"],
        customersPhone:
            json["customers_phone"] == null ? null : json["customers_phone"],
        customersCountryCode: json["customers_country_code"] == null
            ? null
            : json["customers_country_code"],
        customersBirthday: json["customers_birthday"] == null
            ? null
            : DateTime.parse(json["customers_birthday"]),
        customersGender:
            json["customers_gender"] == null ? null : json["customers_gender"],
        customersStatus:
            json["customers_status"] == null ? null : json["customers_status"],
        emailVerified:
            json["email_verified"] == null ? null : json["email_verified"],
        phoneVerified:
            json["phone_verified"] == null ? null : json["phone_verified"],
        customersWallet:
            json["customers_wallet"] == null ? null : json["customers_wallet"],
        customersDiscountPoints: json["customers_discount_points"] == null
            ? null
            : json["customers_discount_points"],
        customersLevelPoints: json["customers_level_points"] == null
            ? null
            : json["customers_level_points"],
        provider: json["provider"],
        providerId: json["provider_id"],
        customersCreatedAt: json["customers_created_at"] == null
            ? null
            : DateTime.parse(json["customers_created_at"]),
        customersUpdatedAt: json["customers_updated_at"] == null
            ? null
            : DateTime.parse(json["customers_updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "customers_id": customersId == null ? null : customersId,
        "FK_accounts_id": fkAccountsId == null ? null : fkAccountsId,
        "customers_name": customersName == null ? null : customersName,
        "customers_email": customersEmail == null ? null : customersEmail,
        "customers_phone": customersPhone == null ? null : customersPhone,
        "customers_country_code":
            customersCountryCode == null ? null : customersCountryCode,
        "customers_birthday": customersBirthday == null
            ? null
            : "${customersBirthday!.year.toString().padLeft(4, '0')}-${customersBirthday!.month.toString().padLeft(2, '0')}-${customersBirthday!.day.toString().padLeft(2, '0')}",
        "customers_gender": customersGender == null ? null : customersGender,
        "customers_status": customersStatus == null ? null : customersStatus,
        "email_verified": emailVerified == null ? null : emailVerified,
        "phone_verified": phoneVerified == null ? null : phoneVerified,
        "customers_wallet": customersWallet == null ? null : customersWallet,
        "customers_discount_points":
            customersDiscountPoints == null ? null : customersDiscountPoints,
        "customers_level_points":
            customersLevelPoints == null ? null : customersLevelPoints,
        "provider": provider,
        "provider_id": providerId,
        "customers_created_at": customersCreatedAt == null
            ? null
            : customersCreatedAt!.toIso8601String(),
        "customers_updated_at": customersUpdatedAt == null
            ? null
            : customersUpdatedAt!.toIso8601String(),
      };
}

class Pivot {
  Pivot({
    this.fkCustomersId,
    this.fkProductsId,
  });

  String? fkCustomersId;
  String? fkProductsId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        fkCustomersId:
            json["FK_customers_id"] == null ? null : json["FK_customers_id"],
        fkProductsId:
            json["FK_products_id"] == null ? null : json["FK_products_id"],
      );

  Map<String, dynamic> toJson() => {
        "FK_customers_id": fkCustomersId == null ? null : fkCustomersId,
        "FK_products_id": fkProductsId == null ? null : fkProductsId,
      };
}

class ProductTranslation {
  ProductTranslation({
    this.productsTransId,
    this.productsId,
    this.locale,
    this.productsTitle,
    this.productsDesc,
    this.productsTags,
    this.productsSlug,
    this.productsSeoTitle,
    this.productsSeoDesc,
    this.productsSeoKeyword,
  });

  int? productsTransId;
  String? productsId;
  String? locale;
  String? productsTitle;
  String? productsDesc;
  String? productsTags;
  String? productsSlug;
  String? productsSeoTitle;
  String? productsSeoDesc;
  String? productsSeoKeyword;

  factory ProductTranslation.fromJson(Map<String, dynamic> json) =>
      ProductTranslation(
        productsTransId: json["products_trans_id"],
        productsId: json["products_id"],
        locale: json["locale"],
        productsTitle: json["products_title"],
        productsDesc:
            json["products_desc"] == null ? null : json["products_desc"],
        productsTags:
            json["products_tags"] == null ? null : json["products_tags"],
        productsSlug: json["products_slug"],
        productsSeoTitle: json["products_seo_title"] == null
            ? null
            : json["products_seo_title"],
        productsSeoDesc: json["products_seo_desc"] == null
            ? null
            : json["products_seo_desc"],
        productsSeoKeyword: json["products_seo_keyword"] == null
            ? null
            : json["products_seo_keyword"],
      );

  Map<String, dynamic> toJson() => {
        "products_trans_id": productsTransId,
        "products_id": productsId,
        "locale": locale,
        "products_title": productsTitle,
        "products_desc": productsDesc == null ? null : productsDesc,
        "products_tags": productsTags == null ? null : productsTags,
        "products_slug": productsSlug,
        "products_seo_title":
            productsSeoTitle == null ? null : productsSeoTitle,
        "products_seo_desc": productsSeoDesc == null ? null : productsSeoDesc,
        "products_seo_keyword":
            productsSeoKeyword == null ? null : productsSeoKeyword,
      };
}

class Orderproduct {
  Orderproduct({
    this.ordersItemsId,
    this.fkOrdersId,
    this.fkProductsId,
    this.fkOffersId,
    this.fkChoicesId,
    this.ordersItemsPrice,
    this.ordersItemsPriceBeforeSale,
    this.ordersItemsCount,
    this.ordersItemsTotal,
  });

  int? ordersItemsId;
  String? fkOrdersId;
  String? fkProductsId;
  dynamic fkOffersId;
  dynamic fkChoicesId;
  String? ordersItemsPrice;
  String? ordersItemsPriceBeforeSale;
  String? ordersItemsCount;
  String? ordersItemsTotal;

  factory Orderproduct.fromJson(Map<String, dynamic> json) => Orderproduct(
        ordersItemsId: json["orders_items_id"],
        fkOrdersId: json["FK_orders_id"],
        fkProductsId: json["FK_products_id"],
        fkOffersId: json["FK_offers_id"],
        fkChoicesId: json["FK_choices_id"],
        ordersItemsPrice: json["orders_items_price"],
        ordersItemsPriceBeforeSale:
            json["orders_items_price_before_sale"] == null
                ? null
                : json["orders_items_price_before_sale"],
        ordersItemsCount: json["orders_items_count"],
        ordersItemsTotal: json["orders_items_total"],
      );

  Map<String, dynamic> toJson() => {
        "orders_items_id": ordersItemsId,
        "FK_orders_id": fkOrdersId,
        "FK_products_id": fkProductsId,
        "FK_offers_id": fkOffersId,
        "FK_choices_id": fkChoicesId,
        "orders_items_price": ordersItemsPrice,
        "orders_items_price_before_sale": ordersItemsPriceBeforeSale == null
            ? null
            : ordersItemsPriceBeforeSale,
        "orders_items_count": ordersItemsCount,
        "orders_items_total": ordersItemsTotal,
      };
}
