import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionHaveNotPay.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryService {
  Future<List<SessionHaveNotPay>> getAllSessionsHaveNotPay(String uid) async {
    final uri = Uri.parse(apiUrl + apiGetSessionsHaveNotPay + uid);
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
      // headers: {'Authorization': 'Bearer $token'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    }
  }

  Future<List<SessionHaveNotPay>> getSessionCompleteByUser(String uid) async {
    final uri = Uri.parse("$apiUrl$apiSessionCompleteByUser$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
      // headers: {'Authorization': 'Bearer $token'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    }
  }

  Future<List<SessionHaveNotPay>> getSessionComplete(String uid) async {
    final uri = Uri.parse("$apiUrl$apiSessionSuccess$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
      // headers: {'Authorization': 'Bearer $token'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    }
  }

  Future<List<SessionHaveNotPay>> getSessionFailByUser(String uid) async {
    final uri = Uri.parse("$apiUrl$apiSessionFailByUser$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
      // headers: {'Authorization': 'Bearer $token'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    }
  }

  Future<List<SessionHaveNotPay>> getSessionInstageByUser(String uid) async {
    final uri = Uri.parse("$apiUrl$apiSessionInStageByUser$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
      // headers: {'Authorization': 'Bearer $token'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    }
  }

  Future<List<SessionHaveNotPay>> getSessionReceivedByUser(String uid) async {
    final uri = Uri.parse("$apiUrl$apiSessionReceivedByUser$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
      // headers: {'Authorization': 'Bearer $token'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    }
  }

  Future<List<SessionHaveNotPay>> getSessionErrorByUser(String uid) async {
    final uri = Uri.parse("$apiUrl$apiSessionErrorByUser$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
      // headers: {'Authorization': 'Bearer $token'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionHaveNotPay.fromJson(e)).toList();
    }
  }

  Future<http.Response> changeReceivedStatus(String sessionID) async {
    final uri = Uri.parse("$apiUrl$apiGetSessionsReceived");
    final resp = await http.put(uri,
        headers: {
          "content-type": "application/json; charset=utf-8",
          'Authorization': 'Bearer ${TokenManager.getToken()}'
        },
        body: jsonEncode({"sessionID": sessionID}));

    return resp;
  }

  Future<http.Response> changeErrorStatus(
      String sessionID, String reason) async {
    final uri = Uri.parse("$apiUrl$apiGetSessionsError$reason");
    final resp = await http.put(uri,
        headers: {
          "content-type": "application/json; charset=utf-8",
          'Authorization': 'Bearer ${TokenManager.getToken()}'
        },
        body: jsonEncode({"sessionID": sessionID}));

    return resp;
  }
}
