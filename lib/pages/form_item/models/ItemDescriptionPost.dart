// To parse this JSON data, do
//
//     final itemDescriptionPost = itemDescriptionPostFromJson(jsonString);

import 'dart:convert';

ItemDescriptionPost itemDescriptionPostFromJson(String str) =>
    ItemDescriptionPost.fromJson(json.decode(str));

String itemDescriptionPostToJson(ItemDescriptionPost data) =>
    json.encode(data.toJson());

class ItemDescriptionPost {
  String descriptionId;
  String detail;

  ItemDescriptionPost({
    required this.descriptionId,
    required this.detail,
  });

  factory ItemDescriptionPost.fromJson(Map<String, dynamic> json) =>
      ItemDescriptionPost(
        descriptionId: json["descriptionId"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "descriptionId": descriptionId,
        "detail": detail,
      };
}
