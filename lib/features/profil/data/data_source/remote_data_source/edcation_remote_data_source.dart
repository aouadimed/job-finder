import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:http/http.dart' as https;

abstract class EducationDataSource {
  Future<bool> createEducation({
    required String school,
    String? degree,
    String? fieldOfStudy,
    required String startDate,
    required String endDate,
    String? grade,
    String? activitiesAndSocieties,
    String? description,
  });

  Future<List<EducationsModel>> getUserEducations();

  Future<EducationModel> getSingleEducation({required String? id});

  Future<bool> updateEducation({
    required String id,
    required String school,
    String? degree,
    String? fieldOfStudy,
    required String startDate,
    required String endDate,
    String? grade,
    String? activitiesAndSocieties,
    String? description,
  });

  Future<bool> deleteEducation({required String id});
}

class EducationDataSourceImpl implements EducationDataSource {
  final https.Client client;

  EducationDataSourceImpl({required this.client});

  @override
  Future<bool> createEducation({
    required String school,
    String? degree,
    String? fieldOfStudy,
    required String startDate,
    String? endDate,
    String? grade,
    String? activitiesAndSocieties,
    String? description,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        "school": school,
        "degree": degree,
        "field_of_study": fieldOfStudy,
        "startDate": startDate,
        "endDate": endDate,
        "grade": grade,
        "activitiesAndSocieties": activitiesAndSocieties,
        "description": description,
      };
      final response = await https.post(
        Uri.https(url, createEducationUrl),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

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
  Future<List<EducationsModel>> getUserEducations() async {
    try {
      final response = await https.get(
        Uri.https(url, getAllEducationUrl),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return educationsModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<EducationModel> getSingleEducation({required String? id}) async {
    try {
      final response = await https.get(
        Uri.https(url, '$getSingleEducationUrl/$id'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return educationModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<bool> updateEducation({
    required String id,
    required String school,
    String? degree,
    String? fieldOfStudy,
    required String startDate,
    String? endDate,
    String? grade,
    String? activitiesAndSocieties,
    String? description,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        "school": school,
        "degree": degree,
        "field_of_study": fieldOfStudy,
        "startDate": startDate,
        "endDate": endDate,
        "grade": grade,
        "activitiesAndSocieties": activitiesAndSocieties,
        "description": description,
      };
      final response = await https.put(
        Uri.https(url, '$updateEducationUrl/$id'),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
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
  Future<bool> deleteEducation({required String id}) async {
    try {
      final response = await https.delete(
        Uri.https(url, '$deleteEducationUrl/$id'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
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
