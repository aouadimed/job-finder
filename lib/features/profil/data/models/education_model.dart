import 'dart:convert';

EducationModel educationModelFromJson(String str) => EducationModel.fromJson(json.decode(str));


class EducationModel {
    String? user;
    String? school;
    String? degree;
    String? fieldOfStudy;
    DateTime? startDate;
    DateTime? endDate;
    String? grade;
    String? activitiesAndSocieties;
    String? description;
    String? id;
    int? v;

    EducationModel({
        this.user,
        this.school,
        this.degree,
        this.fieldOfStudy,
        this.startDate,
        this.endDate,
        this.grade,
        this.activitiesAndSocieties,
        this.description,
        this.id,
        this.v,
    });

    factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
        user: json["user"],
        school: json["school"],
        degree: json["degree"],
        fieldOfStudy: json["field_of_study"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        grade: json["grade"],
        activitiesAndSocieties: json["activities_and_societies"],
        description: json["description"],
        id: json["_id"],
        v: json["__v"],
    );


}


List<EducationsModel> educationsModelFromJson(String str) => List<EducationsModel>.from(json.decode(str).map((x) => EducationsModel.fromJson(x)));

class EducationsModel {
    String? id;
    String? school;
    String? fieldOfStudy;
    DateTime? startDate;
    DateTime? endDate;

    EducationsModel({
        this.id,
        this.school,
        this.fieldOfStudy,
        this.startDate,
        this.endDate,
    });

    factory EducationsModel.fromJson(Map<String, dynamic> json) => EducationsModel(
        id: json["_id"],
        school: json["school"],
        fieldOfStudy: json["field_of_study"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "field_of_study": fieldOfStudy,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
    };

        String getDuration() {
        if (startDate != null && endDate != null) {
            final duration = endDate!.difference(startDate!);
            final years = duration.inDays ~/ 365;
            final months = (duration.inDays % 365) ~/ 30;
            return '$years year${years != 1 ? 's' : ''} ${months} month${months != 1 ? 's' : ''}';
        } else if (startDate != null && endDate == null) {
            final now = DateTime.now();
            final duration = now.difference(startDate!);
            final years = duration.inDays ~/ 365;
            final months = (duration.inDays % 365) ~/ 30;
            return '$years year${years != 1 ? 's' : ''} ${months} month${months != 1 ? 's' : ''}';
        } else {
            return 'Unknown duration';
        }
    }
}