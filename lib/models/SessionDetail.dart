// To parse this JSON data, do
//
//     final sessionDetail = sessionDetailFromJson(jsonString);

import 'dart:convert';

List<SessionDetail> sessionDetailFromJson(String str) =>
    List<SessionDetail>.from(
        json.decode(str).map((x) => SessionDetail.fromJson(x)));

String sessionDetailToJson(List<SessionDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SessionDetail {
  String? sessionDetailId;
  String? userId;
  String? userName;
  String? itemId;
  String? itemName;
  String? sessionId;
  String? sessionName;
  double? price;
  DateTime? createDate;
  bool? status;

  SessionDetail({
    this.sessionDetailId,
    this.userId,
    this.userName,
    this.itemId,
    this.itemName,
    this.sessionId,
    this.sessionName,
    this.price,
    this.createDate,
    this.status,
  });

  factory SessionDetail.fromJson(Map<String, dynamic> json) => SessionDetail(
        sessionDetailId: json["sessionDetailId"],
        userId: json["userId"],
        userName: json["userName"],
        itemId: json["itemId"],
        itemName: json["itemName"],
        sessionId: json["sessionId"],
        sessionName: json["sessionName"],
        price: json["price"]?.toDouble(),
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "sessionDetailId": sessionDetailId,
        "userId": userId,
        "userName": userName,
        "itemId": itemId,
        "itemName": itemName,
        "sessionId": sessionId,
        "sessionName": sessionName,
        "price": price,
        "createDate": createDate?.toIso8601String(),
        "status": status,
      };
}
