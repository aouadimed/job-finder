import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/skill_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/create_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/delete_skill_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class SkillRepository {
  Future<Either<Failure, void>> createSkill(CreateSkillParams params);
  Future<Either<Failure, void>> deleteSkill(DeleteSkillParams params);
  Future<Either<Failure, List<SkillsModel>>> getSkills();
}
