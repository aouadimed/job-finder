import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/summary_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/summarry_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SummaryUseCase extends UseCase<bool, SummaryParams> {
  final SummaryRepository summaryRepository;

  const SummaryUseCase({required this.summaryRepository});

  @override
  Future<Either<Failure, bool>> call(SummaryParams params) async {
    return await summaryRepository.createOrUpdateSummary(
        description: params.description);
  }
}

class GetSummaryUseCse extends UseCase<SummaryModel, NoParams> {
  final SummaryRepository summaryRepository;

  const GetSummaryUseCse({required this.summaryRepository});

  @override
  Future<Either<Failure, SummaryModel>> call(NoParams params) async {
    return await summaryRepository.getSummary();
  }
}

class SummaryParams extends Equatable {
  final String description;

  const SummaryParams({required this.description});

  @override
  List<Object?> get props => [description];
}

class NoParams {
  const NoParams();
}
