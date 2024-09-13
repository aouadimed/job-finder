import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/messaging/data/models/get_chat_model.dart';
import 'package:cv_frontend/features/messaging/data/models/get_messages.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/get_chat_messages_use_case.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/get_chats_use_case.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/send_message_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class MessagingRepository {
Future<Either<Failure,void>> sendMessage(SendMessageParams params);
Future<Either<Failure,ChatModel>> getChats(GetChatsParams params);
Future<Either<Failure,Message>> getMessages(GetMessagesChatsParams params);

}