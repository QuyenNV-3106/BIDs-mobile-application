import 'dart:convert';

import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:bid_online_app_v2/pages/personal_item/models/BookingItemWaitting.dart';
import 'package:http/http.dart' as http;

class PersonalItemService {
  Future<List<BookingItemWaitting>> getItemWaitting(String uid) async {
    final uri = Uri.parse("$apiUrl$apiBookingItemWaitting$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => BookingItemWaitting.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => BookingItemWaitting.fromJson(e)).toList();
    }
  }

  Future<List<BookingItemWaitting>> getItemWaittingCreateSession(
      String uid) async {
    final uri = Uri.parse("$apiUrl$apiBookingItemWaittingCreateSession$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => BookingItemWaitting.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => BookingItemWaitting.fromJson(e)).toList();
    }
  }

  Future<List<BookingItemWaitting>> getItemAccepted(String uid) async {
    final uri = Uri.parse("$apiUrl$apiBookingItemAccepted$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => BookingItemWaitting.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => BookingItemWaitting.fromJson(e)).toList();
    }
  }

  Future<List<BookingItemWaitting>> getItemDenied(String uid) async {
    final uri = Uri.parse("$apiUrl$apiBookingItemDenied$uid");
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${TokenManager.getToken()}'},
    );

    if (resp.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => BookingItemWaitting.fromJson(e)).toList();
    } else {
      final List<dynamic> responseData = jsonDecode(resp.body);
      return responseData.map((e) => BookingItemWaitting.fromJson(e)).toList();
    }
  }
}
