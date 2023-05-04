class InitialTranslation {
  InitialTranslation({
    this.accountsTransId,
    this.accountsId,
    this.locale,
    this.productsTitle,
  });

  int? accountsTransId;
  String? accountsId;
  String? locale;
  String? productsTitle;

  factory InitialTranslation.fromJson(Map<String, dynamic> json) =>
      InitialTranslation(
        accountsTransId: json["accounts_trans_id"],
        accountsId: json["accounts_id"],
        locale: json["locale"],
        productsTitle: json["products_title"],
      );

  Map<String, dynamic> toJson() => {
        "accounts_trans_id": accountsTransId,
        "accounts_id": accountsId,
        "locale": locale,
        "products_title": productsTitle,
      };
}
