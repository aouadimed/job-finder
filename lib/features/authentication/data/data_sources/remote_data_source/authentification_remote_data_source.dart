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
    required String profileImg,
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
    required String profileImg, // Expecting the path as a string
  }) async {
    try {
      // Create a multipart request
      var request = https.MultipartRequest(
        "POST",
        Uri.parse(url + registerBaseUrl), // Replace with your base URL
      )..files.add(await https.MultipartFile.fromPath("profileImg", profileImg))
     ..fields["username"] = username
      ..fields["email"] = email
      ..fields["password"] = password
      ..fields["firstName"] = firstName
      ..fields["lastName"] = lastName
      ..fields["dateOfBirth"] = dateOfBirth.toIso8601String()
      ..fields["phone"] = phone
      ..fields["gender"] = gender
      ..fields["country"] = country
      ..fields["role"] = role
      ..fields["expertise"] = jsonEncode(expertise);

      // Send the multipart request
      final response = await request.send();
print(response.statusCode);

      // Check the response status code
      if (response.statusCode == 201) {
        // Read the response body as a string
        final responseBody = await response.stream.bytesToString();
        // Assuming userModelFromJson is a function to convert JSON string to UserModel object
        return userModelFromJson(responseBody);
      } else if (response.statusCode == 300 ){
        throw UserExistException();
      }
     else if (response.statusCode == 100 ){
        throw UserExistException();
      }else {
        throw ServerException();
      }
    } catch (e) {
      if (e.runtimeType == UserExistException) {
        throw EmailExistsFailure();
      } else {
        throw ServerException();
      }    }
  }
}
