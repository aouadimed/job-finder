import 'dart:convert';
import 'package:equatable/equatable.dart';

List<OrganizationActivityModel> organizationActivitiesFromJson(String str) => List<OrganizationActivityModel>.from(json.decode(str).map((x) => OrganizationActivityModel.fromJson(x)));
OrganizationActivityModel organizationActivitieFromJson(String str) =>
    OrganizationActivityModel.fromJson(json.decode(str));
class OrganizationActivityModel extends Equatable {
  final String? id;
  final String? organization;
  final String? role;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final bool? stillMember;

  const OrganizationActivityModel({
    this.id,
    this.organization,
    this.role,
    this.startDate,
    this.endDate,
    this.description,
    this.stillMember,
  });

  factory OrganizationActivityModel.fromJson(Map<String, dynamic> json) => OrganizationActivityModel(
        id: json["_id"],
        organization: json["organization"],
        role: json["role"],
        startDate: json["startDate"] != null ? DateTime.parse(json["startDate"]) : null,
        endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        description: json["description"],
        stillMember: json["stillMember"],
      );

  @override
  List<Object?> get props => [
        id,
        organization,
        role,
        startDate,
        endDate,
        description,
        stillMember,
      ];
}
