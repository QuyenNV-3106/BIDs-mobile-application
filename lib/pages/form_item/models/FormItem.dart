// To parse this JSON data, do
//
//     final formItem = formItemFromJson(jsonString);

import 'dart:convert';

FormItem formItemFromJson(String str) => FormItem.fromJson(json.decode(str));

String formItemToJson(FormItem data) => json.encode(data.toJson());

class FormItem {
  String userId;
  String itemName;
  String description;
  String categoryId;
  int quantity;
  bool deposit;
  int auctionHour;
  int auctionMinute;
  double firstPrice;
  double stepPrice;
  int typeOfSession;

  FormItem({
    required this.userId,
    required this.itemName,
    required this.description,
    required this.categoryId,
    required this.quantity,
    required this.deposit,
    required this.auctionHour,
    required this.auctionMinute,
    required this.firstPrice,
    required this.stepPrice,
    required this.typeOfSession,
  });

  factory FormItem.fromJson(Map<String, dynamic> json) => FormItem(
        userId: json["userId"],
        itemName: json["itemName"],
        description: json["description"],
        categoryId: json["categoryId"],
        quantity: json["quantity"],
        deposit: json["deposit"],
        auctionHour: json["auctionHour"],
        auctionMinute: json["auctionMinute"],
        firstPrice: json["firstPrice"]?.toDouble(),
        stepPrice: json["stepPrice"]?.toDouble(),
        typeOfSession: json["typeOfSession"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "itemName": itemName,
        "description": description,
        "categoryId": categoryId,
        "quantity": quantity,
        "deposit": deposit,
        "auctionHour": auctionHour,
        "auctionMinute": auctionMinute,
        "firstPrice": firstPrice,
        "stepPrice": stepPrice,
        "typeOfSession": typeOfSession,
      };
}
