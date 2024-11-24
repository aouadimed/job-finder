import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/filter_job_offer_use_case.dart';
import 'package:http/http.dart' as https;

abstract class SearshPageRemoteDataSource {
  Future<JobCardModel> getFilteredJobOffer(FilterJobOfferParams params);
}

class SearshPageRemoteDataSourceImpl implements SearshPageRemoteDataSource {

    final https.Client client;

  SearshPageRemoteDataSourceImpl({required this.client});

  @override
  Future<JobCardModel> getFilteredJobOffer(FilterJobOfferParams params) async {
    try {
      final queryParameters = {
        'page': params.page.toString(),
      };

      final body = <String, dynamic>{};

      if (params.location.isNotEmpty) {
        body['location'] = params.location;
      }
      if (params.searchQuery.isNotEmpty) {
        body['search'] = params.searchQuery;
      }
      if (params.workTypeIndexes.isNotEmpty) {
        body['workTypeIndexes'] = params.workTypeIndexes;
      }
      if (params.jobLevel.isNotEmpty) {
        body['jobLevel'] = params.jobLevel;
      }
      if (params.employmentTypeIndexes.isNotEmpty) {
        body['employmentTypeIndexes'] = params.employmentTypeIndexes;
      }
      if (params.experience.isNotEmpty) {
        body['experience'] = params.experience;
      }
      if (params.education.isNotEmpty) {
        body['education'] = params.education;
      }
      if (params.jobFunctionIds.isNotEmpty) {
        body['jobFunctionIds'] = params.jobFunctionIds;
      }

      final response = await https
          .post(
        Uri.http(url, filterUri, queryParameters),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
        body: body.isNotEmpty ? jsonEncode(body) : null,
      )
          .catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return jobCardModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
