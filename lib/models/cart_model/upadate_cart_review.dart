class UpdateCartModel {
  UpdateCartModel(
      {this.accountId,
      this.device_token,
      this.payments_id,
      this.notes,
      this.customer_addresses_id,
      this.shipping_methods_id});

  String? accountId;
  String? device_token;
  int? payments_id;
  // String? areas_id;
  int? shipping_methods_id;
  String? notes;
  int? customer_addresses_id;
  // String? delivery_times_id;

  factory UpdateCartModel.fromJson(Map<String, dynamic> json) =>
      UpdateCartModel(
        accountId: json["accountId"],
        device_token: json["device_token"],
        payments_id: json["payments_id"],
        // areas_id: json["areas_id"],
        shipping_methods_id: json["shipping_methods_id"],
        notes: json["notes"],
        customer_addresses_id: json["customer_addresses_id"],
        // delivery_times_id: json["delivery_times_id"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "device_token": device_token,
        "payments_id": payments_id,
        // "areas_id": areas_id,
        "shipping_methods_id": shipping_methods_id,
        "notes": notes,
        "customer_addresses_id": customer_addresses_id,
        // "delivery_times_id": delivery_times_id,
      };
}
