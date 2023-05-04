class AddCouponModel {
  AddCouponModel({
    this.accountId,
    this.coupons_code,
    this.device_token,
  });

  String? accountId;
  String? coupons_code;
  String? device_token;

  factory AddCouponModel.fromJson(Map<String, dynamic> json) => AddCouponModel(
        accountId: json["accountId"],
        coupons_code: json["coupons_code"],
        device_token: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "coupons_code": coupons_code,
        "device_token": device_token,
      };
}
