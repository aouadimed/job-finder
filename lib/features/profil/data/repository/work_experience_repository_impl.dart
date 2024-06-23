import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/work_experience_data_source.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';

class WorkExperienceRepositoryImpl implements WorkExperienceRepository {
  final NetworkInfo networkInfo;
  final WorkExperienceDataSource workExperienceDataSource;

  WorkExperienceRepositoryImpl({
    required this.networkInfo,
    required this.workExperienceDataSource,
  });

  @override
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
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await workExperienceDataSource.createWorkExperience(
        jobTitle: jobTitle,
        companyName: companyName,
        employmentType: employmentType,
        location: location,
        locationType: locationType,
        description: description,
        startDate: startDate,
        endDate: endDate,
        ifStillWorking: ifStillWorking,
      );
      return Right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<WorkExperiencesModel>>>
      getUserWorkExperiences() async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final workExperienceModel =
          await workExperienceDataSource.getUserWorkExperiences();
      return right(workExperienceModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WorkExperienceModel>> getSingleWorkExperience(
      {required String? id}) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final workExperienceModel =
          await workExperienceDataSource.getSingleWorkExperience(id: id);
      return right(workExperienceModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateWorkExperiance(
      {required String id,
      required String jobTitle,
      required String companyName,
      int? employmentType,
      String? location,
      int? locationType,
      String? description,
      required String startDate,
      String? endDate,
      required bool ifStillWorking}) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final status = await workExperienceDataSource.updateWorkExperience(
        id: id,
        jobTitle: jobTitle,
        companyName: companyName,
        employmentType: employmentType,
        location: location,
        locationType: locationType,
        description: description,
        startDate: startDate,
        endDate: endDate,
        ifStillWorking: ifStillWorking,
      );
      return right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteWorkExperience(
      {required String id}) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final status =
          await workExperienceDataSource.deleteWorkExperiences(id: id);
      return right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
