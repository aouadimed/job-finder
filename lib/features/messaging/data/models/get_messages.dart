// Postman Echo is service you can use to test your REST clients and make sample API calls.

// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility

// endpoints.

//

// The documentation for the endpoints as well as example responses can be found at

// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)

// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

class Message {
    String chatId;
    List<MessageElement> messages;
    int totalPages;
    int currentPage;

    Message({
        required this.chatId,
        required this.messages,
        required this.totalPages,
        required this.currentPage,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        chatId: json["chatId"],
        messages: List<MessageElement>.from(json["messages"].map((x) => MessageElement.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
    );


}

class MessageElement {
    String id;
    String sender;
    String content;
    String receiver;
    List<String> readBy;
    List<String> deliveredTo;
    DateTime createdAt;

    MessageElement({
        required this.id,
        required this.sender,
        required this.content,
        required this.receiver,
        required this.readBy,
        required this.deliveredTo,
        required this.createdAt,
    });

    factory MessageElement.fromJson(Map<String, dynamic> json) => MessageElement(
        id: json["_id"],
        sender: json["sender"],
        content: json["content"],
        receiver: json["receiver"],
        readBy: List<String>.from(json["readBy"].map((x) => x)),
        deliveredTo: List<String>.from(json["deliveredTo"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
    );

}


