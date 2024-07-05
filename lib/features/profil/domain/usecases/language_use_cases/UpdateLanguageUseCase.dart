import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateLanguageParams extends Equatable {
  final String id;
  final int languageIndex;
  final int? proficiencyIndex;

  const UpdateLanguageParams({
    required this.id,
    required this.languageIndex,
    this.proficiencyIndex,
  });

  @override
  List<Object?> get props => [id, languageIndex, proficiencyIndex];
}

class UpdateLanguageUseCase implements UseCase<void, UpdateLanguageParams> {
  final LanguageRepository languageRepository;

  UpdateLanguageUseCase({required this.languageRepository});

  @override
  Future<Either<Failure, void>> call(UpdateLanguageParams params) async {
    return await languageRepository.updateLanguage(params);
  }
}
