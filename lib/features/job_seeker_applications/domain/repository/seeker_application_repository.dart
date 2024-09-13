import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/job_seeker_applications/data/models/job_seeker_application_model.dart';
import 'package:cv_frontend/features/job_seeker_applications/domain/usecases/seeker_application_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class SeekerAplicationRepository {
  Future<Either<Failure,JobSeekerAppliactionModel>> getApplcaitions(GetSeekerApplcaitionsParams params);
}