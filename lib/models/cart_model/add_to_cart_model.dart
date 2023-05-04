class AddToCartModel {
  AddToCartModel({
    this.accountId,
    this.products_id,
    this.products_choices_id,
    this.products_count,
    this.device_token,
    this.deviceType,
  });

  String? accountId;
  int? products_id;
  String? products_choices_id;
  int? products_count;
  String? device_token;
  String? deviceType;

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
        accountId: json["accountId"],
        products_id: json["products_id"],
        products_choices_id: json["products_choices_id"],
        products_count: json["products_count"],
        device_token: json["device_token"],
        deviceType: json["device_type"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "products_id": products_id,
        "products_choices_id": products_choices_id,
        "products_count": products_count,
        "device_token": device_token,
        "device_type": deviceType,
      };
}
