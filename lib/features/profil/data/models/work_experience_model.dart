import 'dart:convert';

WorkExperienceModel workExperienceModelFromJson(String str) =>
    WorkExperienceModel.fromJson(json.decode(str));

class WorkExperienceModel {
  String? user;
  String? jobTitle;
  String? companyName;
  int? employmentType;
  String? location;
  int? locationType;
  DateTime? startDate;
  DateTime? endDate;
  String? description;
  bool? ifStillWorking;
  String? id;
  int? v;

  WorkExperienceModel({
    this.user,
    this.jobTitle,
    this.companyName,
    this.employmentType,
    this.location,
    this.locationType,
    this.startDate,
    this.endDate,
    this.description,
    this.ifStillWorking,
    this.id,
    this.v,
  });

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) =>
      WorkExperienceModel(
        user: json["user"],
        jobTitle: json["jobTitle"],
        companyName: json["companyName"],
        employmentType: json["employmentType"],
        location: json["location"],
        locationType: json["locationType"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        description: json["description"],
        ifStillWorking: json["ifStillWorking"],
        id: json["_id"],
        v: json["__v"],
      );
}

List<WorkExperiencesModel> workExperiencesModelFromJson(String str) => List<WorkExperiencesModel>.from(json.decode(str).map((x) => WorkExperiencesModel.fromJson(x)));

class WorkExperiencesModel {
    String? id;
    String? jobTitle;
    String? companyName;
    String? duration;

    WorkExperiencesModel({
        this.id,
        this.jobTitle,
        this.companyName,
        this.duration,
    });

    factory WorkExperiencesModel.fromJson(Map<String, dynamic> json) => WorkExperiencesModel(
        id: json["_id"],
        jobTitle: json["jobTitle"],
        companyName: json["companyName"],
        duration: json["duration"],
    );


}