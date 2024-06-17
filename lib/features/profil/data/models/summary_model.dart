import 'dart:convert';

SummaryModel summaryModelFromJson(String str) {
  List<dynamic> jsonList = json.decode(str); // Parse JSON string to list
  return SummaryModel.fromJson(jsonList.first); // Parse first element in list
}
class SummaryModel {
    String? description;
    String? user;
    String? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    SummaryModel({
        this.description,
        this.user,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
        description: json["description"],
        user: json["user"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );


}
