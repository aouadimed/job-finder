import 'package:cv_frontend/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  const UseCase();
  Future<Either<Failure, Type>> call(Params params);
}
