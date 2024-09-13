import 'dart:convert';

JobOfferDetailsModel jobOfferDetailsModelFromJson(String str) =>
    JobOfferDetailsModel.fromJson(json.decode(str));

class JobOfferDetailsModel {
  final String id;
  final String user;
  final int employmentTypeIndex;
  final int locationTypeIndex;
  final String jobDescription;
  final String minimumQualifications;
  final List<String> requiredSkills;
  final bool active;
  final String createdAt;
  final String updatedAt;
  final String subcategoryName;
  final String companyName;
  final String companyCountry;
  final String companyAbout;
  final String logoName;
  final String applicationStatus;
  JobOfferDetailsModel({
    required this.id,
    required this.user,
    required this.employmentTypeIndex,
    required this.locationTypeIndex,
    required this.jobDescription,
    required this.minimumQualifications,
    required this.requiredSkills,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategoryName,
    required this.companyName,
    required this.companyCountry,
    required this.companyAbout,
    required this.logoName,
    required this.applicationStatus,
  });

  factory JobOfferDetailsModel.fromJson(Map<String, dynamic> json) {
    return JobOfferDetailsModel(
      id: json['_id'],
      user: json['user'],
      employmentTypeIndex: json['employmentTypeIndex'],
      locationTypeIndex: json['locationTypeIndex'],
      jobDescription: json['jobDescription'],
      minimumQualifications: json['minimumQualifications'],
      requiredSkills: List<String>.from(json['requiredSkills']),
      active: json['active'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      subcategoryName: json['subcategoryName'],
      companyName: json['companyName'],
      companyCountry: json['companyCountry'],
      companyAbout: json['companyAbout'],
      logoName: json['logoName'],
      applicationStatus: json['applicationStatus'],
    );
  }
}
