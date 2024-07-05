import 'package:cv_frontend/features/profil/domain/repository/project_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';

class DeleteProjectUseCase implements UseCase<void, DeleteProjectParams> {
  final ProjectRepository repository;

 const DeleteProjectUseCase({ required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteProjectParams params) async {
    return await repository.deleteProject(params.id);
  }
}

class DeleteProjectParams {
  final String id;

  DeleteProjectParams({required this.id});
}
