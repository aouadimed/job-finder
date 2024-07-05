import 'dart:convert';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

class ProjectModel {
  String? user;
  String? projectName;
  String? workExperience;
  DateTime? startDate;
  DateTime? endDate;
  String? description;
  String? projectUrl;
  bool? ifStillWorkingOnIt;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProjectModel({
    this.user,
    this.projectName,
    this.workExperience,
    this.startDate,
    this.endDate,
    this.description,
    this.projectUrl,
    this.ifStillWorkingOnIt,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        user: json["user"],
        projectName: json["projectName"],
        workExperience: json["workExperience"]?["_id"],
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : null,
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        description: json["description"],
        projectUrl: json["projectUrl"],
        ifStillWorkingOnIt: json["ifStillWorkingOnIt"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

List<ProjectsModel> projectsModelFromJson(String str) =>
    List<ProjectsModel>.from(
        json.decode(str).map((x) => ProjectsModel.fromJson(x)));

class ProjectsModel {
  String? id;
  String? projectName;
  WorkExperience? workExperience;
  DateTime? startDate;
  DateTime? endDate;
  bool? ifStillWorkingOnIt;

  ProjectsModel({
    this.id,
    this.projectName,
    this.workExperience,
    this.startDate,
    this.endDate,
    this.ifStillWorkingOnIt,
  });

  factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
        id: json["_id"],
        projectName: json["projectName"],
        workExperience: json["workExperience"] != null ? WorkExperience.fromJson(json["workExperience"]) : null,
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : null,
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        ifStillWorkingOnIt: json["ifStillWorkingOnIt"],
      );
      
}

class WorkExperience {
  String? id;
  String? jobTitle;
  String? companyName;

  WorkExperience({
    this.id,
    this.jobTitle,
    this.companyName,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) => WorkExperience(
        id: json["_id"],
        jobTitle: json["jobTitle"],
        companyName: json["companyName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "jobTitle": jobTitle,
        "companyName": companyName,
      };
}
