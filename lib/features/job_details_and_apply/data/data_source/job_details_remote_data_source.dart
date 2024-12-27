import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/delete_job_offer_use_case.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/edit_job_offer_use_case.dart';
import 'package:http/http.dart' as https;

abstract class JobDetailsRemoteDataSource {
  Future<JobOfferDetailsModel> getJobOffer({required String id});
  Future<void> editJobOffer(EditJobOfferParams params);
  Future<void> deleteJobOffer(DeleteJobOfferParams params);
}

class JobDetailsRemoteDataSourceImpl implements JobDetailsRemoteDataSource {
  final https.Client client;

  JobDetailsRemoteDataSourceImpl({required this.client});

  @override
  Future<JobOfferDetailsModel> getJobOffer({required String id}) async {
    try {
      final response = await https.get(
        Uri.https(url, "$jobOfferData/$id"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return jobOfferDetailsModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> editJobOffer(EditJobOfferParams params) async {
    try {
      final body = jsonEncode({
        'subcategoryId': params.categoryIndex,
        'employmentTypeIndex': params.employmentTypeIndex,
        'locationTypeIndex': params.locationTypeIndex,
        'jobDescription': params.jobDescription,
        'minimumQualifications': params.minimumQualifications,
        'requiredSkills': params.requiredSkills,
        'categoryId': params.subcategoryIndex,
      });
      final response = await client.put(
        Uri.https(url, '$jobOfferData/${params.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenManager.token}',
        },
        body: body,
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteJobOffer(DeleteJobOfferParams params) async {
    try {
      final response = await client.delete(
        Uri.https(url, '$jobOfferData/${params.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenManager.token}',
        },
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
