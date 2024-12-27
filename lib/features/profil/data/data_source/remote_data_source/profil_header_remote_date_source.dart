import 'dart:io';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/profil_header_use_cases/update_profil_header_use_case.dart';
import 'package:http/http.dart' as https;

abstract class ProfilHeaderRemoteDataSource {
  Future<ProfilHeaderModel> getProfilHeader();
  Future<void> editProfilHeader(UpdateProfilHeaderParams params);
}

class ProfilHeaderRemoteDataSourceImpl implements ProfilHeaderRemoteDataSource {
  final https.Client client;

  ProfilHeaderRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfilHeaderModel> getProfilHeader() async {
    try {
      final response = await https.get(
        Uri.https(url, profilHeaderUrl),
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

  @override
  Future<void> editProfilHeader(UpdateProfilHeaderParams params) async {
    try {
      final uri = Uri.https(url, profilHeaderUrl);

      final request = https.MultipartRequest("PUT", uri)
        ..headers.addAll({
          "Authorization": "Bearer ${TokenManager.token}",
        });

      if (params.firstName != null) {
        request.fields['firstName'] = params.firstName!;
      }
      if (params.lastName != null) {
        request.fields['lastName'] = params.lastName!;
      }
      if (params.deletePhoto != null) {
        request.fields['deletePhoto'] = params.deletePhoto.toString();
      }

      if (params.profileImg != null) {
        final file = File(params.profileImg!);
        request.files.add(await https.MultipartFile.fromPath(
          'profileImg',
          file.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
