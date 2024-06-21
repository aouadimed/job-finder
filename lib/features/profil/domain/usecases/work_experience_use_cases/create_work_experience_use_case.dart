import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateWorkExperienceUseCase extends UseCase<bool, WorkExperienceParams> {
  final WorkExperienceRepository workExperienceRepository;

  const CreateWorkExperienceUseCase({required this.workExperienceRepository});

  @override
  Future<Either<Failure, bool>> call(WorkExperienceParams params) {
    return workExperienceRepository.createWorkExperience(
        endDate: params.endDate,
        description: params.description,
        locationType: params.locationType,
        location: params.location,
        employmentType: params.employmentType,
        jobTitle: params.jobTitle,
        companyName: params.companyName,
        startDate: params.startDate,
        ifStillWorking: params.ifStillWorking);
  }
}

class WorkExperienceParams extends Equatable {
  final String jobTitle;
  final String companyName;
  final int? employmentType;
  final String? location;
  final int? locationType;
  final String? description;
  final String startDate;
  final String? endDate;
  final bool ifStillWorking;

  const WorkExperienceParams(
      {required this.jobTitle,
      required this.companyName,
      this.employmentType,
      this.location,
      this.locationType,
      this.description,
      required this.startDate,
      this.endDate,
      required this.ifStillWorking});

  @override
  List<Object?> get props => [
        jobTitle,
        companyName,
        employmentType,
        location,
        locationType,
        description,
        startDate,
        endDate,
        ifStillWorking
      ];
}
