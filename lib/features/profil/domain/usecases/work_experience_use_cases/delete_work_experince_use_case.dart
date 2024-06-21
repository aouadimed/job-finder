import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteWorkExperienceUseCase
    extends UseCase<bool, DeleteWorkExperienceParams> {
  final WorkExperienceRepository workExperienceRepository;

  DeleteWorkExperienceUseCase({required this.workExperienceRepository});
  @override
  Future<Either<Failure, bool>> call(DeleteWorkExperienceParams params) {
    return workExperienceRepository.deleteWorkExperience(id: params.id);
  }
}

class DeleteWorkExperienceParams extends Equatable {
  final String id;

  const DeleteWorkExperienceParams({required this.id});

  @override
  List<Object?> get props => [id];
}
