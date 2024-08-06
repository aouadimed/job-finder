import 'dart:convert';

List<CategorySelectionModel> categorySelectionModelFromJson(String str) => List<CategorySelectionModel>.from(json.decode(str).map((x) => CategorySelectionModel.fromJson(x)));


class CategorySelectionModel {
    String? categoryId;
    String? categoryName;

    CategorySelectionModel({
        this.categoryId,
        this.categoryName,
    });

    factory CategorySelectionModel.fromJson(Map<String, dynamic> json) => CategorySelectionModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
    };
}
