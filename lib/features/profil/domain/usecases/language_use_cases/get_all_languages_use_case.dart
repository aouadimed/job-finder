import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:dartz/dartz.dart';

class GetAllLanguagesUseCase implements UseCase<List<LanguageModel>, NoParams> {
  final LanguageRepository languageRepository;

  GetAllLanguagesUseCase({required this.languageRepository});

  @override
  Future<Either<Failure, List<LanguageModel>>> call(NoParams params) async {
    return await languageRepository.getAllLanguages();
  }
}
