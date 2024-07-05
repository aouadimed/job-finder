import 'dart:convert';

LanguageModel languageModelFromJson(String str) => LanguageModel.fromJson(json.decode(str));

List<LanguageModel> listLanguageModelFromJson(String str) => List<LanguageModel>.from(json.decode(str).map((x) => LanguageModel.fromJson(x)));

class LanguageModel {
    String? user;
    int? language;
    int? proficiencyIndex;
    String? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    LanguageModel({
        this.user,
        this.language,
        this.proficiencyIndex,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        user: json["user"],
        language: json["language"],
        proficiencyIndex: json["proficiencyIndex"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );


}