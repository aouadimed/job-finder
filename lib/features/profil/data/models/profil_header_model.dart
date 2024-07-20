import 'dart:convert';

ProfilHeaderModel profilHeaderModelFromJson(String str) => ProfilHeaderModel.fromJson(json.decode(str));

class ProfilHeaderModel {
    String firstName;
    String lastName;
    String profilImg;

    ProfilHeaderModel({
        this.firstName = "Mohamed",
        this.lastName ="Aouadi",
        this.profilImg ="https://gravatar.com/avatar/201b32072e88f72e006045b68a0f9e36?s=400&d=retro&r=x",
    });

    factory ProfilHeaderModel.fromJson(Map<String, dynamic> json) => ProfilHeaderModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilImg: json["profilImg"],
    );

}
