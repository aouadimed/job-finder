import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetSingleLanguageParams extends Equatable {
  final String id;

  const GetSingleLanguageParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetSingleLanguageUseCase implements UseCase<LanguageModel, GetSingleLanguageParams> {
  final LanguageRepository languageRepository;

  GetSingleLanguageUseCase({required this.languageRepository});

  @override
  Future<Either<Failure, LanguageModel>> call(GetSingleLanguageParams params) async {
    return await languageRepository.getSingleLanguage(params.id);
  }
}
