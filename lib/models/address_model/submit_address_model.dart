class SubmitAddressModel {
  SubmitAddressModel(
      {this.accountId,
      this.addressDefault,
      this.addressGps,
      this.addressName,
      this.addressNotes,
      this.addressPhone,
      this.addressTitle});

  String? accountId;
  String? addressName;
  String? addressTitle;
  String? addressGps;

  String? addressDefault;
  String? addressPhone;
  String? addressNotes;

  factory SubmitAddressModel.fromJson(Map<String, dynamic> json) =>
      SubmitAddressModel(
          accountId: json["accountId"],
          addressPhone: json["address_phone"],
          addressTitle: json["address_title"],
          addressNotes: json["address_notes"],
          addressName: json["address_name"],
          addressDefault: json["address_default"],
          addressGps: json["address_gps"]);

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "address_phone": addressPhone,
        "address_name": addressName,
        "address_notes": addressNotes,
        "address_default": addressDefault,
        "address_gps": addressGps,
        "address_title": addressTitle,
      };
}
