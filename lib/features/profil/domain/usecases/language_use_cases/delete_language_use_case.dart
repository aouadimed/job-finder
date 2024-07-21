import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteLanguageParams extends Equatable {
  final String id;

  const DeleteLanguageParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteLanguageUseCase implements UseCase<void, DeleteLanguageParams> {
  final LanguageRepository languageRepository;

  DeleteLanguageUseCase({required this.languageRepository});

  @override
  Future<Either<Failure, void>> call(DeleteLanguageParams params) async {
    return await languageRepository.deleteLanguage(params.id);
  }
}
