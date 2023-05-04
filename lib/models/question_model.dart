import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) =>
    QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
  QuestionsModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  int? status;
  String? message;
  dynamic errors;
  Data? data;

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        status: json["status"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.questions,
  });

  List<Question>? questions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        questions: json["questions"] == null
            ? null
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": questions == null
            ? null
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.questionsId,
    this.fkAccountsId,
    this.questionsPosition,
    this.questionsStatus,
    this.accessLevel,
    this.questionsCreatedAt,
    this.questionsUpdatedAt,
    this.questionsQuestion,
    this.questionsAnswer,
    this.translations,
  });

  int? questionsId;
  String? fkAccountsId;
  String? questionsPosition;
  String? questionsStatus;
  String? accessLevel;
  DateTime? questionsCreatedAt;
  DateTime? questionsUpdatedAt;
  String? questionsQuestion;
  String? questionsAnswer;
  List<Translation>? translations;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionsId: json["questions_id"],
        fkAccountsId: json["FK_accounts_id"],
        questionsPosition: json["questions_position"],
        questionsStatus: json["questions_status"],
        accessLevel: json["access_level"],
        questionsCreatedAt: json["questions_created_at"] == null
            ? null
            : DateTime.parse(json["questions_created_at"]),
        questionsUpdatedAt: json["questions_updated_at"] == null
            ? null
            : DateTime.parse(json["questions_updated_at"]),
        questionsQuestion: json["questions_question"],
        questionsAnswer: json["questions_answer"],
        translations: json["translations"] == null
            ? null
            : List<Translation>.from(
                json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions_id": questionsId,
        "FK_accounts_id": fkAccountsId,
        "questions_position": questionsPosition,
        "questions_status": questionsStatus,
        "access_level": accessLevel,
        "questions_created_at": questionsCreatedAt == null
            ? null
            : questionsCreatedAt!.toIso8601String(),
        "questions_updated_at": questionsUpdatedAt == null
            ? null
            : questionsUpdatedAt!.toIso8601String(),
        "questions_question": questionsQuestion,
        "questions_answer": questionsAnswer,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    this.questionsTransId,
    this.questionsId,
    this.locale,
    this.questionsQuestion,
    this.questionsAnswer,
  });

  int? questionsTransId;
  String? questionsId;
  String? locale;
  String? questionsQuestion;
  String? questionsAnswer;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        questionsTransId: json["questions_trans_id"],
        questionsId: json["questions_id"],
        locale: json["locale"] == null ? null : json["locale"],
        questionsQuestion: json["questions_question"],
        questionsAnswer: json["questions_answer"],
      );

  Map<String, dynamic> toJson() => {
        "questions_trans_id": questionsTransId,
        "questions_id": questionsId,
        "locale": locale,
        "questions_question": questionsQuestion,
        "questions_answer": questionsAnswer,
      };
}
