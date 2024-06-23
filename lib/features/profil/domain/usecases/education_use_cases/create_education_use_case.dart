import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateEducationUseCase
    extends UseCase<bool, CreateEducationUseCaseParams> {
  final EducationRepository educationRepository;

  const CreateEducationUseCase({required this.educationRepository});

  @override
  Future<Either<Failure, bool>> call(CreateEducationUseCaseParams params) {
    return educationRepository.createEducation(
        school: params.school,
        startDate: params.startDate,
        endDate: params.endDate,
        degree: params.degree,
        fieldOfStudy: params.fieldOfStudy,
        grade: params.grade,
        activitiesAndSocieties: params.activitiesAndSocieties,
        description: params.description);
  }
}

class CreateEducationUseCaseParams extends Equatable {
  final String school;
  final String? degree;
  final String? fieldOfStudy;
  final String startDate;
  final String endDate;
  final String? grade;
  final String? activitiesAndSocieties;
  final String? description;

  const CreateEducationUseCaseParams(
      {required this.school,
      this.degree,
      this.fieldOfStudy,
      required this.startDate,
      required this.endDate,
      this.grade,
      this.activitiesAndSocieties,
      this.description});

  @override
  List<Object?> get props => [
        school,
        degree,
        fieldOfStudy,
        startDate,
        endDate,
        grade,
        activitiesAndSocieties,
        description
      ];
}
