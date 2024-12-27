import 'dart:convert';
import 'dart:io';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/recruiter_profil/data/model/company_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

abstract class CompanyRemoteDataSource {
  Future<void> createOrUpdateCompanyProfile(CompanyProfileModel profile);
  Future<CompanyProfileModel> getCompany();
}

class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  final http.Client client;

  CompanyRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createOrUpdateCompanyProfile(CompanyProfileModel profile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.https(url, companyData),
      );

      request.fields['companyName'] = profile.companyName ?? '';
      request.fields['aboutCompany'] = profile.aboutCompany ?? '';
      request.fields['website'] = profile.website ?? '';
      request.fields['country'] = profile.country ?? '';
      request.fields['addresses'] = json.encode(profile.addresses);

      if (profile.logoName != null && profile.logoName!.isNotEmpty) {
        File logoFile = File(profile.logoName!);
        request.files.add(
          await http.MultipartFile.fromPath('logo', logoFile.path,
              filename: path.basename(logoFile.path)),
        );
      }
      request.headers['Authorization'] = 'Bearer ${TokenManager.token}';
      var response = await request.send();
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<CompanyProfileModel> getCompany() async {
    try {
      final response = await http.get(
        Uri.https(url, companyData),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          return CompanyProfileModel.fromJson(jsonList[0]);
        } else {
          throw ServerException();
        }
      } else if (response.statusCode == 201) {
        throw CompanyDataEmptyException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is CompanyDataEmptyException) {
        throw CompanyDataEmptyException();
      } else {
        throw ServerException();
      }
    }
  }
}
