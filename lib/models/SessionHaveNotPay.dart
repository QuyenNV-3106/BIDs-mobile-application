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
  SessionResponseCompletes? sessionResponseCompletes;
  String? winner;

  SessionHaveNotPay({
    this.sessionResponseCompletes,
    this.winner,
  });

  factory SessionHaveNotPay.fromJson(Map<String, dynamic> json) =>
      SessionHaveNotPay(
        sessionResponseCompletes: json["sessionResponseCompletes"] == null
            ? null
            : SessionResponseCompletes.fromJson(
                json["sessionResponseCompletes"]),
        winner: json["winner"],
      );

  Map<String, dynamic> toJson() => {
        "sessionResponseCompletes": sessionResponseCompletes?.toJson(),
        "winner": winner,
      };
}

class SessionResponseCompletes {
  String? sessionId;
  String? itemId;
  String? feeName;
  String? sessionName;
  List<ImageItem>? images;
  List<Description>? descriptions;
  double? participationFee;
  bool? deposit;
  double? depositFee;
  int? auctionTime;
  String? itemName;
  String? categoryName;
  String? description;
  DateTime? beginTime;
  DateTime? endTime;
  double? finalPrice;
  int? status;

  SessionResponseCompletes({
    this.sessionId,
    this.itemId,
    this.feeName,
    this.sessionName,
    this.images,
    this.descriptions,
    this.participationFee,
    this.deposit,
    this.depositFee,
    this.auctionTime,
    this.itemName,
    this.categoryName,
    this.description,
    this.beginTime,
    this.endTime,
    this.finalPrice,
    this.status,
  });

  factory SessionResponseCompletes.fromJson(Map<String, dynamic> json) =>
      SessionResponseCompletes(
        sessionId: json["sessionId"],
        itemId: json["itemId"],
        feeName: json["feeName"],
        sessionName: json["sessionName"],
        images: json["images"] == null
            ? []
            : List<ImageItem>.from(
                json["images"]!.map((x) => ImageItem.fromJson(x))),
        descriptions: json["descriptions"] == null
            ? []
            : List<Description>.from(
                json["descriptions"]!.map((x) => Description.fromJson(x))),
        participationFee: json["participationFee"]?.toDouble(),
        deposit: json["deposit"],
        depositFee: json["depositFee"]?.toDouble(),
        auctionTime: json["auctionTime"],
        itemName: json["itemName"],
        categoryName: json["categoryName"],
        description: json["description"],
        beginTime: json["beginTime"] == null
            ? null
            : DateTime.parse(json["beginTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        finalPrice: json["finalPrice"]?.toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "itemId": itemId,
        "feeName": feeName,
        "sessionName": sessionName,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "descriptions": descriptions == null
            ? []
            : List<dynamic>.from(descriptions!.map((x) => x.toJson())),
        "participationFee": participationFee,
        "deposit": deposit,
        "depositFee": depositFee,
        "auctionTime": auctionTime,
        "itemName": itemName,
        "categoryName": categoryName,
        "description": description,
        "beginTime": beginTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "finalPrice": finalPrice,
        "status": status,
      };
}

class Description {
  String? description;
  String? detail;

  Description({
    this.description,
    this.detail,
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
  String? detail;

  ImageItem({
    this.detail,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
      };
}
