import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as https;

abstract class AuthRemoteDataSource {
  Future<UserModel> loginUser({
    required String email,
    required String password,
  });

  Future<Unit> signUpUser({
    required String username,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final https.Client client;

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
      final response = await https.post(
        Uri.https(url, loginBaseUrl),
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

  @override
  Future<Unit> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        "username": username,
        "email": email,
        "password": password,
      };
      final response = await https.post(
        Uri.https(url, registerBaseUrl),
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      ).catchError(
        (e) => throw ServerException(),
      );

      if (response.statusCode == 201) {
        return unit;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
