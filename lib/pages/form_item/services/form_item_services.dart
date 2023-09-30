import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/CategoryItem.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:bid_online_app_v2/pages/form_item/models/FormItem.dart';
import 'package:bid_online_app_v2/pages/form_item/models/ItemDescriptionPost.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormItemService {
  Future<List<CategoryItem>> getAllCategories() async {
    final uri = Uri.parse(apiUrl + apiGetCategories);
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => CategoryItem.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => CategoryItem.fromJson(e)).toList();
    }
  }

  Future<http.Response> createItem(FormItem formItem) async {
    final uri = Uri.parse(apiUrl + apiGetItem);
    final resp = await http.post(uri,
        headers: <String, String>{
          'Authorization': 'Bearer ${TokenManager.getToken()}',
          "content-type": "application/json; charset=utf-8",
        },
        body: formItemToJson(formItem));
    return resp;
  }

  Future<void> createImages(String imgUrl, String itemID) async {
    final uri = Uri.parse(apiUrl + apiItemImages);
    await http.post(uri,
        headers: <String, String>{
          'Authorization': 'Bearer ${TokenManager.getToken()}',
          "content-type": "application/json; charset=utf-8",
        },
        body: jsonEncode({"itemId": itemID, "detailImage": imgUrl}));
  }

  Future<void> createDescriptions(
      String descriptionId, String detail, String itemId) async {
    final uri = Uri.parse(apiUrl + apiItemDescriptions);
    // http.Response resp = http.Response('Có lỗi xảy ra\nXin hãy thử lại', 404);

    await http.post(uri,
        headers: <String, String>{
          'Authorization': 'Bearer ${TokenManager.getToken()}',
          "content-type": "application/json; charset=utf-8",
        },
        body: jsonEncode({
          "itemId": itemId,
          "descriptionId": descriptionId,
          "detail": detail
        }));

    // return resp;
  }
}
