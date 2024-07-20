part of 'profil_header_bloc.dart';

@immutable
abstract class ProfilHeaderState extends Equatable {
  const ProfilHeaderState();

  @override
  List<Object?> get props => [];
}

class ProfilHeaderInitial extends ProfilHeaderState {}

class ProfilHeaderLoading extends ProfilHeaderState {}

class ProfilHeaderFailure extends ProfilHeaderState {
  final bool isIntentFailure;
  final String message;

  const ProfilHeaderFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class GetProfilHeaderSuccess extends ProfilHeaderState {
  final ProfilHeaderModel profileHeader;

  const GetProfilHeaderSuccess({required this.profileHeader});

  @override
  List<Object?> get props => [profileHeader];
}
