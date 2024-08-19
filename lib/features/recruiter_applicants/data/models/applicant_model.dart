import 'dart:convert';

ApplicantModel applicantModelFromJson(String str) => ApplicantModel.fromJson(json.decode(str));


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
        application: List<Application>.from(json["application"].map((x) => Application.fromJson(x))),
    );

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

    Application({
        this.id,
        this.user,
        this.job,
        this.useProfile,
        this.cvUpload,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.motivationLetter,
    });

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        job: json["job"],
        useProfile: json["useProfile"],
        cvUpload: json["cvUpload"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        motivationLetter: (json["motivationLetter"] != null) ? json["motivationLetter"]: null,
    );

  
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
        profileImg: json["profileImg"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profileImg": profileImg,
    };
}
