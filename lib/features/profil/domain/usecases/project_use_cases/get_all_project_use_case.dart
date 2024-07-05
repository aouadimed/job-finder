import 'package:cv_frontend/features/profil/domain/repository/project_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:dartz/dartz.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';

class GetAllProjectsUseCase implements UseCase<List<ProjectsModel>, NoParams> {
  final ProjectRepository repository;

  const GetAllProjectsUseCase({ required this.repository});

  @override
  Future<Either<Failure, List<ProjectsModel>>> call(NoParams params) async {
    return await repository.getAllProjects();
  }
}
