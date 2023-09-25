// To parse this JSON data, do
//
//     final bookingItemWaitting = bookingItemWaittingFromJson(jsonString);

import 'dart:convert';

List<BookingItemWaitting> bookingItemWaittingFromJson(String str) =>
    List<BookingItemWaitting>.from(
        json.decode(str).map((x) => BookingItemWaitting.fromJson(x)));

String bookingItemWaittingToJson(List<BookingItemWaitting> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingItemWaitting {
  String bookingItemId;
  String itemId;
  String itemName;
  String staffName;
  DateTime createDate;
  DateTime updateDate;
  String status;
  String userName;
  String categoryName;
  String descriptionDetail;
  int quantity;
  int auctionTime;
  List<Description> descriptions;
  List<Image> images;
  double firstPrice;
  double stepPrice;
  bool deposit;

  BookingItemWaitting({
    required this.bookingItemId,
    required this.itemId,
    required this.itemName,
    required this.staffName,
    required this.createDate,
    required this.updateDate,
    required this.status,
    required this.userName,
    required this.categoryName,
    required this.descriptionDetail,
    required this.quantity,
    required this.auctionTime,
    required this.descriptions,
    required this.images,
    required this.firstPrice,
    required this.stepPrice,
    required this.deposit,
  });

  factory BookingItemWaitting.fromJson(Map<String, dynamic> json) =>
      BookingItemWaitting(
        bookingItemId: json["bookingItemId"],
        itemId: json["itemId"],
        itemName: json["itemName"],
        staffName: json["staffName"],
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        status: json["status"],
        userName: json["userName"],
        categoryName: json["categoryName"],
        descriptionDetail: json["descriptionDetail"],
        quantity: json["quantity"],
        auctionTime: json["auctionTime"],
        descriptions: List<Description>.from(
            json["descriptions"].map((x) => Description.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        firstPrice: json["firstPrice"]?.toDouble(),
        stepPrice: json["stepPrice"]?.toDouble(),
        deposit: json["deposit"],
      );

  Map<String, dynamic> toJson() => {
        "bookingItemId": bookingItemId,
        "itemId": itemId,
        "itemName": itemName,
        "staffName": staffName,
        "createDate": createDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),
        "status": status,
        "userName": userName,
        "categoryName": categoryName,
        "descriptionDetail": descriptionDetail,
        "quantity": quantity,
        "auctionTime": auctionTime,
        "descriptions": List<dynamic>.from(descriptions.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "firstPrice": firstPrice,
        "stepPrice": stepPrice,
        "deposit": deposit,
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

class Image {
  String detail;

  Image({
    required this.detail,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
      };
}
