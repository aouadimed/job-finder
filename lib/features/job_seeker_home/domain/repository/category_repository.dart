import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategorySelectionModel>>> getJobCategorys();
}
