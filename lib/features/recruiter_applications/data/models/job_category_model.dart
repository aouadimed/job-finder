import 'dart:convert';

List<JobCategoryModel> jobCategoryModelFromJson(String str) => List<JobCategoryModel>.from(json.decode(str).map((x) => JobCategoryModel.fromJson(x)));

class JobCategoryModel {
    String? id;
    String? name;
    List<Subcategory>? subcategories;

    JobCategoryModel({
        this.id,
        this.name,
        this.subcategories,
    });

    factory JobCategoryModel.fromJson(Map<String, dynamic> json) => JobCategoryModel(
        id: json["_id"],
        name: json["name"],
        subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
    );

}

class Subcategory {
    String? name;
    int? index;
    String? id;

    Subcategory({
        this.name,
        this.index,
        this.id,
    });

    factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        name: json["name"],
        index: json["index"],
        id: json["_id"],
    );

}
