import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));


class UserModel {
    User? user;
    String? token;

    UserModel({
        this.user,
        this.token,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );
}

class User {
    String? id;
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
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? address;

    User({
        this.id,
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
        this.createdAt,
        this.updatedAt,
        this.v,
        this.address,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        address: json["address"],
    );


}
