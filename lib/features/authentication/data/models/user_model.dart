import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  String? id;
  String? username;
  String? email;
  bool? isAdmin;
  bool? isAgent;
  List<bool>? skills;
  String? profile;
  String? userToken;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.isAdmin,
    this.isAgent,
    this.skills,
    this.profile,
    this.userToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: json["skills"] == null
            ? []
            : List<bool>.from(json["skills"]!.map((x) => x)),
        profile: json["profile"],
        userToken: json["userToken"],
      );
}
