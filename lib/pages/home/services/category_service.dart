import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Category.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryService {
  Future<List<CategoryProduct>> getAllCategories() async {
    final uri = Uri.parse(apiUrl + apiGetCategories);
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => CategoryProduct.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => CategoryProduct.fromJson(e)).toList();
    }
  }
}
