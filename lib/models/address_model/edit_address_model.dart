class EditAddressModel {
  EditAddressModel(
      {this.accountId,
      this.addressDefault,
      this.addressGps,
      this.addressName,
      this.addressNotes,
      this.addressPhone,
      this.addressTitle,
      this.addressesId});

  String? accountId;
  String? addressName;
  String? addressTitle;
  String? addressGps;

  String? addressDefault;
  String? addressesId;
  String? addressPhone;
  String? addressNotes;

  factory EditAddressModel.fromJson(Map<String, dynamic> json) =>
      EditAddressModel(
          accountId: json["accountId"],
          addressPhone: json["address_phone"],
          addressesId: json["addresses_id"],
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
        "addresses_id": addressesId,
        "address_title": addressTitle,
      };
}
