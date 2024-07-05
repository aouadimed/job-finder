import 'package:dartz/dartz.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/create_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/update_project_use_case.dart';

abstract class ProjectRepository {
  Future<Either<Failure, void>> createProject(CreateProjectParams params);
  Future<Either<Failure, void>> deleteProject(String id);
  Future<Either<Failure, List<ProjectsModel>>> getAllProjects();
  Future<Either<Failure, ProjectModel>> getProjectById(String id);
  Future<Either<Failure, void>> updateProject(UpdateProjectParams params);
}
