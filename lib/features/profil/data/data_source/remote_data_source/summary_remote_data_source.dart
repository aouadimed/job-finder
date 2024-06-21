import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/summary_model.dart';
import 'package:http/http.dart' as https;

abstract class SummaryRemoteDataSource {
  Future<bool> createOrUpdateSummary({required String description});
  Future<SummaryModel> getSummary();
}

class SummaryRemoteDataSourceImpl implements SummaryRemoteDataSource {
  final https.Client client;
  SummaryRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> createOrUpdateSummary(
      {required String description}) async {
    try {
      Map<String, dynamic> requestBody = {"description": description};
      final response = await https.post(
          Uri.http(url, addOrUpadateSummaryBaseUrl),
          body: jsonEncode(requestBody),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          }).catchError(
        (e) => throw ServerException(),
      ); 
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

    @override
  Future<SummaryModel> getSummary() async {
    try {
      final response = await https.get(
        Uri.http(url, getSummaryBaseUrl),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return summaryModelFromJson(response.body);

      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
