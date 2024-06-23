import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:dartz/dartz.dart';

class GetAllEducationsUseCase extends UseCase<List<EducationsModel>, NoParams> {
  final EducationRepository educationRepository;

  const GetAllEducationsUseCase({required this.educationRepository});

  @override
  Future<Either<Failure, List<EducationsModel>>> call(NoParams params) {
    return educationRepository.getUserEducations();
  }
}
