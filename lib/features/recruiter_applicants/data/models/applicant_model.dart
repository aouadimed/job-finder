import 'dart:convert';

import 'package:cv_frontend/features/recruiter_applicants/data/models/profil_details.dart';

ApplicantModel applicantModelFromJson(String str) =>
    ApplicantModel.fromJson(json.decode(str));

class ApplicantModel {
  int? totalApplicants;
  int? totalPages;
  int? currentPage;
  List<Application>? application;

  ApplicantModel({
    this.totalApplicants,
    this.totalPages,
    this.currentPage,
    this.application,
  });

  factory ApplicantModel.fromJson(Map<String, dynamic> json) => ApplicantModel(
        totalApplicants: json["totalApplicants"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        application: json["applications"] != null
            ? List<Application>.from(
                json["applications"].map((x) => Application.fromJson(x)))
            : [],
      );

  ApplicantModel copyWith({
    int? totalApplicants,
    int? totalPages,
    int? currentPage,
    List<Application>? application,
  }) {
    return ApplicantModel(
      totalApplicants: totalApplicants ?? this.totalApplicants,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      application: application ?? this.application,
    );
  }
}

class Application {
  String? id;
  User? user;
  String? job;
  bool? useProfile;
  String? cvUpload;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? motivationLetter;
  String? pdfPath;
  ProfileDetails? profileDetails;

  Application(
      {this.id,
      this.user,
      this.job,
      this.useProfile,
      this.cvUpload,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.motivationLetter,
      this.pdfPath,
      this.profileDetails});

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json["_id"],
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
      job: json["job"],
      useProfile: json["useProfile"] ?? false,
      cvUpload: json["cvUpload"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      motivationLetter: json["motivationLetter"],
      profileDetails: json["profileDetails"] != null
          ? ProfileDetails.fromJson(json["profileDetails"])
          : null,
    );
  }

  Application copyWith({
    String? id,
    User? user,
    String? job,
    bool? useProfile,
    ProfileDetails? profileDetails,
    String? cvUpload,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? motivationLetter,
    String? pdfPath,
  }) {
    return Application(
        id: id ?? this.id,
        user: user ?? this.user,
        job: job ?? this.job,
        useProfile: useProfile ?? this.useProfile,
        cvUpload: cvUpload ?? this.cvUpload,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        motivationLetter: motivationLetter ?? this.motivationLetter,
        pdfPath: pdfPath ?? this.pdfPath,
        profileDetails: profileDetails ?? this.profileDetails);
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? profileImg;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImg,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profileImg: json["profileImg"] ?? "null"  ,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profileImg": profileImg,
      };
}
