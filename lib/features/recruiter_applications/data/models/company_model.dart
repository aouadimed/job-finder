import 'dart:convert';

CompanyProfileModel companyProfileModelFromJson(String str) => CompanyProfileModel.fromJson(json.decode(str));

String companyProfileModelToJson(CompanyProfileModel data) => json.encode(data.toJson());

class CompanyProfileModel {
    String? id;
    String? user;
    String? companyName;
    String? aboutCompany;
    String? website;
    String? country;
    List<Address>? addresses;
    String? logoName;
    int? v;

    CompanyProfileModel({
        this.id,
        this.user,
        this.companyName,
        this.aboutCompany,
        this.website,
        this.country,
        this.addresses,
        this.logoName,
        this.v,
    });

    factory CompanyProfileModel.fromJson(Map<String, dynamic> json) => CompanyProfileModel(
        id: json["_id"],
        user: json["user"],
        companyName: json["companyName"],
        aboutCompany: json["aboutCompany"],
        website: json["website"],
        country: json["country"],
        addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
        logoName: json["logoName"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "companyName": companyName,
        "aboutCompany": aboutCompany,
        "website": website,
        "country": country,
        "addresses": List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "logoName": logoName,
        "__v": v,
    };
}

class Address {
    String? address;
    String? id;

    Address({
        this.address,
        this.id,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
    if (id != null) "_id": id,
    };
}
