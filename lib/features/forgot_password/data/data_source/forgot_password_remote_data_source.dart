import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:http/http.dart' as https;

abstract class ForgotPasswordRemoteDataSource {
  Future<void> checkEmail({required String email});
}

class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final https.Client client;

  ForgotPasswordRemoteDataSourceImpl({required this.client});

  @override
  Future<void> checkEmail({required String email}) async {
    try {
      Map<String, dynamic> requestBody = {"email": email};
      final response = await https.post(Uri.http(url, forgotPasswordBaseUrl),
          body: jsonEncode(requestBody),
          headers: {
            "Content-type": "application/json",
          }).catchError(
        (e) => throw ServerException(),
      );
      if (response.statusCode != 200) {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
