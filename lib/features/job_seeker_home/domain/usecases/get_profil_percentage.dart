import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/profil_percentage_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/profil_percentage_repository.dart';
import 'package:dartz/dartz.dart';

class ProfilPercentageUseCase implements UseCase<CompletionPercentage, void> {
  final ProfilPercentageRepository profilPercentageRepository;

  ProfilPercentageUseCase({required this.profilPercentageRepository});

  @override
  Future<Either<Failure, CompletionPercentage>> call(void params) async {
    return await profilPercentageRepository.getPercentage();
  }
}
