import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/profil_header_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:dartz/dartz.dart';

class GetProfilHeaderUseCase implements UseCase<ProfilHeaderModel, NoParams> {
  final ProfilHeaderRepository profilHeaderRepository;

  const GetProfilHeaderUseCase({required this.profilHeaderRepository});
  @override
  Future<Either<Failure, ProfilHeaderModel>> call(NoParams params) async {
    return await profilHeaderRepository.getProfilHeader();
  }
}
