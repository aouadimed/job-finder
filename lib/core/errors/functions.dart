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
    case EmailFailure:
      return "Please verify your E-mail";
    case InvalidRestCodeFailure:
      return "Invalid reset code or expired";
    case UsernameFailure:
      return "Username is already in use";
    case CompanyDataEmptyFailure:
      return "Please complete the company profile to proceed.";
    default:
      return "";
  }
}
