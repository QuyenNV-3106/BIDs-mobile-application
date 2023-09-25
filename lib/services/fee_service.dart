import 'dart:convert';

import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Fee.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:http/http.dart' as http;

class FeeService {
  Future<List<Fee>> getFee() async {
    final uri = Uri.parse("$apiUrl$apiFee");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Fee.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Fee.fromJson(e)).toList();
      // return User.fromJson(jsonDecode(resp.body));
    }
  }
}
