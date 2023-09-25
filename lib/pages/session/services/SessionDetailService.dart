import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/SessionDetail.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SessionDetailService {
  Future<List<SessionDetail>?> getSessionDetailHistory(String id) async {
    final uri = Uri.parse('$apiUrl$apiGetSessionDetail?id=$id');
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => SessionDetail.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
