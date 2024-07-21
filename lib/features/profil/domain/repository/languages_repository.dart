import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/update_language_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/create_language_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class LanguageRepository {
  Future<Either<Failure, void>> createLanguage(CreateLanguageParams params);
  Future<Either<Failure, List<LanguageModel>>> getAllLanguages();
  Future<Either<Failure, LanguageModel>> getSingleLanguage(String id);
  Future<Either<Failure, void>> updateLanguage(UpdateLanguageParams params);
  Future<Either<Failure, void>> deleteLanguage(String id);
}
