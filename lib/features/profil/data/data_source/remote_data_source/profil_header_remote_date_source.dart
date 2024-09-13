import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:http/http.dart' as https;

abstract class ProfilHeaderRemoteDataSource {
  Future<ProfilHeaderModel> getProfilHeader();
}

class ProfilHeaderRemoteDataSourceImpl implements ProfilHeaderRemoteDataSource {
  final https.Client client;

  ProfilHeaderRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfilHeaderModel> getProfilHeader() async {
    try {
      final response = await https.get(
        Uri.http(url, profilHeaderUrl),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}"
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return profilHeaderModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
