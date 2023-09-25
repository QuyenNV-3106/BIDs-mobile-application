// To parse this JSON data, do
//
//     final bidderModel = bidderModelFromJson(jsonString);

import 'dart:convert';

BidderModel bidderModelFromJson(String str) =>
    BidderModel.fromJson(json.decode(str));

String bidderModelToJson(BidderModel data) => json.encode(data.toJson());

class BidderModel {
  String userId;
  String sessionId;

  BidderModel({
    required this.userId,
    required this.sessionId,
  });

  factory BidderModel.fromJson(Map<String, dynamic> json) => BidderModel(
        userId: json["userId"],
        sessionId: json["sessionId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "sessionId": sessionId,
      };
}
