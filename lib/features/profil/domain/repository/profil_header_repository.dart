import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/profil_header_use_cases/update_profil_header_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class ProfilHeaderRepository {
  Future<Either<Failure, ProfilHeaderModel>> getProfilHeader();
  Future<Either<Failure, void>> updateProject(UpdateProfilHeaderParams params);
}
