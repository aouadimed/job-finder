import 'package:cv_frontend/features/profil/domain/repository/project_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';

class GetSingleProjectUseCase implements UseCase<ProjectModel, GetSingleProjectParams> {
  final ProjectRepository repository;

  GetSingleProjectUseCase({ required this.repository});

  @override
  Future<Either<Failure, ProjectModel>> call(GetSingleProjectParams params) async {
    return await repository.getProjectById(params.id);
  }
}

class GetSingleProjectParams {
  final String id;

  GetSingleProjectParams({required this.id});
}
