import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/models/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenProvider {
  Future<Token> getToken(String email, String password) async {
    Token tmp = Token(error: null, successful: false, token: "");
    try {
      final uri = Uri.parse(apiUrl + apiLogin);
      final resp = await http.post(uri,
          headers: <String, String>{
            "content-type": "application/json; charset=utf-8",
          },
          body: jsonEncode({"email": email, "password": password}));
      if (resp.statusCode == 200) {
        TokenManager.setToken(tokenFromJson(resp.body).token!);
        UserProfile.emailSt = email;
        return tokenFromJson(resp.body);
      } else {
        return tokenFromJson(resp.body);
      }
    } catch (e) {
      print("Login ERR: $e");
    }
    return tmp;
  }
}
