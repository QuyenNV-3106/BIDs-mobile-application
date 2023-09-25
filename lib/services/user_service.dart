import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/models/UserSignUp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  Future<UserProfile> getUser(String email) async {
    final uri = Uri.parse("$apiUrl$apiUserProfile?email=$email");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      UserProfile.avatarSt = userProfileFromJson(resp.body).avatar;
      UserProfile.frontCCCDSt = userProfileFromJson(resp.body).cccdFrontImage;
      UserProfile.backCCCDSt = userProfileFromJson(resp.body).cccdBackImage;
      UserProfile.userIdSt = userProfileFromJson(resp.body).userId;
      UserProfile.user = userProfileFromJson(resp.body);

      return userProfileFromJson(resp.body);
      // return User.fromJson(jsonDecode(resp.body));
    } else {
      return userProfileFromJson(resp.body);
      // return User.fromJson(jsonDecode(resp.body));
    }
  }

  Future<http.Response> resetPassword(String email) async {
    final uri = Uri.parse("$apiUrl$apiResetPassword/$email?email=$email");
    final resp = await http.put(
      uri,
    );
    if (resp.statusCode == 200) {
      return resp;
    } else {
      return resp;
    }
  }

  Future<http.Response> confirmEmail(String email) async {
    final uri = Uri.parse("$apiUrl$apiConfirmEmailUser$email");
    final resp = await http.put(uri);

    return resp;
  }

  Future<http.Response> updateRoleUser(String email, String code) async {
    final uri = Uri.parse("$apiUrl$apiUpdateRoleUser");
    final resp = await http.put(uri,
        headers: <String, String>{
          "content-type": "application/json; charset=utf-8",
        },
        body: jsonEncode({"email": email, "code": code}));

    return resp;
  }

  Future<http.Response> signUpAccount(UserSignUp user) async {
    final uri = Uri.parse(apiUrl + apiPostAccount);
    final resp = await http.post(uri,
        headers: <String, String>{
          "content-type": "application/json; charset=utf-8",
        },
        body: userSignUpToJson(user));
    if (resp.statusCode == 200) {
      return resp;
    } else {
      return resp;
    }
  }

  Future<http.Response> updateAccount(UserProfile user) async {
    final uri = Uri.parse(apiUrl + apiPutAccount);
    final resp = await http.put(uri,
        headers: <String, String>{
          "content-type": "application/json; charset=utf-8",
          'Authorization': 'Bearer ${TokenManager.getToken()}'
        },
        body: userProfileToJson(user));
    if (resp.statusCode == 200) {
      UserProfile.user = user;
      return resp;
    } else {
      return resp;
    }
  }
}
