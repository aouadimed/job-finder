import 'package:cv_frontend/features/profil/data/models/organization_activity_model.dart';
import 'dart:convert';
import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class OrganizationActivityDataSource {
  Future<bool> createOrganizationActivity({
    required String organization,
    required String role,
    required String startDate,
    required String endDate,
    String? description,
    required bool stillMember,
  });

  Future<List<OrganizationActivityModel>> getUserOrganizationActivities();

  Future<OrganizationActivityModel> getSingleOrganizationActivity(
      {required String id});

  Future<bool> updateOrganizationActivity({
    required String id,
    required String organization,
    required String role,
    required String startDate,
    required String endDate,
    String? description,
    required bool stillMember,
  });

  Future<bool> deleteOrganizationActivity({required String id});
}

class OrganizationActivityDataSourceImpl
    extends OrganizationActivityDataSource {
  final http.Client client;

  OrganizationActivityDataSourceImpl({required this.client});

  @override
  Future<bool> createOrganizationActivity({
    required String organization,
    required String role,
    required String startDate,
    required String endDate,
    String? description,
    required bool stillMember,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        "organization": organization,
        "role": role,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "stillMember": stillMember
      };

      final response = await client.post(
        Uri.https(url, createOrganizationActivityUrl),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) => throw ServerException());

      if (response.statusCode == 201) {
        return true;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<OrganizationActivityModel>>
      getUserOrganizationActivities() async {
    try {
      final response = await client.get(
        Uri.https(url, getAllOrganizationActivitiesUrl),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return organizationActivitiesFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OrganizationActivityModel> getSingleOrganizationActivity(
      {required String id}) async {
    try {
      final response = await client.get(
        Uri.https(url, '$getSingleOrganizationActivityUrl/$id'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return organizationActivitieFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateOrganizationActivity({
    required String id,
    required String organization,
    required String role,
    required String startDate,
    required String endDate,
    String? description,
    required bool stillMember,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        "organization": organization,
        "role": role,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "stillMember": stillMember
      };

      final response = await client.put(
        Uri.https(url, '$updateOrganizationActivityUrl/$id'),
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
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteOrganizationActivity({required String id}) async {
    try {
      final response = await client.delete(
        Uri.https(url, '$deleteOrganizationActivityUrl/$id'),
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
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
