class ColorsInitialValue {
  ColorsInitialValue({
    this.accountsColorsId,
    this.fkAccountsId,
    this.accountsColorsType,
    this.accountsColorsBackground1,
    this.accountsColorsBackground2,
    this.accountsColorsBackground3,
    this.accountsColorsBackground4,
    this.accountsColorsBackground5,
    this.accountsColorsBackground6,
    this.accountsColorsText1,
    this.accountsColorsText2,
    this.accountsColorsText3,
    this.accountsColorsText4,
    this.accountsColorsText5,
    this.accountsColorsText6,
    this.accountsColorsText7,
    this.accountsColorsBorder1,
    this.accountsColorsBorder2,
    this.accountsColorsShadow1,
    this.accountsColorsShadow2,
  });

  int? accountsColorsId;
  String? fkAccountsId;
  String? accountsColorsType;
  String? accountsColorsBackground1;
  String? accountsColorsBackground2;
  String? accountsColorsBackground3;
  String? accountsColorsBackground4;
  String? accountsColorsBackground5;
  String? accountsColorsBackground6;
  String? accountsColorsText1;
  String? accountsColorsText2;
  String? accountsColorsText3;
  String? accountsColorsText4;
  String? accountsColorsText5;
  String? accountsColorsText6;
  String? accountsColorsText7;
  String? accountsColorsBorder1;
  String? accountsColorsBorder2;
  String? accountsColorsShadow1;
  String? accountsColorsShadow2;

  factory ColorsInitialValue.fromJson(Map<String, dynamic> json) =>
      ColorsInitialValue(
        accountsColorsId: json["accounts_colors_id"],
        fkAccountsId: json["FK_accounts_id"],
        accountsColorsType: json["accounts_colors_type"],
        accountsColorsBackground1: json["accounts_colors_background_1"],
        accountsColorsBackground2: json["accounts_colors_background_2"],
        accountsColorsBackground3: json["accounts_colors_background_3"],
        accountsColorsBackground4: json["accounts_colors_background_4"],
        accountsColorsBackground5: json["accounts_colors_background_5"],
        accountsColorsBackground6: json["accounts_colors_background_6"],
        accountsColorsText1: json["accounts_colors_text_1"],
        accountsColorsText2: json["accounts_colors_text_2"],
        accountsColorsText3: json["accounts_colors_text_3"],
        accountsColorsText4: json["accounts_colors_text_4"],
        accountsColorsText5: json["accounts_colors_text_5"],
        accountsColorsText6: json["accounts_colors_text_6"],
        accountsColorsText7: json["accounts_colors_text_7"],
        accountsColorsBorder1: json["accounts_colors_border_1"],
        accountsColorsBorder2: json["accounts_colors_border_2"],
        accountsColorsShadow1: json["accounts_colors_shadow_1"],
        accountsColorsShadow2: json["accounts_colors_shadow_2"],
      );

  Map<String, dynamic> toJson() => {
        "accounts_colors_id": accountsColorsId,
        "FK_accounts_id": fkAccountsId,
        "accounts_colors_type": accountsColorsType,
        "accounts_colors_background_1": accountsColorsBackground1,
        "accounts_colors_background_2": accountsColorsBackground2,
        "accounts_colors_background_3": accountsColorsBackground3,
        "accounts_colors_background_4": accountsColorsBackground4,
        "accounts_colors_background_5": accountsColorsBackground5,
        "accounts_colors_background_6": accountsColorsBackground6,
        "accounts_colors_text_1": accountsColorsText1,
        "accounts_colors_text_2": accountsColorsText2,
        "accounts_colors_text_3": accountsColorsText3,
        "accounts_colors_text_4": accountsColorsText4,
        "accounts_colors_text_5": accountsColorsText5,
        "accounts_colors_text_6": accountsColorsText6,
        "accounts_colors_text_7": accountsColorsText7,
        "accounts_colors_border_1": accountsColorsBorder1,
        "accounts_colors_border_2": accountsColorsBorder2,
        "accounts_colors_shadow_1": accountsColorsShadow1,
        "accounts_colors_shadow_2": accountsColorsShadow2,
      };
}
