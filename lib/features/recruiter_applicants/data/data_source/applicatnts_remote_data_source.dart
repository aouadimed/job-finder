import 'dart:convert';
import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/get_applicant_list_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/send_msg_applicant_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/update_applicant_status_use_case.dart';
import 'package:http/http.dart' as https;

abstract class ApplicantRemoteDataSource {
  Future<ApplicantModel> getApplicants(GetApplicantsListParams params);
  Future<void> updateStatus(UpdateApplicantParams params);
  Future<void> sendMessageToApplicant(SendMessageToApplicantParams params);
}

class ApplicantRemoteDataSourceImpl implements ApplicantRemoteDataSource {
  final https.Client client;

  ApplicantRemoteDataSourceImpl({required this.client});

  @override
  Future<ApplicantModel> getApplicants(GetApplicantsListParams params) async {
    try {
      final queryParameters = {
        'page': params.page.toString(),
      };
      final response = await https.get(
        Uri.http(url, "$jobApplyurl/${params.id}", queryParameters),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return applicantModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateStatus(UpdateApplicantParams params) async {
    try {
      Map<String, dynamic> requestBody = {
        "status": params.status,
      };
      final response = await https.patch(
        Uri.http(url, "$jobApplyurl/${params.id}"),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> sendMessageToApplicant(
      SendMessageToApplicantParams params) async {
    try {
      final response = await https.post(
        Uri.http(url, "$jobApplyurl/${params.id}"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
