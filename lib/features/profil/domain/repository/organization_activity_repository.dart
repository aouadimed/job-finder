import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/organization_activity_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/organization_use_cases/organization_use_cases.dart';
import 'package:dartz/dartz.dart';

abstract class OrganizationActivityRepository {
  Future<Either<Failure, void>> createOrganizationActivity(
      CreateOrganizationActivityParams params);
  Future<Either<Failure, void>> updateOrganizationActivity(
      UpdateOrganizationActivityParams params);
  Future<Either<Failure, void>> deleteOrganizationActivity(String id);
  Future<Either<Failure, List<OrganizationActivityModel>>>
      getAllOrganizationActivities();

  Future<Either<Failure, OrganizationActivityModel>>
      getSingleOrganizationActivity(String id);
}
