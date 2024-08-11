// Postman Echo is service you can use to test your REST clients and make sample API calls.

// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility

// endpoints.

//

// The documentation for the endpoints as well as example responses can be found at

// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)

// To parse this JSON data, do
//
//     final savedJobsModel = savedJobsModelFromJson(jsonString);

import 'dart:convert';

SavedJobsModel savedJobsModelFromJson(String str) =>
    SavedJobsModel.fromJson(json.decode(str));

class SavedJobsModel {
  List<SavedJob>? savedJobs;
  int? totalPages;
  int? currentPage;

  SavedJobsModel({
    this.savedJobs,
    this.totalPages,
    this.currentPage,
  });

  factory SavedJobsModel.fromJson(Map<String, dynamic> json) => SavedJobsModel(
        savedJobs: List<SavedJob>.from(
            json["savedJobs"].map((x) => SavedJob.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );
}

class SavedJob {
  String? companyCountry;

  String? id;
  String? jobOfferId;
  int? employmentTypeIndex;
  int? locationTypeIndex;
  String? subcategoryName;
  String? companyName;
  String? logoName;

  SavedJob({
    this.id,
    this.jobOfferId,
    this.employmentTypeIndex,
    this.locationTypeIndex,
    this.subcategoryName,
    this.companyName,
    this.companyCountry,
    this.logoName,
  });

  factory SavedJob.fromJson(Map<String, dynamic> json) => SavedJob(
        id: json["id"],
        jobOfferId: json["jobOfferId"],
        employmentTypeIndex: json["employmentTypeIndex"],
        locationTypeIndex: json["locationTypeIndex"],
        subcategoryName: json["subcategoryName"],
        companyName: json["companyName"],
        companyCountry: json["companyCountry"],
        logoName: json["logoName"],
      );
}
