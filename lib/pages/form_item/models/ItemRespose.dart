// To parse this JSON data, do
//
//     final itemRespose = itemResposeFromJson(jsonString);

import 'dart:convert';

List<ItemRespose> itemResposeFromJson(String str) => List<ItemRespose>.from(
    json.decode(str).map((x) => ItemRespose.fromJson(x)));

String itemResposeToJson(List<ItemRespose> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemRespose {
  String itemId;
  String userName;
  String itemName;
  String categoryName;
  String descriptionDetail;
  int quantity;
  double firstPrice;
  double stepPrice;
  int auctionTime;
  bool deposit;
  DateTime createDate;
  DateTime updateDate;

  ItemRespose({
    required this.itemId,
    required this.userName,
    required this.itemName,
    required this.categoryName,
    required this.descriptionDetail,
    required this.quantity,
    required this.firstPrice,
    required this.stepPrice,
    required this.auctionTime,
    required this.deposit,
    required this.createDate,
    required this.updateDate,
  });

  factory ItemRespose.fromJson(Map<String, dynamic> json) => ItemRespose(
        itemId: json["itemId"],
        userName: json["userName"],
        itemName: json["itemName"],
        categoryName: json["categoryName"],
        descriptionDetail: json["descriptionDetail"],
        quantity: json["quantity"],
        firstPrice: json["firstPrice"],
        stepPrice: json["stepPrice"],
        auctionTime: json["auctionTime"],
        deposit: json["deposit"],
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "userName": userName,
        "itemName": itemName,
        "categoryName": categoryName,
        "descriptionDetail": descriptionDetail,
        "quantity": quantity,
        "firstPrice": firstPrice,
        "stepPrice": stepPrice,
        "auctionTime": auctionTime,
        "deposit": deposit,
        "createDate": createDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),
      };
}
