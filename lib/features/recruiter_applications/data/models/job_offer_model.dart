import 'dart:convert';

import 'package:cv_frontend/features/recruiter_applications/data/models/company_model.dart';

JobOffersModel jobOffersModelFromJson(String str) => JobOffersModel.fromJson(json.decode(str));


class JobOffersModel {
    List<JobOffer>? jobOffers;
    CompanyProfileModel? company;
        int? totalPages;
    int? currentPage;

    JobOffersModel({
        this.jobOffers,
        this.company,
          this.totalPages,
            this.currentPage,
    });

    factory JobOffersModel.fromJson(Map<String, dynamic> json) => JobOffersModel(
        jobOffers: List<JobOffer>.from(json["jobOffers"].map((x) => JobOffer.fromJson(x))),
         totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        company: CompanyProfileModel.fromJson(json["company"]),
    );


}

class JobOffer {
    String? id;
    String? user;
    String? subcategoryName;
    int? employmentTypeIndex;
    int? locationTypeIndex;
    String? jobDescription;
    String? minimumQualifications;
    List<String>? requiredSkills;
    String? categoryName;
    bool? active;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    JobOffer({
        this.id,
        this.user,
        this.subcategoryName,
        this.employmentTypeIndex,
        this.locationTypeIndex,
        this.jobDescription,
        this.minimumQualifications,
        this.requiredSkills,
        this.categoryName,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory JobOffer.fromJson(Map<String, dynamic> json) => JobOffer(
        id: json["_id"],
        user: json["user"],
        subcategoryName: json["subcategoryName"],
        employmentTypeIndex: json["employmentTypeIndex"],
        locationTypeIndex: json["locationTypeIndex"],
        jobDescription: json["jobDescription"],
        minimumQualifications: json["minimumQualifications"],
        requiredSkills: List<String>.from(json["requiredSkills"].map((x) => x)),
        categoryName: json["categoryName"],
        active: json["active"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );


}
