import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  String? userId;
  String? userName;
  String? email;
  String? role;
  String? avatar;
  String? password;
  String? address;
  String? phone;
  DateTime? dateOfBirth;
  String? cccdNumber;
  String? cccdFrontImage;
  String? cccdBackImage;
  DateTime? createDate;
  DateTime? updateDate;
  String? status;
  List<PayPalAccount>? payPalAccount;
  static String? emailSt;
  static String? avatarSt;
  static String? backCCCDSt;
  static String? frontCCCDSt;
  static String? userIdSt;
  static UserProfile? user;

  UserProfile({
    this.payPalAccount,
    this.userId,
    this.userName,
    this.email,
    this.role,
    this.avatar,
    this.password,
    this.address,
    this.phone,
    this.dateOfBirth,
    this.cccdNumber,
    this.cccdFrontImage,
    this.cccdBackImage,
    this.createDate,
    this.updateDate,
    this.status,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["userId"],
        payPalAccount: json["payPalAccount"] == null
            ? []
            : List<PayPalAccount>.from(
                json["payPalAccount"]!.map((x) => PayPalAccount.fromJson(x))),
        userName: json["userName"],
        email: json["email"],
        role: json["role"],
        avatar: json["avatar"],
        password: json["password"],
        address: json["address"],
        phone: json["phone"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        cccdNumber: json["cccdNumber"],
        cccdFrontImage: json["cccdFrontImage"],
        cccdBackImage: json["cccdBackImage"],
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
        "payPalAccount": payPalAccount == null
            ? []
            : List<dynamic>.from(payPalAccount!.map((x) => x.toJson())),
        "userName": userName,
        "email": email,
        "role": role,
        "avatar": avatar,
        "password": password,
        "address": address,
        "phone": phone,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "cccdNumber": cccdNumber,
        "cccdFrontImage": cccdFrontImage,
        "cccdBackImage": cccdBackImage,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "status": status,
      };
}

class PayPalAccount {
  String? payPalAccount;

  PayPalAccount({
    this.payPalAccount,
  });

  factory PayPalAccount.fromJson(Map<String, dynamic> json) => PayPalAccount(
        payPalAccount: json["payPalAccount"],
      );

  Map<String, dynamic> toJson() => {
        "payPalAccount": payPalAccount,
      };
}
