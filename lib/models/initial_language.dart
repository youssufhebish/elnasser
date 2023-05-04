import 'initial_povit.dart';

class InitialLang {
  InitialLang({
    this.languagesId,
    this.name,
    this.locale,
    this.dir,
    this.status,
    this.position,
    this.pivot,
  });

  int? languagesId;
  String? name;
  String? locale;
  String? dir;
  String? status;
  String? position;
  InitialPivot? pivot;

  factory InitialLang.fromJson(Map<String, dynamic> json) => InitialLang(
        languagesId: json["languages_id"],
        name: json["name"],
        locale: json["locale"],
        dir: json["dir"],
        status: json["status"],
        position: json["position"],
        pivot: InitialPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "languages_id": languagesId,
        "name": name,
        "locale": locale,
        "dir": dir,
        "status": status,
        "position": position,
        "pivot": pivot!.toJson(),
      };
}
