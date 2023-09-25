import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/SessionDetail.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BidderService {
  Future<http.Response> increasePrice(String sessionId, String userID) async {
    final uri = Uri.parse('$apiUrl$apiBidding');
    final resp = await http.post(uri,
        headers: {
          "content-type": "application/json; charset=utf-8",
          'Authorization': 'bearer ${TokenManager.getToken()}'
        },
        body: jsonEncode({"userId": userID, "sessionId": sessionId}));
    return resp;
  }

  Future<http.Response> getJoinning(String sessionId, String userID) async {
    final uri = Uri.parse("$apiUrl$apiJoinning");
    final resp = await http.post(uri,
        headers: {
          "content-type": "application/json; charset=utf-8",
          'Authorization': 'Bearer ${TokenManager.getToken()}'
        },
        body: jsonEncode({"userId": userID, "sessionId": sessionId}));

    return resp;
  }

  Future<http.Response> getJoinningInstage(
      String sessionId, String userID) async {
    final uri = Uri.parse("$apiUrl$apiJoinningInStage");
    final resp = await http.post(uri,
        headers: {
          "content-type": "application/json; charset=utf-8",
          'Authorization': 'Bearer ${TokenManager.getToken()}'
        },
        body: jsonEncode({"userId": userID, "sessionId": sessionId}));

    return resp;
  }
}
