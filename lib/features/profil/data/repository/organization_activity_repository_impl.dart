import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/organization_activity_datasource.dart';
import 'package:cv_frontend/features/profil/data/models/organization_activity_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/organization_activity_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/organization_use_cases/organization_use_cases.dart';
import 'package:dartz/dartz.dart';

class OrganizationActivityRepositoryImpl implements OrganizationActivityRepository {
  final NetworkInfo networkInfo;
  final OrganizationActivityDataSource dataSource;

  const OrganizationActivityRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> createOrganizationActivity(
      CreateOrganizationActivityParams params) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final result = await dataSource.createOrganizationActivity(
        organization: params.organization,
        role: params.role,
        startDate: params.startDate,
        endDate: params.endDate,
        description: params.description,
        stillMember: params.stillMember,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrganizationActivityModel>>> getAllOrganizationActivities() async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final activities = await dataSource.getUserOrganizationActivities();
      return Right(activities);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrganizationActivityModel>> getSingleOrganizationActivity(String id) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final activity = await dataSource.getSingleOrganizationActivity(id: id);
      return Right(activity);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateOrganizationActivity(
      UpdateOrganizationActivityParams params) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final result = await dataSource.updateOrganizationActivity(
        id: params.id,
        organization: params.organization,
        role: params.role,
        startDate: params.startDate,
        endDate: params.endDate,
        description: params.description,
        stillMember: params.stillMember,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrganizationActivity(String id) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      await dataSource.deleteOrganizationActivity(id: id);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
}
