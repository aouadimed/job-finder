part of 'job_detail_bloc.dart';

@immutable
class JobDetailEvent extends Equatable {
  const JobDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetJobDetailEvent extends JobDetailEvent {
  final String id;

  const GetJobDetailEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class EditJobOfferEvent extends JobDetailEvent {
  final String id;
  final String subcategoryIndex;
  final int employmentTypeIndex;
  final int locationTypeIndex;
  final String jobDescription;
  final String minimumQualifications;
  final List<String> requiredSkills;
  final String categoryIndex;

  const EditJobOfferEvent({
    required this.id,
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

class DeleteJobOfferEvent extends JobDetailEvent {
  final String id;

  const DeleteJobOfferEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
