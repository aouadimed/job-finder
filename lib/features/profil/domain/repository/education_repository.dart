import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:dartz/dartz.dart';

abstract class EducationRepository {
  Future<Either<Failure, bool>> createEducation({
    required String school,
    String? degree,
    String? fieldOfStudy,
    required String startDate,
    required String endDate,
    String? grade,
    String? activitiesAndSocieties,
    String? description,
  });

  Future<Either<Failure, List<EducationsModel>>> getUserEducations();

  Future<Either<Failure,EducationModel>> getSingleEducation({required String id});

  Future<Either<Failure, bool>> updateEducation({
    required String id,
    required String school,
    String? degree,
    String? fieldOfStudy,
    required String startDate,
    required String endDate,
    String? grade,
    String? activitiesAndSocieties,
    String? description,
  });

  Future<Either<Failure, bool>> deleteEducation({required String id});
}
