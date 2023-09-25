// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  bool? successful;
  String? error;
  String? token;

  Token({
    this.successful,
    this.error,
    this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        successful: json["successful"],
        error: json["error"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "successful": successful,
        "error": error,
        "token": token,
      };
}
