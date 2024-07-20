import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class UserNotExistFailure extends Failure {}

class UserCredentialFailure extends Failure {}

class UserDisabledFailure extends Failure {}

class ConnexionFailure extends Failure {}

class EmailExistsFailure extends Failure {}

class EmailFailure extends Failure {}

class InvalidRestCodeFailure extends Failure {}

class UsernameFailure extends Failure {}

