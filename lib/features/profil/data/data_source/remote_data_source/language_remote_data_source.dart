import 'dart:convert';
import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/update_language_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/create_language_use_case.dart';
import 'package:http/http.dart' as https;

abstract class LanguageDataSource {
  Future<bool> createLanguage(CreateLanguageParams params);
  Future<bool> updateLanguage(UpdateLanguageParams params);
  Future<bool> deleteLanguage(String id);
  Future<LanguageModel> getSingleLanguage(String id);
  Future<List<LanguageModel>> getAllLanguages();
}

class LanguageDataSourceImpl implements LanguageDataSource {
  final https.Client client;

  LanguageDataSourceImpl({required this.client});

  @override
  Future<bool> createLanguage(CreateLanguageParams params) async {
    try {
      Map<String, dynamic> requestBody = {
        "language": params.languageIndex,
        "proficiencyIndex": params.proficiencyIndex,
      };
      final response = await https.post(
        Uri.https(url, createLanguageUrl),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<bool> updateLanguage(UpdateLanguageParams params) async {
    try {
      Map<String, dynamic> requestBody = {
        "language": params.languageIndex,
        "proficiencyIndex": params.proficiencyIndex,
      };
      final response = await https.put(
        Uri.https(url, '$updateLanguageUrl/${params.id}'),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<bool> deleteLanguage(String id) async {
    try {
      final response = await https.delete(
        Uri.https(url, '$deleteLanguageUrl/$id'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<LanguageModel> getSingleLanguage(
     String id) async {
    try {
      final response = await https.get(
        Uri.https(url, '$getSingleLanguageUrl/$id'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return languageModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<List<LanguageModel>> getAllLanguages() async {
    try {
      final response = await https.get(
        Uri.https(url, getAllLanguageUrl),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return listLanguageModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
