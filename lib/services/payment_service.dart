import 'dart:convert';

import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<http.Response> paymentRegister(String sessionId, String payerId,
      String urlSuccess, String urlFail) async {
    final uri = Uri.parse(
        "$apiUrl$apiPaymentToRegister?sessionId=$sessionId&payerId=$payerId&urlSuccess=$urlSuccess&urlFail=$urlFail");
    final resp = await http.post(
      uri,
      headers: <String, String>{
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${TokenManager.getToken()}'
      },
    );

    return resp;
  }

  Future<http.Response> paymentComplete(String sessionId, String payerId,
      String urlSuccess, String urlFail) async {
    final uri = Uri.parse(
        "$apiUrl$apiPaymentComplete?sessionId=$sessionId&payerId=$payerId&urlSuccess=$urlSuccess&urlFail=$urlFail");
    final resp = await http.post(
      uri,
      headers: <String, String>{
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${TokenManager.getToken()}'
      },
    );

    return resp;
  }

  Future<http.Response> rejectPayment(String sessionId) async {
    final uri = Uri.parse("$apiUrl$apiRejectPayment");
    final resp = await http.put(
      uri,
      headers: <String, String>{
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${TokenManager.getToken()}'
      },
      body: jsonEncode({"sessionID": sessionId}),
    );

    return resp;
  }

  Future<http.Response> paymentChecking(
    String payerId,
  ) async {
    final uri =
        Uri.parse("$apiUrl$apiGetSessionsCheckAndUpdateOrder?userId=$payerId");
    final resp = await http.put(
      uri,
      headers: <String, String>{
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${TokenManager.getToken()}'
      },
    );

    return resp;
  }
}
