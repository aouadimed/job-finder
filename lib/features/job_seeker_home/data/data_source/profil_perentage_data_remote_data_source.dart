import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/profil_percentage_model.dart';
import 'package:http/http.dart' as https;

abstract class ProfilPercentageRemoteDataSource {
  Future<CompletionPercentage> getPercentage();
}

class ProfilPercentageRemoteDataSourceImpl
    implements ProfilPercentageRemoteDataSource {
  final https.Client client;

  ProfilPercentageRemoteDataSourceImpl({required this.client});

  @override
  Future<CompletionPercentage> getPercentage() async {
    try {
      final response = await https.get(
        Uri.https(url, profilPercentage),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return completionPercentageFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}

