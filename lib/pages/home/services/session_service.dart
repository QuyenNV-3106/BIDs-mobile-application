import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Category.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SessionService {
  Future<List<Session>> getAllSessions() async {
    final uri = Uri.parse(apiUrl + apiGetSessions);
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Session.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Session.fromJson(e)).toList();
    }
  }

  Future<List<Session>> getAllSessionsNotStart() async {
    final uri = Uri.parse(apiUrl + apiGetSessionsNotStart);
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Session.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Session.fromJson(e)).toList();
    }
  }

  Future<List<Session>> getAllSessionsInStage() async {
    final uri = Uri.parse(apiUrl + apiGetSessionsInStage);
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Session.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Session.fromJson(e)).toList();
    }
  }
}
