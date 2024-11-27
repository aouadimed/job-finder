part of 'profil_header_bloc.dart';

@immutable
abstract class ProfilHeaderEvent extends Equatable {
  const ProfilHeaderEvent();

  @override
  List<Object?> get props => [];
}

class GetProfilHeaderEvent extends ProfilHeaderEvent {}


class UpdateProfilHeaderEvent extends ProfilHeaderEvent {
  final String? firstName;
  final String? lastName;
  final String? profileImg;
  final bool? deletePhoto;

  const UpdateProfilHeaderEvent(
      { this.firstName,
       this.lastName,
       this.profileImg,
       this.deletePhoto});

  @override
  List<Object?> get props => [firstName, lastName, profileImg, deletePhoto];
}