// To parse this JSON data, do
//
//     final userSignUp = userSignUpFromJson(jsonString);

import 'dart:convert';

UserSignUp userSignUpFromJson(String str) =>
    UserSignUp.fromJson(json.decode(str));

String userSignUpToJson(UserSignUp data) => json.encode(data.toJson());

class UserSignUp {
  String userName;
  String email;
  String avatar;
  String password;
  String address;
  String phone;
  DateTime dateOfBirth;
  String cccdnumber;
  String cccdfrontImage;
  String cccdbackImage;

  UserSignUp({
    required this.userName,
    required this.email,
    required this.avatar,
    required this.password,
    required this.address,
    required this.phone,
    required this.dateOfBirth,
    required this.cccdnumber,
    required this.cccdfrontImage,
    required this.cccdbackImage,
  });

  factory UserSignUp.fromJson(Map<String, dynamic> json) => UserSignUp(
        userName: json["userName"],
        email: json["email"],
        avatar: json["avatar"],
        password: json["password"],
        address: json["address"],
        phone: json["phone"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        cccdnumber: json["cccdnumber"],
        cccdfrontImage: json["cccdfrontImage"],
        cccdbackImage: json["cccdbackImage"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "avatar": avatar,
        "password": password,
        "address": address,
        "phone": phone,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "cccdnumber": cccdnumber,
        "cccdfrontImage": cccdfrontImage,
        "cccdbackImage": cccdbackImage,
      };
}
