import 'dart:convert';

JobCardModel jobCardModelFromJson(String str) => JobCardModel.fromJson(json.decode(str));

class JobCardModel {
    List<JobOffer>? jobOffers;
    int? totalPages;
    int? currentPage;

    JobCardModel({
        this.jobOffers,
        this.totalPages,
        this.currentPage,
    });

    factory JobCardModel.fromJson(Map<String, dynamic> json) => JobCardModel(
        jobOffers: List<JobOffer>.from(json["jobOffers"].map((x) => JobOffer.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
    );

}

class JobOffer {
    String? id;
    int? employmentTypeIndex;
    int? locationTypeIndex;
    String? subcategoryName;
    String? companyName;
    String? companyCountry;
    String? logoName;

    JobOffer({
        this.id,
        this.employmentTypeIndex,
        this.locationTypeIndex,
        this.subcategoryName,
        this.companyName,
        this.companyCountry,
        this.logoName,
    });

    factory JobOffer.fromJson(Map<String, dynamic> json) => JobOffer(
        id: json["id"],
        employmentTypeIndex: json["employmentTypeIndex"],
        locationTypeIndex: json["locationTypeIndex"],
        subcategoryName: json["subcategoryName"],
        companyName: json["companyName"],
        companyCountry:json["companyCountry"],
        logoName: json["logoName"],
    );

}

