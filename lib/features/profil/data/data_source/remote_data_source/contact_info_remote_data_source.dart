import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/contact_info_use_cases/update_contact_info_use_case.dart';
import 'package:http/http.dart' as https;

abstract class ContactInfoRemoteDataSource {
  Future<ContactInfoModel> getContactInfo();
  Future<void> updateContactInfo(UpdateContactInfoParams params);
}

class ContactInfoRemoteDataSourceImpl implements ContactInfoRemoteDataSource {
  final https.Client client;

  ContactInfoRemoteDataSourceImpl({required this.client});

  @override
  Future<ContactInfoModel> getContactInfo() async {
    try {
      final response = await https.get(
        Uri.http(url, contactInfoUrl),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return contactInfoModelFromJson(response.body);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<void> updateContactInfo(UpdateContactInfoParams params) async {
    try {
      Map<String, dynamic> requestBody = {
        "email": params.email,
        "phone": params.phone,
        "address": params.address,
      };
      await https.put(
        Uri.http(url, contactInfoUrl),
        body: jsonEncode(requestBody),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).catchError((e) {
        throw ServerException();
      });
    } catch (e) {
      throw ServerFailure();
    }
  }
}
