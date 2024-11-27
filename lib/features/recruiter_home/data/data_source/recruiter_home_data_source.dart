import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_home/domain/usecases/get_recent_applicant_use_case.dart';
import 'package:http/http.dart' as https;

abstract class RecruiterHomeDataSource {
  Future<ApplicantModel> getApplciant(GetRecentApplicantParams params);
}

class RecruiterHomeDataSourceImpl implements RecruiterHomeDataSource {
  final https.Client client;

  RecruiterHomeDataSourceImpl({required this.client});

  @override
  Future<ApplicantModel> getApplciant(GetRecentApplicantParams params) async {
    try {
      final queryParameters = {
        'page': params.page.toString(),
        if (params.searshQuery.isNotEmpty) 'search': params.searshQuery,
      };
      final response = await https.get(
        Uri.http(url, getRecentApplicantUri, queryParameters),
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
}
