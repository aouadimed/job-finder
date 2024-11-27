import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:http/http.dart' as https;

abstract class ProjectDataSource {
  Future<bool> createProject(
      {required String projectName,
      String? workExperience,
      required String startDate,
      String? endDate,
      String? description,
      String? projectUrl,
      required bool ifStillWorkingOnIt});

  Future<List<ProjectsModel>> getUserProjects();

  Future<ProjectModel> getSingleProject({required String? id});

  Future<bool> updateProject({
    required String id,
    required String projectName,
    String? workExperience,
    required String startDate,
    String? endDate,
    String? description,
    String? projectUrl,
    required bool ifStillWorkingOnIt,
  });

  Future<bool> deleteProject({required String id});
}

class ProjectDataSourceImpl extends ProjectDataSource {
  final https.Client client;

  ProjectDataSourceImpl({required this.client});

  @override
  Future<bool> createProject(
      {required String projectName,
      String? workExperience,
      required String startDate,
      String? endDate,
      String? description,
      String? projectUrl,
      required bool ifStillWorkingOnIt}) async {
    try {
      Map<String, dynamic> requestBody = {
        "projectName": projectName,
        "workExperience": workExperience,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "projectUrl": projectUrl,
        "ifStillWorkingOnIt": ifStillWorkingOnIt
      };
      final response = await https.post(
        Uri.http(url, createProjectUrl),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) => throw ServerException());
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
  Future<List<ProjectsModel>> getUserProjects() async {
    try {
      final response = await https.get(
        Uri.http(url, getAllProjectUrl),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });
      if (response.statusCode == 200) {
        return projectsModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<ProjectModel> getSingleProject({required String? id}) async {
    try {
      final response = await https.get(
        Uri.http(url, '$getSingleProjectUrl/$id'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });
      if (response.statusCode == 200) {
        return projectModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<bool> updateProject({
    required String id,
    required String projectName,
    String? workExperience,
    required String startDate,
    String? endDate,
    String? description,
    String? projectUrl,
    required bool ifStillWorkingOnIt,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        "projectName": projectName,
        "workExperience": workExperience,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "projectUrl": projectUrl,
        "ifStillWorkingOnIt": ifStillWorkingOnIt
      };
      final response = await https.put(
        Uri.http(url, '$updateProjectUrl/$id'),
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
  Future<bool> deleteProject({required String id}) async {
    try {
      final response = await https.delete(
        Uri.http(url, '$deleteProjectUrl/$id'),
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
