import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/skill_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/models/skill_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/skill_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/create_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/delete_skill_use_case.dart';
import 'package:dartz/dartz.dart';

class SkillRepositoryImpl implements SkillRepository {
  final NetworkInfo networkInfo;
  final SkillRemoteDataSource skillRemoteDataSource;

  SkillRepositoryImpl({
    required this.networkInfo,
    required this.skillRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> createSkill(CreateSkillParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await skillRemoteDataSource.createSkill(params);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteSkill(DeleteSkillParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await skillRemoteDataSource.deleteSkill(params);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<SkillsModel>>> getSkills() async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final skills = await skillRemoteDataSource.getSkills();
      return Right(skills);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
