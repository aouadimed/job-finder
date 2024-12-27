import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/saved_jobs/data/models/saved_jobs_model.dart';
import 'package:cv_frontend/features/saved_jobs/domain/usecases/get_saved_jobs_use_case.dart';
import 'package:http/http.dart' as https;

abstract class SavedJobsRemoteDataSource {
  Future<SavedJobsModel> getSavedJobs(GetSavedJobsParams params);
}

class SavedJobsRemoteDataSourceImpl implements SavedJobsRemoteDataSource {

    final https.Client client;

  SavedJobsRemoteDataSourceImpl({required this.client});

  @override
  Future<SavedJobsModel> getSavedJobs(GetSavedJobsParams params) async {
    try {
      final queryParameters = {
        'page': params.page.toString(),
        if (params.searchQuery != null) 'search': params.searchQuery,
      };
      final uri = Uri.https(url, savedJob, queryParameters);
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
        return savedJobsModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
  
}