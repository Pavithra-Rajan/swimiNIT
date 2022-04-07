// To parse this JSON data, do
//
//     final checkClass = checkClassFromJson(jsonString);

import 'dart:convert';



class CheckClass {
  CheckClass({
    required this.error,
  });

  String error;

  factory CheckClass.fromJson(Map<String, dynamic> json) => CheckClass(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
