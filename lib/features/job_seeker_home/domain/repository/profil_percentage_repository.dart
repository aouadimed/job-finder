import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/profil_percentage_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfilPercentageRepository {
  Future<Either<Failure,CompletionPercentage>> getPercentage();
}