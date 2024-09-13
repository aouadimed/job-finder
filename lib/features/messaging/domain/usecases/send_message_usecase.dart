import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/messaging/domain/repository/messaging_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendMessageParams extends Equatable {
  final String receiver;
  final String content;

  const SendMessageParams({required this.receiver, required this.content});

  @override
  List<Object?> get props => [receiver, content];
}

class SendMessageUsecase implements UseCase<void, SendMessageParams> {
  final MessagingRepository messagingRepository;

  SendMessageUsecase({required this.messagingRepository});
  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return await messagingRepository.sendMessage(params);
  }
}
