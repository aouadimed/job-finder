import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as https;

abstract class AuthRemoteDataSource {
  Future<UserModel> loginUser({
    required String email,
    required String password,
  });

  Future<UserModel> signUpUser({
    required String username,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String email,
    required String phone,
    required String gender,
    required String country,
    required String role,
    required List<int> expertise,
    required String password,
    required String address,
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

  @override
  Future<UserModel> signUpUser({
    required String username,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String email,
    required String phone,
    required String gender,
    required String country,
    required String role,
    required List<int> expertise,
    required String password,
    required String address,
  }) async {
    try {
      var uri = Uri.http(url, registerBaseUrl);

        Map<String, dynamic> requestBody = {
          "username": username,
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "dateOfBirth": dateOfBirth.toIso8601String(),
          "phone": phone,
          "gender": gender,
          "country": country,
          "address": address,
          "role": role,
          "expertise": jsonEncode(expertise),
        };

        final response = await https.post(
          uri,
          body: jsonEncode(requestBody),
          headers: {"Content-Type": "application/json"},
        ).catchError((e) => throw ServerException());
        final responseBody = response.body;
        if (response.statusCode == 201) {
          return userModelFromJson(responseBody);
        } else if (response.statusCode == 300) {
          throw UserExistException();
        } else if (response.statusCode == 320) {
          throw UserNameException();
        } else {
          throw ServerException();
        }
      
    } catch (e) {
      if (e is UserExistException) {
        throw EmailExistsFailure();
      } else if (e is UserNameException) {
        throw UsernameFailure();
      } else {
        throw ServerException();
      }
    }
  }
}
