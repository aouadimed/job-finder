import 'package:cv_frontend/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class SavedJobRepository {
  Future<Either<Failure, bool>> checkSavedJobStatus({required String id});
  Future<Either<Failure, bool>> saveJobStatus({required String id});
  Future<Either<Failure, bool>> deleteJobStatus({required String id});

}
