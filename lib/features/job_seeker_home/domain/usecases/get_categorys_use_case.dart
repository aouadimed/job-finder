import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoryssUsecase
    implements UseCase<List<CategorySelectionModel>, void> {
  final CategoryRepository categoryRepository;

  GetCategoryssUsecase({required this.categoryRepository});
  @override
  Future<Either<Failure, List<CategorySelectionModel>>> call(
      void params) async {
    return await categoryRepository.getJobCategorys();
  }
}
