import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:dartz/dartz.dart';

class GetAllWorkExperiencesUseCase
    extends UseCase<List<WorkExperiencesModel>, NoParams> {
  final WorkExperienceRepository workExperienceRepository;

  const GetAllWorkExperiencesUseCase({required this.workExperienceRepository});

  @override
  Future<Either<Failure, List<WorkExperiencesModel>>> call(NoParams params) {
    return workExperienceRepository.getUserWorkExperiences();
  }
}
