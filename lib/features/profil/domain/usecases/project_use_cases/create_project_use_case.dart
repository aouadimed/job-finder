import 'package:cv_frontend/features/profil/domain/repository/project_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';

class CreateProjectUseCase implements UseCase<void, CreateProjectParams> {
  final ProjectRepository repository;

  CreateProjectUseCase({ required this.repository});

  @override
  Future<Either<Failure, void>> call(CreateProjectParams params) async {
    return await repository.createProject(params);
  }
}

class CreateProjectParams {
  final String projectName;
  final String? workExperience;
  final String startDate;
  final String? endDate;
  final String? description;
  final String? projectUrl;
  final bool ifStillWorkingOnIt;

  CreateProjectParams({
    required this.projectName,
    this.workExperience,
    required this.startDate,
    this.endDate,
    this.description,
    this.projectUrl,
    required this.ifStillWorkingOnIt
  });
}
