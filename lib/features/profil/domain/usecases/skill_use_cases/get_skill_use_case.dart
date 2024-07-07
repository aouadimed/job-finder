import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/skill_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/skill_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:dartz/dartz.dart';

class GetSkillsUseCase implements UseCase<List<SkillsModel>, NoParams> {
  final SkillRepository skillRepository;

  GetSkillsUseCase({required this.skillRepository});

  @override
  Future<Either<Failure, List<SkillsModel>>> call(NoParams params) async {
    return await skillRepository.getSkills();
  }
}
