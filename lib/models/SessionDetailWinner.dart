// To parse this JSON data, do
//
//     final sessionDetailWinner = sessionDetailWinnerFromJson(jsonString);

import 'dart:convert';

SessionDetailWinner sessionDetailWinnerFromJson(String str) =>
    SessionDetailWinner.fromJson(json.decode(str));

String sessionDetailWinnerToJson(SessionDetailWinner data) =>
    json.encode(data.toJson());

class SessionDetailWinner {
  String? userId;
  String? role;
  String? userName;
  String? password;
  String? email;
  String? avatar;
  String? address;
  String? phone;
  List<dynamic>? payPalAccount;
  DateTime? dateOfBirth;
  String? cccdnumber;
  String? cccdfrontImage;
  String? cccdbackImage;
  DateTime? createDate;
  DateTime? updateDate;
  String? status;

  SessionDetailWinner({
    this.userId,
    this.role,
    this.userName,
    this.password,
    this.email,
    this.avatar,
    this.address,
    this.phone,
    this.payPalAccount,
    this.dateOfBirth,
    this.cccdnumber,
    this.cccdfrontImage,
    this.cccdbackImage,
    this.createDate,
    this.updateDate,
    this.status,
  });

  factory SessionDetailWinner.fromJson(Map<String, dynamic> json) =>
      SessionDetailWinner(
        userId: json["userId"],
        role: json["role"],
        userName: json["userName"],
        password: json["password"],
        email: json["email"],
        avatar: json["avatar"],
        address: json["address"],
        phone: json["phone"],
        payPalAccount: json["payPalAccount"] == null
            ? []
            : List<dynamic>.from(json["payPalAccount"]!.map((x) => x)),
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        cccdnumber: json["cccdnumber"],
        cccdfrontImage: json["cccdfrontImage"],
        cccdbackImage: json["cccdbackImage"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null
            ? null
            : DateTime.parse(json["updateDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "role": role,
        "userName": userName,
        "password": password,
        "email": email,
        "avatar": avatar,
        "address": address,
        "phone": phone,
        "payPalAccount": payPalAccount == null
            ? []
            : List<dynamic>.from(payPalAccount!.map((x) => x)),
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "cccdnumber": cccdnumber,
        "cccdfrontImage": cccdfrontImage,
        "cccdbackImage": cccdbackImage,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "status": status,
      };
}
