import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateEducationUseCase extends UseCase<bool, UpdateEducationParams> {
  final EducationRepository educationRepository;

  const UpdateEducationUseCase({required this.educationRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateEducationParams params) {
    return educationRepository.updateEducation(
      id: params.id,
      school: params.school,
      degree: params.degree,
      fieldOfStudy: params.fieldOfStudy,
      startDate: params.startDate,
      endDate: params.endDate,
      grade: params.grade,
      activitiesAndSocieties: params.activitiesAndSocieties,
      description: params.description,
    );
  }
}

class UpdateEducationParams extends Equatable {
  final String id;
  final String school;
  final String? degree;
  final String? fieldOfStudy;
  final String startDate;
  final String endDate;
  final String? grade;
  final String? activitiesAndSocieties;
  final String? description;

  const UpdateEducationParams({
    required this.id,
    required this.school,
    this.degree,
    this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    this.grade,
    this.activitiesAndSocieties,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        school,
        degree,
        fieldOfStudy,
        startDate,
        endDate,
        grade,
        activitiesAndSocieties,
        description,
      ];
}
