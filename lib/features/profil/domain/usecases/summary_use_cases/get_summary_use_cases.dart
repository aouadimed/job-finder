import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/summary_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/summarry_repository.dart';
import 'package:dartz/dartz.dart';



class GetSummaryUseCase extends UseCase<SummaryModel, NoParams> {
  final SummaryRepository summaryRepository;

  const GetSummaryUseCase({required this.summaryRepository});

  @override
  Future<Either<Failure, SummaryModel>> call(NoParams params) async {
    return await summaryRepository.getSummary();
  }
}


class NoParams {
  const NoParams();
}
