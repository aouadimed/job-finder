import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/job_seeker_applications/data/models/job_seeker_application_model.dart';
import 'package:cv_frontend/features/job_seeker_applications/domain/usecases/seeker_application_usecase.dart';
import 'package:http/http.dart' as https;

abstract class SeekerApplicationRemoteDataSource {
  Future<JobSeekerAppliactionModel> getApplication(
      GetSeekerApplcaitionsParams params);
}

class SeekerApplicationRemoteDataSourceImpl
    implements SeekerApplicationRemoteDataSource {
  final https.Client client;

  SeekerApplicationRemoteDataSourceImpl({required this.client});
  @override
  Future<JobSeekerAppliactionModel> getApplication(
      GetSeekerApplcaitionsParams params) async {
    try {
      final queryParameters = {
        'page': params.page.toString(),
        if (params.searchQuery != null) 'search': params.searchQuery,
      };
      final uri = Uri.https(url, jobApplyurl, queryParameters);
      final response = await client.get(
        uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });
      if (response.statusCode == 200) {
        return jobSeekerAppliactionModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
