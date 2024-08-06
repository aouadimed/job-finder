import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/get_recent_jobs_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure,JobCardModel>> getRecentJobs(GetRecentJobsParams params);
}