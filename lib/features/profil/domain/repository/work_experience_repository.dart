import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:dartz/dartz.dart';

abstract class WorkExperienceRepository {
  Future<Either<Failure, bool>> createWorkExperience({
    required String jobTitle,
    required String companyName,
    int? employmentType,
    String? location,
    int? locationType,
    String? description,
    required String startDate,
    String? endDate,
    required bool ifStillWorking,
  });

  Future<Either<Failure, List<WorkExperiencesModel>>> getUserWorkExperiences();

  Future<Either<Failure, WorkExperienceModel>> getSingleWorkExperience(
      {required String? id});

  Future<Either<Failure, bool>> updateWorkExperiance({
    required String id,
    required String jobTitle,
    required String companyName,
    int? employmentType,
    String? location,
    int? locationType,
    String? description,
    required String startDate,
    String? endDate,
    required bool ifStillWorking,
  });

  Future<Either<Failure, bool>> deleteWorkExperience({required String id});
}
