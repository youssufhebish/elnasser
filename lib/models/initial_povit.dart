class InitialPivot {
  InitialPivot({
    this.fkAccountsId,
    this.fkLanguagesId,
  });

  String? fkAccountsId;
  String? fkLanguagesId;

  factory InitialPivot.fromJson(Map<String, dynamic> json) => InitialPivot(
        fkAccountsId: json["FK_accounts_id"],
        fkLanguagesId: json["FK_languages_id"],
      );

  Map<String, dynamic> toJson() => {
        "FK_accounts_id": fkAccountsId,
        "FK_languages_id": fkLanguagesId,
      };
}
