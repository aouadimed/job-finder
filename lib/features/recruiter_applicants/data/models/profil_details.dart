class ProfileDetails {
  ContactInfo? contactInfo;
  List<Education>? education;
  List<Languages>? languages;
  List<Projects>? projects;
  List<Skills>? skills;
  Summary? summary;
  List<WorkExperience>? workExperience;
  String? name;
  String? profileImg;

  ProfileDetails({
    this.contactInfo,
    this.education,
    this.languages,
    this.projects,
    this.skills,
    this.summary,
    this.workExperience,
    this.name,
    this.profileImg,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      contactInfo: json['contactInfo'] != null
          ? ContactInfo.fromJson(json['contactInfo'])
          : null,
      education: json['education'] != null
          ? List<Education>.from(
              json['education']!.map((e) => Education.fromJson(e)))
          : [],
      languages: json['languages'] != null
          ? List<Languages>.from(
              json['languages']!.map((e) => Languages.fromJson(e)))
          : [],
      projects: json['projects'] != null
          ? List<Projects>.from(
              json['projects']!.map((e) => Projects.fromJson(e)))
          : [],
      skills: json['skills'] != null
          ? List<Skills>.from(json['skills']!.map((e) => Skills.fromJson(e)))
          : [],
      summary:
          json['summary'] != null ? Summary.fromJson(json['summary']) : null,
      name: json["name"],
      profileImg: json["profileImg"],
      workExperience: json['workExperience'] != null
          ? List<WorkExperience>.from(
              json['workExperience']!.map((e) => WorkExperience.fromJson(e)))
          : [],
    );
  }
}

class ContactInfo {
  String? email;
  String? phone;
  String? address;

  ContactInfo({this.email, this.phone, this.address});

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}

class Education {
  String? sId;
  String? user;
  String? school;
  String? degree;
  String? fieldOfStudy;
  String? startDate;
  String? endDate;
  String? grade;
  String? activitiesAndSocieties;
  String? description;
  int? iV;

  Education({
    this.sId,
    this.user,
    this.school,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.grade,
    this.activitiesAndSocieties,
    this.description,
    this.iV,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      sId: json['_id'] as String?,
      user: json['user'] as String?,
      school: json['school'] as String?,
      degree: json['degree'] as String?,
      fieldOfStudy: json['field_of_study'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      grade: json['grade'] as String?,
      activitiesAndSocieties: json['activities_and_societies'] as String?,
      description: json['description'] as String?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'user': user,
      'school': school,
      'degree': degree,
      'field_of_study': fieldOfStudy,
      'startDate': startDate,
      'endDate': endDate,
      'grade': grade,
      'activities_and_societies': activitiesAndSocieties,
      'description': description,
      '__v': iV,
    };
  }
}

class Languages {
  String? sId;
  String? user;
  int? language;
  int? proficiencyIndex;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Languages({
    this.sId,
    this.user,
    this.language,
    this.proficiencyIndex,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Languages.fromJson(Map<String, dynamic> json) {
    return Languages(
      sId: json['_id'] as String?,
      user: json['user'] as String?,
      language: json['language'] as int?,
      proficiencyIndex: json['proficiencyIndex'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'user': user,
      'language': language,
      'proficiencyIndex': proficiencyIndex,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}

class Projects {
  String? sId;
  String? user;
  String? projectName;
  String? workExperience;
  String? startDate;
  String? endDate;
  String? description;
  String? projectUrl;
  bool? ifStillWorkingOnIt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Projects({
    this.sId,
    this.user,
    this.projectName,
    this.workExperience,
    this.startDate,
    this.endDate,
    this.description,
    this.projectUrl,
    this.ifStillWorkingOnIt,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Projects.fromJson(Map<String, dynamic> json) {
    return Projects(
      sId: json['_id'] as String?,
      user: json['user'] as String?,
      projectName: json['projectName'] as String?,
      workExperience: json['workExperience'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      description: json['description'] as String?,
      projectUrl: json['projectUrl'] as String?,
      ifStillWorkingOnIt: json['ifStillWorkingOnIt'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'user': user,
      'projectName': projectName,
      'workExperience': workExperience,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'projectUrl': projectUrl,
      'ifStillWorkingOnIt': ifStillWorkingOnIt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}

class Skills {
  String? sId;
  String? user;
  String? skill;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Skills({
    this.sId,
    this.user,
    this.skill,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
      sId: json['_id'] as String?,
      user: json['user'] as String?,
      skill: json['skill'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'user': user,
      'skill': skill,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}

class Summary {
  String? sId;
  String? description;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Summary({
    this.sId,
    this.description,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      sId: json['_id'] as String?,
      description: json['description'] as String?,
      user: json['user'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'description': description,
      'user': user,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}

class WorkExperience {
  String? sId;
  String? user;
  String? jobTitle;
  String? companyName;
  int? employmentType;
  String? location;
  int? locationType;
  String? startDate;
  String? endDate;
  String? description;
  bool? ifStillWorking;
  int? iV;

  WorkExperience({
    this.sId,
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
    this.iV,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      sId: json['_id'] as String?,
      user: json['user'] as String?,
      jobTitle: json['jobTitle'] as String?,
      companyName: json['companyName'] as String?,
      employmentType: json['employmentType'] as int?,
      location: json['location'] as String?,
      locationType: json['locationType'] as int?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      description: json['description'] as String?,
      ifStillWorking: json['ifStillWorking'] as bool?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'user': user,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'employmentType': employmentType,
      'location': location,
      'locationType': locationType,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'ifStillWorking': ifStillWorking,
      '__v': iV,
    };
  }
}
