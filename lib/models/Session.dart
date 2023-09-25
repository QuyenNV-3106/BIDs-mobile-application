// // To parse this JSON data, do
// //
// //     final session = sessionFromJson(jsonString);

// import 'dart:convert';

// List<Session> sessionFromJson(String str) =>
//     List<Session>.from(json.decode(str).map((x) => Session.fromJson(x)));

// String sessionToJson(List<Session> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Session {
//   double? joinFee;
//   String sessionId;
//   int feeId;
//   String feeName;
//   String sessionName;
//   List<ImageItem> images;
//   String itemId;
//   String itemName;
//   String categoryName;
//   String description;
//   String freeTime;
//   String delayTime;
//   String delayFreeTime;
//   DateTime beginTime;
//   DateTime endTime;
//   double firstPrice;
//   double stepPrice;
//   double finalPrice;
//   DateTime createDate;
//   DateTime updateDate;
//   int status;

//   Session(
//       {required this.sessionId,
//       required this.feeId,
//       required this.feeName,
//       required this.sessionName,
//       required this.images,
//       required this.itemId,
//       required this.itemName,
//       required this.categoryName,
//       required this.description,
//       required this.freeTime,
//       required this.delayTime,
//       required this.delayFreeTime,
//       required this.beginTime,
//       required this.endTime,
//       required this.firstPrice,
//       required this.stepPrice,
//       required this.finalPrice,
//       required this.createDate,
//       required this.updateDate,
//       required this.status,
//       this.joinFee});

//   factory Session.fromJson(Map<String, dynamic> json) => Session(
//         sessionId: json["sessionId"],
//         feeId: json["feeId"],
//         feeName: json["feeName"],
//         sessionName: json["sessionName"],
//         images: List<ImageItem>.from(
//             json["images"].map((x) => ImageItem.fromJson(x))),
//         itemId: json["itemId"],
//         itemName: json["itemName"],
//         categoryName: json["categoryName"],
//         description: json["description"],
//         freeTime: json["freeTime"],
//         delayTime: json["delayTime"],
//         delayFreeTime: json["delayFreeTime"],
//         beginTime: DateTime.parse(json["beginTime"]),
//         endTime: DateTime.parse(json["endTime"]),
//         firstPrice: json["firstPrice"],
//         stepPrice: json["stepPrice"],
//         finalPrice: json["finalPrice"],
//         createDate: DateTime.parse(json["createDate"]),
//         updateDate: DateTime.parse(json["updateDate"]),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "sessionId": sessionId,
//         "feeId": feeId,
//         "feeName": feeName,
//         "sessionName": sessionName,
//         "images": List<dynamic>.from(images.map((x) => x.toJson())),
//         "itemId": itemId,
//         "itemName": itemName,
//         "categoryName": categoryName,
//         "description": description,
//         "freeTime": freeTime,
//         "delayTime": delayTime,
//         "delayFreeTime": delayFreeTime,
//         "beginTime": beginTime.toIso8601String(),
//         "endTime": endTime.toIso8601String(),
//         "firstPrice": firstPrice,
//         "stepPrice": stepPrice,
//         "finalPrice": finalPrice,
//         "createDate": createDate.toIso8601String(),
//         "updateDate": updateDate.toIso8601String(),
//         "status": status,
//       };
// }

// class ImageItem {
//   String detail;

//   ImageItem({
//     required this.detail,
//   });

//   factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
//         detail: json["detail"],
//       );

//   Map<String, dynamic> toJson() => {
//         "detail": detail,
//       };
// }

// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);
// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'dart:convert';

List<Session> sessionFromJson(String str) =>
    List<Session>.from(json.decode(str).map((x) => Session.fromJson(x)));

String sessionToJson(List<Session> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Session {
  double? joinFee;
  String sessionId;
  int feeId;
  String feeName;
  String sessionName;
  List<ImageItem> images;
  List<Description> descriptions;
  String itemId;
  String itemName;
  String categoryName;
  double participationFee;
  bool deposit;
  double depositFee;
  String description;
  String freeTime;
  String delayTime;
  String delayFreeTime;
  DateTime beginTime;
  DateTime endTime;
  double firstPrice;
  double stepPrice;
  double finalPrice;
  DateTime createDate;
  DateTime updateDate;
  int status;

  Session({
    this.joinFee,
    required this.sessionId,
    required this.feeId,
    required this.feeName,
    required this.sessionName,
    required this.images,
    required this.descriptions,
    required this.itemId,
    required this.itemName,
    required this.categoryName,
    required this.participationFee,
    required this.deposit,
    required this.depositFee,
    required this.description,
    required this.freeTime,
    required this.delayTime,
    required this.delayFreeTime,
    required this.beginTime,
    required this.endTime,
    required this.firstPrice,
    required this.stepPrice,
    required this.finalPrice,
    required this.createDate,
    required this.updateDate,
    required this.status,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        sessionId: json["sessionId"],
        feeId: json["feeId"],
        feeName: json["feeName"],
        sessionName: json["sessionName"],
        images: List<ImageItem>.from(
            json["images"].map((x) => ImageItem.fromJson(x))),
        descriptions: List<Description>.from(
            json["descriptions"].map((x) => Description.fromJson(x))),
        itemId: json["itemId"],
        itemName: json["itemName"],
        categoryName: json["categoryName"],
        participationFee: json["participationFee"]?.toDouble(),
        deposit: json["deposit"],
        depositFee: json["depositFee"]?.toDouble(),
        description: json["description"],
        freeTime: json["freeTime"],
        delayTime: json["delayTime"],
        delayFreeTime: json["delayFreeTime"],
        beginTime: DateTime.parse(json["beginTime"]),
        endTime: DateTime.parse(json["endTime"]),
        firstPrice: json["firstPrice"]?.toDouble(),
        stepPrice: json["stepPrice"]?.toDouble(),
        finalPrice: json["finalPrice"]?.toDouble(),
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "feeId": feeId,
        "feeName": feeName,
        "sessionName": sessionName,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "descriptions": List<dynamic>.from(descriptions.map((x) => x.toJson())),
        "itemId": itemId,
        "itemName": itemName,
        "categoryName": categoryName,
        "participationFee": participationFee,
        "deposit": deposit,
        "depositFee": depositFee,
        "description": description,
        "freeTime": freeTime,
        "delayTime": delayTime,
        "delayFreeTime": delayFreeTime,
        "beginTime": beginTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "firstPrice": firstPrice,
        "stepPrice": stepPrice,
        "finalPrice": finalPrice,
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
