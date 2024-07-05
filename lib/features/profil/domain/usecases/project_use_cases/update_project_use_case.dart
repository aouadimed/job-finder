import 'package:cv_frontend/features/profil/domain/repository/project_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';

class UpdateProjectUseCase implements UseCase<void, UpdateProjectParams> {
  final ProjectRepository repository;

  UpdateProjectUseCase({ required this.repository});

  @override
  Future<Either<Failure, void>> call(UpdateProjectParams params) async {
    return await repository.updateProject(params);
  }
}

class UpdateProjectParams {
  final String id;
  final String projectName;
  final String? workExperience;
  final String startDate;
  final String? endDate;
  final String? description;
  final String? projectUrl;
  final bool ifStillWorkingOnIt;

  UpdateProjectParams({
    required this.id,
    required this.projectName,
    this.workExperience,
    required this.startDate,
    this.endDate,
    this.description,
    this.projectUrl,
    required this.ifStillWorkingOnIt
  });
}
