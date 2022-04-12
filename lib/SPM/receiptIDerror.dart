// To parse this JSON data, do
//
//     final receipIDreport = receipIDreportFromJson(jsonString);

import 'dart:convert';



class ReceipIDreport {
  ReceipIDreport({
    required this.error,
  });

  String error;

  factory ReceipIDreport.fromJson(Map<String, dynamic> json) => ReceipIDreport(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
