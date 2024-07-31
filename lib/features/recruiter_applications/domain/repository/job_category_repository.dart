import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_category_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_category_use_cases/get_job_category_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class JobCategoryRepository {
  Future<Either<Failure, List<JobCategoryModel>>> getJobCategory(
      GetJobCategoryParams params);
}
