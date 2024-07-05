import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateLanguageParams extends Equatable {
  final int languageIndex;
  final int? proficiencyIndex;

  const CreateLanguageParams(
      {required this.languageIndex, this.proficiencyIndex});
  @override
  List<Object?> get props => [languageIndex];
}

class CreateLanguageUseCase implements UseCase<void, CreateLanguageParams> {
  final LanguageRepository languageRepository;

  const CreateLanguageUseCase({required this.languageRepository});

  @override
  Future<Either<Failure, dynamic>> call(params) async {
    return await languageRepository.createLanguage(params);
  }
}
