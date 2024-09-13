import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:http/http.dart' as https;

abstract class SavedJobRemoteDataSource {
  Future<bool> checkSavedJob({required String id});
  Future<bool> saveJob({required String id});
  Future<bool> deleteJob({required String id});
}

class SavedJobRemoteDataSourceImpl implements SavedJobRemoteDataSource {
  final https.Client client;

  SavedJobRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> checkSavedJob({required String id}) async {
    try {
      final response = await https.get(
        Uri.http(url, "$savedJob/$id"),
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
        return false;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> saveJob({required String id}) async {
    try {
      Map<String, dynamic> requestBody = {
        "jobOfferId": id,
      };
      final response = await https.post(
        Uri.http(url, savedJob),
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
        return false;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteJob({required String id}) async {
    try {
      final response = await https.delete(
        Uri.http(url, "$savedJob/$id"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
