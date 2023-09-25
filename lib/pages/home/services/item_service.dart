import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Item.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemService {
  Future<List<Item>> getItem() async {
    final uri = Uri.parse('$apiUrl$apiGetItem');
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Item.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => Item.fromJson(e)).toList();
    }
  }
}
