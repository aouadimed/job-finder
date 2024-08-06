import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/job_seeker_home/data/data_source/category_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource, required this.networkInfo});
 


  @override
  Future<Either<Failure, List<CategorySelectionModel>>>
      getJobCategorys() async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final categorySelectionModel =
          await categoryRemoteDataSource.getJobCategorys();
      return Right(categorySelectionModel);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
