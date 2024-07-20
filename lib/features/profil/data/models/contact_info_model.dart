import 'dart:convert';

ContactInfoModel contactInfoModelFromJson(String str) =>
    ContactInfoModel.fromJson(json.decode(str));

class ContactInfoModel {
  String? id;
  String? email;
  String? phone;
  String? address;
  String? country;

  ContactInfoModel(
      {this.id = "",
      this.email = "",
      this.phone = "",
      this.address = "",
      this.country = ""});

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) =>
      ContactInfoModel(
        id: json["_id"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        country: json["country"],
      );
}
