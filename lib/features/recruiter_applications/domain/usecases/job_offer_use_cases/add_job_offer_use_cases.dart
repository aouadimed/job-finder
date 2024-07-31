import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_offer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddJobOfferUseCase implements UseCase<void, AddJobOfferParams> {
  final JobOfferRepository jobOfferRepository;

  AddJobOfferUseCase({required this.jobOfferRepository});

  @override
  Future<Either<Failure, void>> call(AddJobOfferParams params) async {
    return await jobOfferRepository.addJobOffer(params);
  }
}

class AddJobOfferParams extends Equatable {
  final String subcategoryIndex;
  final int employmentTypeIndex;
  final int locationTypeIndex;
  final String jobDescription;
  final String minimumQualifications;
  final List<String> requiredSkills;
  final String categoryIndex;

  const AddJobOfferParams(
      {required this.subcategoryIndex,
      required this.employmentTypeIndex,
      required this.locationTypeIndex,
      required this.jobDescription,
      required this.minimumQualifications,
      required this.requiredSkills,
      required this.categoryIndex});

  @override
  List<Object?> get props => [
        subcategoryIndex,
        employmentTypeIndex,
        locationTypeIndex,
        jobDescription,
        minimumQualifications,
        requiredSkills,
        categoryIndex
      ];
}
