// To parse this JSON data, do
//
//     final swimmerDetailsSpm = swimmerDetailsSpmFromJson(jsonString);

import 'dart:convert';

// SwimmerDetailsSpm swimmerDetailsSpmFromJson(String str) => SwimmerDetailsSpm.fromJson(json.decode(str));
//
// String swimmerDetailsSpmToJson(SwimmerDetailsSpm data) => json.encode(data.toJson());

class SwimmerDetailsSpm {
  SwimmerDetailsSpm({
    required this.dues,
    required  this.emailId,
    required  this.fees,
    required this.membershipId,
    required  this.name,
    required this.roles,
  });

  int dues;
  String emailId;
  int fees;
  String membershipId;
  String name;
  String roles;

  factory SwimmerDetailsSpm.fromJson(Map<String, dynamic> json) => SwimmerDetailsSpm(
    dues: json["dues"],
    emailId: json["emailID"],
    fees: json["fees"],
    membershipId: json["membershipID"],
    name: json["name"],
    roles: json["roles"],
  );


}
