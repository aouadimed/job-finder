import 'package:cv_frontend/core/errors/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case EmailExistsFailure:
    return "Email is already in use";
    case ServerFailure:
      return "An error occurred in our server ! please try again later";
    case UserCredentialFailure:
      return "Verify your credential !";
    case ConnexionFailure:
      return "Please verify your connexion and try again !";
    default:
      return "";
  }
}
