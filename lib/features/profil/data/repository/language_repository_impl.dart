import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/language_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/UpdateLanguageUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/create_language_use_case.dart';
import 'package:dartz/dartz.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final NetworkInfo networkInfo;
  final LanguageDataSource languageDataSource;

  const LanguageRepositoryImpl(
      {required this.networkInfo, required this.languageDataSource});

  @override
  Future<Either<Failure, bool>> createLanguage(
      CreateLanguageParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await languageDataSource.createLanguage(params);
      return Right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteLanguage(String id) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await languageDataSource.deleteLanguage(id);
      return Right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateLanguage(UpdateLanguageParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await languageDataSource.updateLanguage(params);
      return Right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<LanguageModel>>> getAllLanguages() async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final languages = await languageDataSource.getAllLanguages();
      return Right(languages);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LanguageModel>> getSingleLanguage(String id) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final language = await languageDataSource.getSingleLanguage(id);
      return Right(language);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
