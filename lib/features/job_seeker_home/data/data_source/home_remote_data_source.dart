import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/get_recent_jobs_use_case.dart';
import 'package:http/http.dart' as https;

abstract class HomeRemoteDataSource {
  Future<JobCardModel> getRecentJobs(GetRecentJobsParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final https.Client client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<JobCardModel> getRecentJobs(GetRecentJobsParams params) async {
    try {
      final queryParameters = {
        'page': params.page.toString(),
      };
      final response = await https.get(
        Uri.https(url, recentJobOffer, queryParameters),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
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
