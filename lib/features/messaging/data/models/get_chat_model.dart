// Postman Echo is service you can use to test your REST clients and make sample API calls.

// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility

// endpoints.

//

// The documentation for the endpoints as well as example responses can be found at

// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)

// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

class ChatModel {
    List<Chat>?  chats;
    int?  totalPages;
    int?  currentPage;

    ChatModel({
        this.chats,
        this.totalPages,
        this.currentPage,
    });

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
    );

}

class Chat {
    String?  id;
    OtherUser?  otherUser;
    LatestMessage?  latestMessage;
    int?  unseenMessagesCount;

    Chat({
        this.id,
        this.otherUser,
        this.latestMessage,
        this.unseenMessagesCount,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        otherUser: OtherUser.fromJson(json["otherUser"]),
        latestMessage: LatestMessage.fromJson(json["latestMessage"]),
        unseenMessagesCount: json["unseenMessagesCount"],
    );

}

class LatestMessage {
    String?  id;
    OtherUser?  sender;
    String?  content;
    String?  receiver;
    String?  chat;
    List<String>?  readBy;
    List<dynamic>?  deliveredTo;
    DateTime?  createdAt;
    DateTime?  updatedAt;
    int?  v;

    LatestMessage({
        this.id,
        this.sender,
        this.content,
        this.receiver,
        this.chat,
        this.readBy,
        this.deliveredTo,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: OtherUser.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: json["chat"],
        readBy: List<String>.from(json["readBy"].map((x) => x)),
        deliveredTo: List<dynamic>.from(json["deliveredTo"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

}

class OtherUser {
    String? id;
    String?  username;
    String?  email;
    String?  profileImg;

    OtherUser({
        this.id,
        this.username,
        this.email,
        this.profileImg,
    });

    factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profileImg: json["profileImg"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profileImg": profileImg,
    };
}
