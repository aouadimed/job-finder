import 'dart:convert';

import 'package:intl/intl.dart';

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
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        description: json["description"],
        ifStillWorking: json["ifStillWorking"],
        id: json["_id"],
        v: json["__v"],
      );
}

List<WorkExperiencesModel> workExperiencesModelFromJson(String str) =>
    List<WorkExperiencesModel>.from(
        json.decode(str).map((x) => WorkExperiencesModel.fromJson(x)));

// WorkExperienceModel class
class WorkExperiencesModel {
  String? id;
  String? jobTitle;
  String? companyName;
  DateTime? startDate;
  DateTime? endDate;
  bool? ifStillWorking;

  WorkExperiencesModel({
    this.id,
    this.jobTitle,
    this.companyName,
    this.startDate,
    this.endDate,
    this.ifStillWorking,
  });

  factory WorkExperiencesModel.fromJson(Map<String, dynamic> json) =>
      WorkExperiencesModel(
        id: json["_id"],
        jobTitle: json["jobTitle"],
        companyName: json["companyName"],
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : null,
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        ifStillWorking: json["ifStillWorking"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "jobTitle": jobTitle,
        "companyName": companyName,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "ifStillWorking": ifStillWorking,
      };

 String getDuration() {
    final DateTime end = ifStillWorking == true ? DateTime.now() : endDate!;
    int durationYears = end.year - startDate!.year;
    int durationMonths = end.month - startDate!.month;

    // Adjust months and years if the end month is before the start month within the same year
    if (durationMonths < 0) {
      durationYears -= 1;
      durationMonths += 12;
    }

    final String yearsText = durationYears > 0
        ? '$durationYears year${durationYears > 1 ? 's' : ''} '
        : '';
    final String monthsText = durationMonths > 0
        ? '$durationMonths month${durationMonths > 1 ? 's' : ''}'
        : '';

    final String duration = '$yearsText$monthsText'.trim();

    final DateFormat formatter = DateFormat('MMMM yyyy');
    final String startDateFormatted = formatter.format(startDate!);
    final String endDateFormatted =
        ifStillWorking == true ? 'Present' : formatter.format(end);

    return '$startDateFormatted - $endDateFormatted ($duration)';
  }
}
