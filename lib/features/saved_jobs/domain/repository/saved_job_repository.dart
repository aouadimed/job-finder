import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/saved_jobs/data/models/saved_jobs_model.dart';
import 'package:cv_frontend/features/saved_jobs/domain/usecases/get_saved_jobs_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class SavedJobsRepository {
  Future<Either<Failure,SavedJobsModel>> getSavedJobs(GetSavedJobsParams params);
}