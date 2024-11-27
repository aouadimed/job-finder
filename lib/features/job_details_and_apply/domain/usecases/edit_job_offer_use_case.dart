import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/repository/job_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class EditJobOfferUseCase implements UseCase<void, EditJobOfferParams> {
  final JobDetailsRepository jobDetailsRepository;

  EditJobOfferUseCase({required this.jobDetailsRepository});
  @override
  Future<Either<Failure, void>> call(EditJobOfferParams params) async {
    return await jobDetailsRepository.editJobOffer(params);
  }
}

class EditJobOfferParams extends Equatable {
  final String id;
  final String subcategoryIndex;
  final int employmentTypeIndex;
  final int locationTypeIndex;
  final String jobDescription;
  final String minimumQualifications;
  final List<String> requiredSkills;
  final String categoryIndex;

  const EditJobOfferParams(
      {required this.id,
      required this.subcategoryIndex,
      required this.employmentTypeIndex,
      required this.locationTypeIndex,
      required this.jobDescription,
      required this.minimumQualifications,
      required this.requiredSkills,
      required this.categoryIndex});

  @override
  List<Object?> get props => [
        id,
        subcategoryIndex,
        employmentTypeIndex,
        locationTypeIndex,
        jobDescription,
        minimumQualifications,
        requiredSkills,
        categoryIndex
      ];
}
