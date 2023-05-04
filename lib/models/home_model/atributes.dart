import '../account_model.dart';
import 'offers.dart';
import 'product_images_list.dart';

class AttributeProductsChoice {
  AttributeProductsChoice(
      {this.productsChoicesId,
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
      this.choices,
      this.attribute,
      this.account,
      this.productChoiceStock,
      this.images,
      this.offer});

  int? productsChoicesId;
  String? fkAccountsId;
  String? fkProductsId;
  List<int>? fkChoicesIds;
  String? fkAttributesId;
  String? productsChoicesCode;
  String? productsChoicesPrice;
  String? offersId;
  String? productsChoicesType;
  List<int>? productsChoicesImages;
  List<ProductImagesList>? images;
  dynamic stock;
  List<Choice>? choices;
  Attribute? attribute;
  Account? account;
  Offer? offer;
  ProductChoiceStock? productChoiceStock;

  factory AttributeProductsChoice.fromJson(Map<String, dynamic> json) =>
      AttributeProductsChoice(
        productsChoicesId: json["products_choices_id"],
        fkAccountsId: json["FK_accounts_id"],
        fkProductsId: json["FK_products_id"],
        fkChoicesIds: List<int>.from(json["FK_choices_ids"].map((x) => x)),
        fkAttributesId: json["FK_attributes_id"],
        productsChoicesCode: json["products_choices_code"],
        productsChoicesPrice: json["products_choices_price"],
        offersId: json["offers_id"] == null ? null : json["offers_id"],
        productsChoicesType: json["products_choices_type"],
        productsChoicesImages: json["products_choices_images"] == null
            ? null
            : List<int>.from(json["products_choices_images"].map((x) => x)),
        stock: json["stock"],
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        images: List<ProductImagesList>.from(
            json["images"].map((x) => ProductImagesList.fromJson(x))),
        attribute: json["attribute"] == null
            ? null
            : Attribute.fromJson(json["attribute"]),
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        productChoiceStock: json["product_choice_stock"] == null
            ? null
            : ProductChoiceStock.fromJson(json["product_choice_stock"]),
      );

  Map<String, dynamic> toJson() => {
        "products_choices_id": productsChoicesId,
        "FK_accounts_id": fkAccountsId,
        "FK_products_id": fkProductsId,
        "FK_choices_ids": List<dynamic>.from(fkChoicesIds!.map((x) => x)),
        "FK_attributes_id": fkAttributesId,
        "products_choices_code": productsChoicesCode,
        "products_choices_price": productsChoicesPrice,
        "offers_id": offersId == null ? null : offersId,
        "products_choices_type": productsChoicesType,
        "products_choices_images":
            List<dynamic>.from(productsChoicesImages!.map((x) => x)),
        "stock": stock,
        "choices": List<dynamic>.from(choices!.map((x) => x.toJson())),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "attribute": attribute == null ? null : attribute!.toJson(),
        "account": account == null ? null : account!.toJson(),
        "offer": offer == null ? null : offer!.toJson(),
        "product_choice_stock":
            productChoiceStock == null ? null : productChoiceStock!.toJson(),
      };
}

// class Attribute {
//   Attribute({
//     this.attributesId,
//     this.fkAccountsId,
//     this.attributesCode,
//     this.attributesImage,
//     this.attributesStatus,
//     this.attributesCreatedAt,
//     this.attributesUpdatedAt,
//     this.productsChoices,
//     this.productsChoicesImages,
//     this.attributesTitle,
//
//
//
//   });
//
//   int? attributesId;
//   String? fkAccountsId;
//   String? attributesCode;
//   String? attributesImage;
//   String? attributesStatus;
//   DateTime? attributesCreatedAt;
//   DateTime? attributesUpdatedAt;
//   List<AttributeProductsChoice >? productsChoices;
//   List<int>? productsChoicesImages;
//   String? attributesTitle;
//
//   factory Attribute.fromJson(Map<String , dynamic>  json) => Attribute(
//     attributesId: json["attributes_id"],
//     fkAccountsId: json["FK_accounts_id"],
//     attributesCode: json["attributes_code"],
//     attributesImage: json["attributes_image"],
//     attributesStatus: json["attributes_status"],
//     attributesCreatedAt: DateTime.parse(json["attributes_created_at"]),
//     attributesUpdatedAt: DateTime.parse(json["attributes_updated_at"]),
//     productsChoices: json["products_choices"] == null ? null : List<AttributeProductsChoice >.from(json["products_choices"].map((x) => AttributeProductsChoice.fromJson(x))),
//     productsChoicesImages:  json["products_choices_images"] == null ? null : List<int >.from(json["products_choices_images"].map((x) => x)),
//     attributesTitle: json["attributes_title"],
//   );
//
//
//   Map<String , dynamic>  toJson() => {
//     "attributes_id": attributesId,
//     "FK_accounts_id": fkAccountsId,
//     "attributes_code": attributesCode,
//     "attributes_image": attributesImage,
//     "attributes_status": attributesStatus,
//     "attributes_created_at": attributesCreatedAt!.toIso8601String(),
//     "attributes_updated_at": attributesUpdatedAt!.toIso8601String(),
//     "products_choices": productsChoices == null ? null : List<dynamic>.from(productsChoices!.map((x) => x.toJson())),
//     "products_choices_images": productsChoicesImages == null ? null:List<dynamic>.from(productsChoicesImages!.map((x) => x)),
//     "attributes_title": attributesTitle,
//   };
// }
class Attribute {
  Attribute({
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

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
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

class Choice {
  Choice({
    this.choicesId,
    this.trans,
  });

  int? choicesId;
  List<ChoiceTran>? trans;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        choicesId: json["choices_id"] == null ? null : json["choices_id"],
        trans: json["trans"] == null
            ? null
            : List<ChoiceTran>.from(
                json["trans"].map((x) => ChoiceTran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "choices_id": choicesId == null ? null : choicesId,
        "trans": trans == null
            ? null
            : List<dynamic>.from(trans!.map((x) => x.toJson())),
      };
}

class ProductChoiceStock {
  ProductChoiceStock({
    this.productsBranchesId,
    this.productsId,
    this.productsChoicesId,
    this.branchesId,
    this.productsStock,
  });

  int? productsBranchesId;
  String? productsId;
  String? productsChoicesId;
  String? branchesId;
  String? productsStock;

  factory ProductChoiceStock.fromJson(Map<String, dynamic> json) =>
      ProductChoiceStock(
        productsBranchesId: json["products_branches_id"] == null
            ? null
            : json["products_branches_id"],
        productsId: json["products_id"] == null ? null : json["products_id"],
        productsChoicesId: json["products_choices_id"] == null
            ? null
            : json["products_choices_id"],
        branchesId: json["branches_id"] == null ? null : json["branches_id"],
        productsStock:
            json["products_stock"] == null ? null : json["products_stock"],
      );

  Map<String, dynamic> toJson() => {
        "products_branches_id":
            productsBranchesId == null ? null : productsBranchesId,
        "products_id": productsId == null ? null : productsId,
        "products_choices_id":
            productsChoicesId == null ? null : productsChoicesId,
        "branches_id": branchesId == null ? null : branchesId,
        "products_stock": productsStock == null ? null : productsStock,
      };
}

class ChoiceTran {
  ChoiceTran({
    this.choicesTransId,
    this.choicesId,
    this.locale,
    this.choicesTitle,
  });

  int? choicesTransId;
  String? choicesId;
  String? locale;
  String? choicesTitle;

  factory ChoiceTran.fromJson(Map<String, dynamic> json) => ChoiceTran(
        choicesTransId:
            json["choices_trans_id"] == null ? null : json["choices_trans_id"],
        choicesId: json["choices_id"] == null ? null : json["choices_id"],
        locale: json["locale"] == null ? null : json["locale"],
        choicesTitle:
            json["choices_title"] == null ? null : json["choices_title"],
      );

  Map<String, dynamic> toJson() => {
        "choices_trans_id": choicesTransId == null ? null : choicesTransId,
        "choices_id": choicesId == null ? null : choicesId,
        "locale": locale == null ? null : locale!,
        "choices_title": choicesTitle == null ? null : choicesTitle,
      };
}
