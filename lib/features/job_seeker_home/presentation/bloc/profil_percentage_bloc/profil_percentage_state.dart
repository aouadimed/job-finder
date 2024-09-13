part of "profil_percentage_bloc.dart";

@immutable
class ProfilPercentageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfilPercentageLoading extends ProfilPercentageState {}

class ProfilPercentageInitial extends ProfilPercentageState {}

class ProfilPercentageFailure extends ProfilPercentageState {
  final String message;
  final bool isIntentFailure;

  ProfilPercentageFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class ProfilPercentageSuccess extends ProfilPercentageState {
  final CompletionPercentage completionPercentage;

  ProfilPercentageSuccess({required this.completionPercentage});

  @override
  List<Object?> get props => [completionPercentage];
}
