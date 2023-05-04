import 'home_model/atributes.dart';
import 'home_model/offers.dart';
import 'home_model/product_class.dart';

class CartItemsModel {
  CartItemsModel({
    this.cartsItemsId,
    this.fkCartsId,
    this.fkProductsId,
    this.fkOffersId,
    this.fkProductsChoicesId,
    this.cartsItemsPrice,
    this.cartsItemsPriceBeforeSale,
    this.cartsItemsCount,
    this.cartsItemsTotal,
    this.product,
    this.offer,
    this.choice,
    this.productOffer,
  });

  int? cartsItemsId;
  String? fkCartsId;
  String? fkProductsId;
  String? fkOffersId;
  String? fkProductsChoicesId;
  String? cartsItemsPrice;
  String? cartsItemsPriceBeforeSale;
  String? cartsItemsCount;
  String? cartsItemsTotal;
  ProductClass? product;
  Offer? offer;
  Offer? productOffer;
  AttributeProductsChoice? choice;

  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
        cartsItemsId:
            json["carts_items_id"] == null ? null : json["carts_items_id"],
        fkCartsId: json["FK_carts_id"] == null ? null : json["FK_carts_id"],
        fkProductsId:
            json["FK_products_id"] == null ? null : json["FK_products_id"],
        fkOffersId: json["FK_offers_id"] == null ? null : json["FK_offers_id"],
        fkProductsChoicesId: json["FK_products_choices_id"] == null
            ? null
            : json["FK_products_choices_id"],
        cartsItemsPrice: json["carts_items_price"] == null
            ? null
            : json["carts_items_price"],
        cartsItemsPriceBeforeSale: json["carts_items_price_before_sale"] == null
            ? null
            : json["carts_items_price_before_sale"],
        cartsItemsCount: json["carts_items_count"] == null
            ? null
            : json["carts_items_count"],
        cartsItemsTotal: json["carts_items_total"] == null
            ? null
            : json["carts_items_total"],
        product: json["product"] == null
            ? null
            : ProductClass.fromJson(json["product"]),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        productOffer: json["product_offer"] == null
            ? null
            : Offer.fromJson(json["product_offer"]),
        choice: json["choice"] == null
            ? null
            : AttributeProductsChoice.fromJson(json["choice"]),
      );

  Map<String, dynamic> toJson() => {
        "carts_items_id": cartsItemsId == null ? null : cartsItemsId,
        "FK_carts_id": fkCartsId == null ? null : fkCartsId,
        "FK_products_id": fkProductsId == null ? null : fkProductsId,
        "FK_offers_id": fkOffersId == null ? null : fkOffersId,
        "FK_products_choices_id":
            fkProductsChoicesId == null ? null : fkProductsChoicesId,
        "carts_items_price": cartsItemsPrice == null ? null : cartsItemsPrice,
        "carts_items_price_before_sale": cartsItemsPriceBeforeSale == null
            ? null
            : cartsItemsPriceBeforeSale,
        "carts_items_count": cartsItemsCount == null ? null : cartsItemsCount,
        "carts_items_total": cartsItemsTotal == null ? null : cartsItemsTotal,
        "product": product == null ? null : product!.toJson(),
        "offer": offer == null ? null : offer!.toJson(),
        "product_offer": productOffer == null ? null : productOffer!.toJson(),
        "choice": choice == null ? null : choice!.toJson(),
      };
}
