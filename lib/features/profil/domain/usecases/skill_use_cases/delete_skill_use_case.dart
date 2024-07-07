import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/skill_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteSkillParams {
  final String id;

  DeleteSkillParams({required this.id});
}

class DeleteSkillUseCase implements UseCase<void, DeleteSkillParams> {
  final SkillRepository skillRepository;

  DeleteSkillUseCase({required this.skillRepository});

  @override
  Future<Either<Failure, void>> call(DeleteSkillParams params) async {
    return await skillRepository.deleteSkill(params);
  }
}
