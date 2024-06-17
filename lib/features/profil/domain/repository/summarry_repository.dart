import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/summary_model.dart';
import 'package:dartz/dartz.dart';

abstract class SummaryRepository {


Future<Either<Failure,bool>> createOrUpdateSummary ({required String description});


Future <Either<Failure,SummaryModel>> getSummary();


}