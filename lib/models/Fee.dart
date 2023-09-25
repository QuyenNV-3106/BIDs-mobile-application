// To parse this JSON data, do
//
//     final fee = feeFromJson(jsonString);

import 'dart:convert';

Fee feeFromJson(String str) => Fee.fromJson(json.decode(str));

String feeToJson(Fee data) => json.encode(data.toJson());

List<Fee> feesFromJson(String str) =>
    List<Fee>.from(json.decode(str).map((x) => feeFromJson(str)));

class Fee {
  int? feeId;
  String? feeName;
  double? min;
  double? max;
  double? participationFee;
  double? depositFee;
  double? surcharge;
  bool? status;

  Fee({
    this.feeId,
    this.feeName,
    this.min,
    this.max,
    this.participationFee,
    this.depositFee,
    this.surcharge,
    this.status,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        feeId: json["feeId"],
        feeName: json["feeName"],
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
        participationFee: json["participationFee"]?.toDouble(),
        depositFee: json["depositFee"]?.toDouble(),
        surcharge: json["surcharge"]?.toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "feeId": feeId,
        "feeName": feeName,
        "min": min,
        "max": max,
        "participationFee": participationFee,
        "depositFee": depositFee,
        "surcharge": surcharge,
        "status": status,
      };
}
