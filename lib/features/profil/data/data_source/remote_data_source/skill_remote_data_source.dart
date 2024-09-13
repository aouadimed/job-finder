import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/profil/data/models/skill_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/create_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/delete_skill_use_case.dart';
import 'package:http/http.dart' as https;

abstract class SkillRemoteDataSource {
  Future<void> createSkill(CreateSkillParams params);
  Future<void> deleteSkill(DeleteSkillParams params);
  Future<List<SkillsModel>> getSkills();
}

class SkillRemoteDataSourceImpl implements SkillRemoteDataSource {
  final https.Client client;

  SkillRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createSkill(CreateSkillParams params) async {
    try {
      final response = await client.post(
        Uri.http(url, skillsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenManager.token}',
        },
        body: jsonEncode({"skill": params.name}),
      );

      if (response.statusCode != 201) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteSkill(DeleteSkillParams params) async {
    try {
      final response = await client.delete(
        Uri.http(url,'$skillsUrl/${params.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenManager.token}',
        },
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<SkillsModel>> getSkills() async {
    try {
      final response = await client.get(
        Uri.http(url, skillsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenManager.token}',
        },
      );

      if (response.statusCode == 200) {
       return skillsModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
