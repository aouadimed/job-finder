// Postman Echo is service you can use to test your REST clients and make sample API calls.
// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility
// endpoints.
//
// The documentation for the endpoints as well as example responses can be found at
// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));


class UserModel {
    String? username;
    String? firstName;
    String? lastName;
    DateTime? dateOfBirth;
    String? email;
    String? phone;
    String? gender;
    String? country;
    String? role;
    List<int>? expertise;
    String? password;
    String? profileImg;
    bool? active;
    String? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? token;

    UserModel({
        this.username,
        this.firstName,
        this.lastName,
        this.dateOfBirth,
        this.email,
        this.phone,
        this.gender,
        this.country,
        this.role,
        this.expertise,
        this.password,
        this.profileImg,
        this.active,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.token,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        country: json["country"],
        role: json["role"],
        expertise: List<int>.from(json["expertise"].map((x) => x)),
        password: json["password"],
        profileImg: json["profileImg"],
        active: json["active"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        token: json["token"],
    );

}
