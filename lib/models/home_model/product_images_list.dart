class ProductImagesList {
  ProductImagesList({
    this.productsImagesId,
    this.productsId,
    this.productsImagesName,
  });

  int? productsImagesId;
  String? productsId;
  String? productsImagesName;

  factory ProductImagesList.fromJson(Map<String, dynamic> json) =>
      ProductImagesList(
        productsImagesId: json["products_images_id"],
        productsId: json["products_id"],
        productsImagesName: json["products_images_name"],
      );

  Map<String, dynamic> toJson() => {
        "products_images_id": productsImagesId,
        "products_id": productsId,
        "products_images_name": productsImagesName,
      };
}
