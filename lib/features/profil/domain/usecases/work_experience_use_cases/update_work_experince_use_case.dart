import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateWorkExperianceUseCase
    extends UseCase<bool, UpdateWorkExperianceParams> {
  final WorkExperienceRepository workExperienceRepository;

  const UpdateWorkExperianceUseCase({required this.workExperienceRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateWorkExperianceParams params) {
    return workExperienceRepository.updateWorkExperiance(
        id: params.id,
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

class UpdateWorkExperianceParams extends Equatable {
  final String id;
  final String jobTitle;
  final String companyName;
  final int? employmentType;
  final String? location;
  final int? locationType;
  final String? description;
  final String startDate;
  final String? endDate;
  final bool ifStillWorking;

  const UpdateWorkExperianceParams(
      {required this.id,
      required this.jobTitle,
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
        id,
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
