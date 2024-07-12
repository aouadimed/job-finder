import 'dart:convert';
import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:http/http.dart' as https;

abstract class ForgotPasswordRemoteDataSource {
  Future<void> checkEmail({required String email});
  Future<void> codeVerfication(
      {required String email, required String resetCode});
  Future<void> changePassword(
      {required String email, required String newPassword});
}

class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final https.Client client;

  ForgotPasswordRemoteDataSourceImpl({required this.client});

  @override
  Future<void> checkEmail({required String email}) async {
    try {
      Map<String, dynamic> requestBody = {"email": email};
      final response = await https.post(
        Uri.http(url, forgotPasswordBaseUrl),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
        },
      ).catchError(
        (e) => throw ServerException(),
      );

      if (response.statusCode == 404) {
        throw EmailException();
      } else if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      if (e is EmailException) {
        throw EmailFailure();
      } else {
        throw ServerFailure();
      }
    }
  }

  @override
  Future<void> codeVerfication(
      {required String email, required String resetCode}) async {
    try {
      Map<String, dynamic> requestBody = {
        "email": email,
        "resetCode": resetCode
      };
      final response = await https.post(
        Uri.http(url, verifyResetCodeBaseUrl),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
        },
      ).catchError(
        (e) => throw ServerException(),
      );

      if (response.statusCode == 404) {
        throw EmailException();
      } else if (response.statusCode == 403) {
        throw InvalidRestCodeException();
      } else if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      if (e is EmailException) {
        throw EmailFailure();
      } else if (e is InvalidRestCodeException) {
        throw InvalidRestCodeFailure();
      }

      {
        throw ServerFailure();
      }
    }
  }

  @override
  Future<void> changePassword(
      {required String email, required String newPassword}) async {
    try {
      Map<String, dynamic> requestBody = {
        "email": email,
        "newPassword": newPassword
      };
      final response = await https.put(
        Uri.http(url, resetPasswordBaseUrl),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
        },
      ).catchError(
        (e) => throw ServerException(),
      );

      if (response.statusCode == 404) {
        throw EmailException();
      } else if (response.statusCode == 400) {
        throw InvalidRestCodeException();
      } else if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      if (e is EmailException) {
        throw EmailFailure();
      } else if (e is InvalidRestCodeException) {
        throw InvalidRestCodeFailure();
      }
      {
        throw ServerFailure();
      }
    }
  }
}
