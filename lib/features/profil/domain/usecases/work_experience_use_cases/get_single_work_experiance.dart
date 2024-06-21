import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetSingleWorkExperienceUseCase
    extends UseCase<WorkExperienceModel, GetSingleWorkExperinceParams> {
  final WorkExperienceRepository workExperienceRepository;

  const GetSingleWorkExperienceUseCase({required this.workExperienceRepository});

  @override
  Future<Either<Failure,WorkExperienceModel>> call(
      GetSingleWorkExperinceParams params) {
    return workExperienceRepository.getSingleWorkExperience(id: params.id);
  }
}

class GetSingleWorkExperinceParams extends Equatable {
  final String? id;

  const GetSingleWorkExperinceParams({required this.id});

  @override
  List<Object?> get props => [id];
}
