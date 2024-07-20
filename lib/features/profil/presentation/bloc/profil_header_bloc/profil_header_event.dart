part of 'profil_header_bloc.dart';

@immutable
abstract class ProfilHeaderEvent extends Equatable {
  const ProfilHeaderEvent();

  @override
  List<Object?> get props => [];
}

class GetProfilHeaderEvent extends ProfilHeaderEvent {}
