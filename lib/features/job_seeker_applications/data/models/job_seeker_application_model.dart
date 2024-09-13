import 'dart:convert';

JobSeekerAppliactionModel jobSeekerAppliactionModelFromJson(String str) => JobSeekerAppliactionModel.fromJson(json.decode(str));

class JobSeekerAppliactionModel {
    List<JobApplication> jobApplications;
    int totalPages;
    int currentPage;

    JobSeekerAppliactionModel({
     required   this.jobApplications,
     required   this.totalPages,
     required   this.currentPage,
    });

    factory JobSeekerAppliactionModel.fromJson(Map<String, dynamic> json) => JobSeekerAppliactionModel(
        jobApplications: List<JobApplication>.from(json["jobApplications"].map((x) => JobApplication.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
    );

}

class JobApplication {
    String id;
    String jobOfferId;
    String subcategoryName;
    String companyName;
    String applicationStatus;
    String logoName;
    DateTime createdAt;

    JobApplication({
     required   this.id,
      required  this.jobOfferId,
      required  this.subcategoryName,
      required  this.companyName,
     required   this.applicationStatus,
     required   this.logoName,
     required   this.createdAt,
    });

    factory JobApplication.fromJson(Map<String, dynamic> json) => JobApplication(
        id: json["id"],
        jobOfferId: json["jobOfferId"],
        subcategoryName: json["subcategoryName"],
        companyName: json["companyName"],
        applicationStatus: json["applicationStatus"],
        logoName: json["logoName"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

}
