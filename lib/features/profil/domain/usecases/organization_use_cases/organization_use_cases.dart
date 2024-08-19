import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/organization_activity_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/organization_activity_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:dartz/dartz.dart';

class GetAllOrganizationActivitiesUseCase implements UseCase<List<OrganizationActivityModel>, NoParams> {
  final OrganizationActivityRepository repository;

  GetAllOrganizationActivitiesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<OrganizationActivityModel>>> call(NoParams params) async {
    return await repository.getAllOrganizationActivities();
  }
}

class CreateOrganizationActivityUseCase implements UseCase<void, CreateOrganizationActivityParams> {
  final OrganizationActivityRepository repository;

  CreateOrganizationActivityUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(CreateOrganizationActivityParams params) async {
    return await repository.createOrganizationActivity(params);
  }
}

class UpdateOrganizationActivityUseCase implements UseCase<void, UpdateOrganizationActivityParams> {
  final OrganizationActivityRepository repository;

  UpdateOrganizationActivityUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UpdateOrganizationActivityParams params) async {
    return await repository.updateOrganizationActivity(params);
  }
}

class DeleteOrganizationActivityUseCase implements UseCase<void, DeleteOrganizationActivityParams> {
  final OrganizationActivityRepository repository;

  DeleteOrganizationActivityUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteOrganizationActivityParams params) async {
    return await repository.deleteOrganizationActivity(params.id);
  }
}

class GetSingleOrganizationActivityUseCase implements UseCase<OrganizationActivityModel, GetSingleOrganizationActivityParams> {
  final OrganizationActivityRepository repository;

  GetSingleOrganizationActivityUseCase({required this.repository});

  @override
  Future<Either<Failure, OrganizationActivityModel>> call(GetSingleOrganizationActivityParams params) async {
    return await repository.getSingleOrganizationActivity(params.id);
  }
}

class CreateOrganizationActivityParams {
  final String organization;
  final String role;
  final String startDate;
  final String endDate;
  final String description;
  final bool stillMember;

  CreateOrganizationActivityParams({
    required this.organization,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.stillMember,
  });
}

class UpdateOrganizationActivityParams {
  final String id;
  final String organization;
  final String role;
  final String startDate;
  final String endDate;
  final String description;
  final bool stillMember;

  UpdateOrganizationActivityParams({
    required this.id,
    required this.organization,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.stillMember,
  });
}

class DeleteOrganizationActivityParams {
  final String id;

  DeleteOrganizationActivityParams({required this.id});
}

class GetSingleOrganizationActivityParams {
  final String id;

  GetSingleOrganizationActivityParams({required this.id});
}
