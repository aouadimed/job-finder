import 'dart:convert';

import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/messaging/data/models/get_chat_model.dart';
import 'package:cv_frontend/features/messaging/data/models/get_messages.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/get_chat_messages_use_case.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/get_chats_use_case.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/send_message_usecase.dart';
import 'package:http/http.dart' as https;

abstract class SendMessageRemoteDataSource {
  Future<void> sendMessage(SendMessageParams params);
  Future<ChatModel> getChats(GetChatsParams params);
  Future<Message> getMessages(GetMessagesChatsParams params);
}

class SendMessageRemoteDataSourceImpl implements SendMessageRemoteDataSource {
  final https.Client client;

  SendMessageRemoteDataSourceImpl({required this.client});

  @override
  Future<void> sendMessage(SendMessageParams params) async {
    try {
      Map<String, dynamic> requestBody = {
        "content": params.content,
        "receiver": params.receiver
      };
      final response = await https.post(Uri.http(url, messaging),
          body: jsonEncode(requestBody),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer ${TokenManager.token}"
          }).catchError(
        (e) => throw ServerException(),
      );
      if (response.statusCode != 200) {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<ChatModel> getChats(GetChatsParams params) async {
    try {
      final queryParameters = {
        'page': params.page.toString(),
      };
      final uri = Uri.http(url, messaging, queryParameters);
      final response = await client.get(
        uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });
      if (response.statusCode == 200) {
        return chatModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Message> getMessages(GetMessagesChatsParams params) async {
    try {
      final queryParameters = {
        'page': params.page.toString(),
      };
      final uri = Uri.http(url, "$messaging/${params.id}", queryParameters);
      final response = await client.get(
        uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });
      if (response.statusCode == 200) {
        return messageFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
