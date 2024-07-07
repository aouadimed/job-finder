import 'dart:convert';

import 'package:equatable/equatable.dart';

List<SkillsModel> skillsModelFromJson(String str) => List<SkillsModel>.from(json.decode(str).map((x) => SkillsModel.fromJson(x)));

class SkillsModel extends Equatable {
  final  String? id;
  final  String? user;
  final  String? skill;
  final  DateTime? createdAt;
  final  DateTime? updatedAt;
  final  int? v;

   const SkillsModel({
        this.id,
        this.user,
        this.skill,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory SkillsModel.fromJson(Map<String, dynamic> json) => SkillsModel(
        id: json["_id"],
        user: json["user"],
        skill: json["skill"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );



  
  @override
  List<Object?> get props => [id,user,skill,createdAt,updatedAt,v];

}