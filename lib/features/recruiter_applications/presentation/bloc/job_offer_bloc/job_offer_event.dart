part of 'job_offer_bloc.dart';

@immutable
abstract class JobOfferEvent extends Equatable {
  const JobOfferEvent();
  
  @override
  List<Object?> get props => [];
}

class AddJobOfferEvent extends JobOfferEvent {
  final String subcategoryIndex;
  final int employmentTypeIndex;
  final int locationTypeIndex;
  final String jobDescription;
  final String minimumQualifications;
  final List<String> requiredSkills;
  final String categoryIndex;

  const AddJobOfferEvent({
    required this.subcategoryIndex,
    required this.employmentTypeIndex,
    required this.locationTypeIndex,
    required this.jobDescription,
    required this.minimumQualifications,
    required this.requiredSkills,
    required this.categoryIndex,
  });

  @override
  List<Object?> get props => [
        subcategoryIndex,
        employmentTypeIndex,
        locationTypeIndex,
        jobDescription,
        minimumQualifications,
        requiredSkills,
        categoryIndex,
      ];
}

class GetJobOffersEvent extends JobOfferEvent {
  final int page;
  final String? searchQuery;
  final int? filterIndex;

  const GetJobOffersEvent({
    this.page = 1,
    this.searchQuery,
    this.filterIndex,
  });

  @override
  List<Object?> get props => [page, searchQuery, filterIndex];
}
