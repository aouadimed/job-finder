import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/edcation_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';

class EducationRepositoryImpl implements EducationRepository {
  final NetworkInfo networkInfo;
  final EducationDataSource educationDataSource;

  EducationRepositoryImpl({
    required this.networkInfo,
    required this.educationDataSource,
  });

  @override
  Future<Either<Failure, bool>> createEducation({
    required String school,
    String? degree,
    String? fieldOfStudy,
    required String startDate,
    required String endDate,
    String? grade,
    String? activitiesAndSocieties,
    String? description,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await educationDataSource.createEducation(
        school: school,
        degree: degree,
        fieldOfStudy: fieldOfStudy,
        startDate: startDate,
        endDate: endDate,
        grade: grade,
        activitiesAndSocieties: activitiesAndSocieties,
        description: description,
      );
      return Right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }



  @override
  Future<Either<Failure, EducationModel>> getSingleEducation({
    required String id,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final educationModel = await educationDataSource.getSingleEducation(id: id);
      return Right(educationModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
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
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await educationDataSource.updateEducation(
        id: id,
        school: school,
        degree: degree,
        fieldOfStudy: fieldOfStudy,
        startDate: startDate,
        endDate: endDate,
        grade: grade,
        activitiesAndSocieties: activitiesAndSocieties,
        description: description,
      );
      return Right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteEducation({
    required String id,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await educationDataSource.deleteEducation(id: id);
      return Right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<EducationsModel>>> getUserEducations()async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final educationModels = await educationDataSource.getUserEducations();
      return Right(educationModels);
    } catch (e) {
      return Left(ServerFailure());
    }
}
}