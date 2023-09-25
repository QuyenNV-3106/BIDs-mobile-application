// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<CategoryProduct> categoryFromJson(String str) =>
    List<CategoryProduct>.from(
        json.decode(str).map((x) => CategoryProduct.fromJson(x)));

String categoryToJson(List<CategoryProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryProduct {
  String categoryId;
  String categoryName;
  bool status;

  CategoryProduct({
    required this.categoryId,
    required this.categoryName,
    required this.status,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      CategoryProduct(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "status": status,
      };
}
