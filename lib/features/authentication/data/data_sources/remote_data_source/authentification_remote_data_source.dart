import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<UserModel> loginUser({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
      };
      final response = await http.post(
        Uri.http(url, loginBaseUrl),
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      ).catchError(
        (e) => throw ServerException(),
      );

      if (response.statusCode == 200) {
        return userModelFromJson(response.body);
      } else if (response.statusCode == 401) {
        throw WrongCredentialException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e.runtimeType == WrongCredentialException) {
        throw WrongCredentialException();
      } else {
        throw ServerException();
      }
    }
  }
}
