import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:http/http.dart' as https;

abstract class WorkExperienceDataSource {
  Future<bool> createWorkExperience({
    required String jobTitle,
    required String companyName,
    int? employmentType,
    String? location,
    int? locationType,
    String? description,
    required String startDate,
    String? endDate,
    required bool ifStillWorking,
  });

  Future<List<WorkExperiencesModel>> getUserWorkExperiences();

  Future<WorkExperienceModel> getSingleWorkExperience({required String? id});

  Future<bool> updateWorkExperience({
    required String id,
    required String jobTitle,
    required String companyName,
    int? employmentType,
    String? location,
    int? locationType,
    String? description,
    required String startDate,
    String? endDate,
    required bool ifStillWorking,
  });

  Future<bool> deleteWorkExperiences({required String id});
}

class WorkExperienceDataSourceImpl extends WorkExperienceDataSource {
  final https.Client client;

  WorkExperienceDataSourceImpl({required this.client});

  @override
  Future<bool> createWorkExperience(
      {required String jobTitle,
      required String companyName,
      int? employmentType,
      String? location,
      int? locationType,
      String? description,
      required String startDate,
      String? endDate,
      required bool ifStillWorking}) async {
    try {
      Map<String, dynamic> requestBody = {
        "jobTitle": jobTitle,
        "companyName": companyName,
        "employmentType": employmentType,
        "location": location,
        "locationType": locationType,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "ifStillWorking": ifStillWorking,
      };
      final response = await https.post(Uri.https(url, createWorkExperienceUrl),
          body: jsonEncode(requestBody),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer ${TokenManager.token}"
          }).catchError(
        (e) => throw ServerException(),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<List<WorkExperiencesModel>> getUserWorkExperiences() async {
    try {
      final response = await https.get(
        Uri.https(url, getAllWorkExperienceUrl),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });
      if (response.statusCode == 200) {
        return workExperiencesModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<WorkExperienceModel> getSingleWorkExperience(
      {required String? id}) async {
    try {
      final response = await https.get(
        Uri.https(url, '$getSingleWorkExperienceUrl/$id'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return workExperienceModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<bool> updateWorkExperience(
      {required String id,
      required String jobTitle,
      required String companyName,
      int? employmentType,
      String? location,
      int? locationType,
      String? description,
      required String startDate,
      String? endDate,
      required bool ifStillWorking}) async {
    try {
      Map<String, dynamic> requestBody = {
        "jobTitle": jobTitle,
        "companyName": companyName,
        "employmentType": employmentType,
        "location": location,
        "locationType": locationType,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "ifStillWorking": ifStillWorking,
      };
      final response = await https.put(
        Uri.https(url, '$updateWorkExperienceUrl/$id'),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<bool> deleteWorkExperiences({required String id}) async {
    try {
      final response = await https.delete(
        Uri.https(url, '$deleteWorkExperienceUrl/$id'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
