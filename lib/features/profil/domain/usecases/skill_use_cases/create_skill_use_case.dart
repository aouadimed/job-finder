import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/skill_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateSkillUseCase implements UseCase<void, CreateSkillParams> {
  final SkillRepository skillRepository;

  CreateSkillUseCase({required this.skillRepository});

  @override
  Future<Either<Failure, void>> call(CreateSkillParams skill) async {
    return await skillRepository.createSkill(skill);
  }
}



class CreateSkillParams extends Equatable {
  final String name;

 const CreateSkillParams({required this.name});

  @override
  List<Object?> get props => [name];
}

