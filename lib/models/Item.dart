// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  String itemId;
  String userName;
  String itemName;
  String categoryName;
  List<Description> descriptions;
  String descriptionDetail;
  int quantity;
  List<ImageItem> images;
  double firstPrice;
  double stepPrice;
  bool deposit;
  DateTime createDate;
  DateTime updateDate;

  Item({
    required this.itemId,
    required this.userName,
    required this.itemName,
    required this.categoryName,
    required this.descriptions,
    required this.descriptionDetail,
    required this.quantity,
    required this.images,
    required this.firstPrice,
    required this.stepPrice,
    required this.deposit,
    required this.createDate,
    required this.updateDate,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["itemId"],
        userName: json["userName"],
        itemName: json["itemName"],
        categoryName: json["categoryName"],
        descriptions: List<Description>.from(
            json["descriptions"].map((x) => Description.fromJson(x))),
        descriptionDetail: json["descriptionDetail"],
        quantity: json["quantity"],
        images: List<ImageItem>.from(
            json["images"].map((x) => ImageItem.fromJson(x))),
        firstPrice: json["firstPrice"]?.toDouble(),
        stepPrice: json["stepPrice"]?.toDouble(),
        deposit: json["deposit"],
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "userName": userName,
        "itemName": itemName,
        "categoryName": categoryName,
        "descriptions": List<dynamic>.from(descriptions.map((x) => x.toJson())),
        "descriptionDetail": descriptionDetail,
        "quantity": quantity,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "firstPrice": firstPrice,
        "stepPrice": stepPrice,
        "deposit": deposit,
        "createDate": createDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),
      };
}

class Description {
  String description;
  String detail;

  Description({
    required this.description,
    required this.detail,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        description: json["description"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "detail": detail,
      };
}

class ImageItem {
  String detail;

  ImageItem({
    required this.detail,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
      };
}
