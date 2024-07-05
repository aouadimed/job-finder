import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/project_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/project_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/create_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/update_project_use_case.dart';
import 'package:dartz/dartz.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final NetworkInfo networkInfo;

  final ProjectDataSource dataSource;

  const ProjectRepositoryImpl(
      {required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, bool>> createProject(
      CreateProjectParams params) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final result = await dataSource.createProject(
        projectName: params.projectName,
        workExperience: params.workExperience,
        startDate: params.startDate,
        endDate: params.endDate,
        description: params.description,
        projectUrl: params.projectUrl,
        ifStillWorkingOnIt: params.ifStillWorkingOnIt,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProjectsModel>>> getAllProjects() async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final projects = await dataSource.getUserProjects();
      return Right(projects);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProjectModel>> getProjectById(String id) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final project = await dataSource.getSingleProject(id: id);
      return Right(project);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateProject(
      UpdateProjectParams params) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final result = await dataSource.updateProject(
        id: params.id,
        projectName: params.projectName,
        workExperience: params.workExperience,
        startDate: params.startDate,
        endDate: params.endDate,
        description: params.description,
        projectUrl: params.projectUrl,
        ifStillWorkingOnIt: params.ifStillWorkingOnIt,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final result = await dataSource.deleteProject(id: id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
