// To parse this JSON data, do
//
//     final categoryItem = categoryItemFromJson(jsonString);

import 'dart:convert';

List<CategoryItem> categoryItemFromJson(String str) => List<CategoryItem>.from(
    json.decode(str).map((x) => CategoryItem.fromJson(x)));

String categoryItemToJson(List<CategoryItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryItem {
  String categoryId;
  String categoryName;
  List<Description> descriptions;
  DateTime updateDate;
  DateTime createDate;
  bool status;

  CategoryItem({
    required this.categoryId,
    required this.categoryName,
    required this.descriptions,
    required this.updateDate,
    required this.createDate,
    required this.status,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        descriptions: List<Description>.from(
            json["descriptions"].map((x) => Description.fromJson(x))),
        updateDate: DateTime.parse(json["updateDate"]),
        createDate: DateTime.parse(json["createDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "descriptions": List<dynamic>.from(descriptions.map((x) => x.toJson())),
        "updateDate": updateDate.toIso8601String(),
        "createDate": createDate.toIso8601String(),
        "status": status,
      };
}

class Description {
  String id;
  String name;

  Description({
    required this.id,
    required this.name,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
