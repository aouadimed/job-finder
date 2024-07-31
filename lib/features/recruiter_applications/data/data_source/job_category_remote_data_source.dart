import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_category_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_category_use_cases/get_job_category_use_case.dart';
import 'package:http/http.dart' as https;

abstract class JobCategoryRemoteDataSource {
  Future<List<JobCategoryModel>> getJobCategory(GetJobCategoryParams params);
}

class JobCategoryRemoteDataSourceImpl implements JobCategoryRemoteDataSource {
  final https.Client client;

  JobCategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<JobCategoryModel>> getJobCategory(GetJobCategoryParams params) async {
    try {
      final body = {
        if (params.searchQuery != null) 'query': params.searchQuery,
      };

      final uri = Uri.http(url, jobcategoryData);

      final response = await client
          .post(
        uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      )
          .catchError((e) {
        throw ServerException();
      });
      if (response.statusCode == 200) {
        return jobCategoryModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
