import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_offer_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/add_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/get_list_job_offer_use_cases.dart';
import 'package:http/http.dart' as https;

abstract class JobOfferRemoteDataSource {
  Future<void> addJobOffer(AddJobOfferParams params);
  Future<JobOffersModel> getJobOfferList(PageParams pageParams);
}

class JobOfferRemoteDataSourceImpl implements JobOfferRemoteDataSource {
  final https.Client client;

  JobOfferRemoteDataSourceImpl({required this.client});
  @override
  Future<void> addJobOffer(AddJobOfferParams params) async {
    try {
      final body = jsonEncode({
        'subcategoryId': params.subcategoryIndex,
        'employmentTypeIndex': params.employmentTypeIndex,
        'locationTypeIndex': params.locationTypeIndex,
        'jobDescription': params.jobDescription,
        'minimumQualifications': params.minimumQualifications,
        'requiredSkills': params.requiredSkills,
        'categoryId': params.categoryIndex,
      });
      final response = await client.post(
        Uri.http(url, jobOfferData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode != 201) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }


  @override
  Future<JobOffersModel> getJobOfferList(PageParams pageParams) async {
    try {
      final queryParameters = {
        'page': pageParams.page.toString(),
        'limit': '10', 
        if (pageParams.searchQuery != null) 'search': pageParams.searchQuery,
        if (pageParams.filterIndex != null) 'filter': pageParams.filterIndex.toString(),
      };

      print('Requesting job offers with parameters: $queryParameters');

      final uri = Uri.http(url, jobOfferData, queryParameters);
      print('Request URL: $uri');

      final response = await client.get(
        uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).catchError((e) {
        print('Error during HTTP request: $e');
        throw ServerException();
      });

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return jobOffersModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('Error caught: $e');
      throw ServerException();
    }
  }

}