// To parse this JSON data, do
//
//     final sessionHaveNotPay = sessionHaveNotPayFromJson(jsonString);

import 'dart:convert';

List<SessionHaveNotPay> sessionHaveNotPayFromJson(String str) =>
    List<SessionHaveNotPay>.from(
        json.decode(str).map((x) => SessionHaveNotPay.fromJson(x)));

String sessionHaveNotPayToJson(List<SessionHaveNotPay> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SessionHaveNotPay {
  SessionResponseCompletes sessionResponseCompletes;
  String winner;

  SessionHaveNotPay({
    required this.sessionResponseCompletes,
    required this.winner,
  });

  factory SessionHaveNotPay.fromJson(Map<String, dynamic> json) =>
      SessionHaveNotPay(
        sessionResponseCompletes:
            SessionResponseCompletes.fromJson(json["sessionResponseCompletes"]),
        winner: json["winner"],
      );

  Map<String, dynamic> toJson() => {
        "sessionResponseCompletes": sessionResponseCompletes.toJson(),
        "winner": winner,
      };
}

class SessionResponseCompletes {
  String sessionId;
  String itemId;
  String feeName;
  String sessionName;
  List<ImageItem> ImageItems;
  List<Description> descriptions;
  double participationFee;
  bool deposit;
  double depositFee;
  int auctionTime;
  String itemName;
  String categoryName;
  String description;
  String freeTime;
  String delayTime;
  String delayFreeTime;
  DateTime beginTime;
  DateTime endTime;
  double firstPrice;
  double finalPrice;
  double stepPrice;
  DateTime createDate;
  DateTime updateDate;
  int status;

  SessionResponseCompletes({
    required this.sessionId,
    required this.itemId,
    required this.feeName,
    required this.sessionName,
    required this.ImageItems,
    required this.descriptions,
    required this.participationFee,
    required this.deposit,
    required this.depositFee,
    required this.auctionTime,
    required this.itemName,
    required this.categoryName,
    required this.description,
    required this.freeTime,
    required this.delayTime,
    required this.delayFreeTime,
    required this.beginTime,
    required this.endTime,
    required this.firstPrice,
    required this.finalPrice,
    required this.stepPrice,
    required this.createDate,
    required this.updateDate,
    required this.status,
  });

  factory SessionResponseCompletes.fromJson(Map<String, dynamic> json) =>
      SessionResponseCompletes(
        sessionId: json["sessionId"],
        itemId: json["itemId"],
        feeName: json["feeName"],
        sessionName: json["sessionName"],
        ImageItems: List<ImageItem>.from(
            json["images"].map((x) => ImageItem.fromJson(x))),
        descriptions: List<Description>.from(
            json["descriptions"].map((x) => Description.fromJson(x))),
        participationFee: json["participationFee"]?.toDouble(),
        deposit: json["deposit"],
        depositFee: json["depositFee"]?.toDouble(),
        auctionTime: json["auctionTime"],
        itemName: json["itemName"],
        categoryName: json["categoryName"],
        description: json["description"],
        freeTime: json["freeTime"],
        delayTime: json["delayTime"],
        delayFreeTime: json["delayFreeTime"],
        beginTime: DateTime.parse(json["beginTime"]),
        endTime: DateTime.parse(json["endTime"]),
        firstPrice: json["firstPrice"]?.toDouble(),
        finalPrice: json["finalPrice"]?.toDouble(),
        stepPrice: json["stepPrice"]?.toDouble(),
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "itemId": itemId,
        "feeName": feeName,
        "sessionName": sessionName,
        "images": List<dynamic>.from(ImageItems.map((x) => x.toJson())),
        "descriptions": List<dynamic>.from(descriptions.map((x) => x.toJson())),
        "participationFee": participationFee,
        "deposit": deposit,
        "depositFee": depositFee,
        "auctionTime": auctionTime,
        "itemName": itemName,
        "categoryName": categoryName,
        "description": description,
        "freeTime": freeTime,
        "delayTime": delayTime,
        "delayFreeTime": delayFreeTime,
        "beginTime": beginTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "firstPrice": firstPrice,
        "finalPrice": finalPrice,
        "stepPrice": stepPrice,
        "createDate": createDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),
        "status": status,
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
