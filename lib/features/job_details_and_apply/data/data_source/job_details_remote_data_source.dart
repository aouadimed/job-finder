import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:http/http.dart' as https;

abstract class JobDetailsRemoteDataSource {
  Future<JobOfferDetailsModel> getJobOffer({required String id});
}

class JobDetailsRemoteDataSourceImpl implements JobDetailsRemoteDataSource {
  final https.Client client;

  JobDetailsRemoteDataSourceImpl({required this.client});

  @override
  Future<JobOfferDetailsModel> getJobOffer({required String id}) async {
    try {
      final response = await https.get(
        Uri.http(url, "$jobOfferData/$id"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
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
}
