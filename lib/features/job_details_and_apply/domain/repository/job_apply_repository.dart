import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/job_apply_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class JobApplyRepository {
  Future<Either<Failure, void>> jobApply(JobApplyParams params);
}
