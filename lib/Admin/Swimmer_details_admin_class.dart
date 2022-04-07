// To parse this JSON data, do
//
//     final swimmerDetailsAdmin = swimmerDetailsAdminFromJson(jsonString);

import 'dart:convert';

SwimmerDetailsAdmin swimmerDetailsAdminFromJson(String str) =>
    SwimmerDetailsAdmin.fromJson(json.decode(str));

String swimmerDetailsAdminToJson(SwimmerDetailsAdmin data) =>
    json.encode(data.toJson());

class SwimmerDetailsAdmin {
  SwimmerDetailsAdmin({
    required this.contact1,
    required this.contact2,
    required this.dues,
    required this.emailId,
    required this.fees,
    required this.membershipId,
    required this.name,
    required this.numberOfFreeTrials,
    required this.numberOfVisits,
    required this.role,
  });

  String contact1;
  String contact2;
  int dues;
  String emailId;
  int fees;
  String membershipId;
  String name;
  int numberOfFreeTrials;
  int numberOfVisits;
  String role;

  factory SwimmerDetailsAdmin.fromJson(Map<String, dynamic> json) =>
      SwimmerDetailsAdmin(
        contact1: json["contact1"],
        contact2: json["contact2"],
        dues: json["dues"],
        emailId: json["emailID"],
        fees: json["fees"],
        membershipId: json["membershipID"],
        name: json["name"],
        numberOfFreeTrials: json["numberOfFreeTrials"],
        numberOfVisits: json["numberOfVisits"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "contact1": contact1,
        "contact2": contact2,
        "dues": dues,
        "emailID": emailId,
        "fees": fees,
        "membershipID": membershipId,
        "name": name,
        "numberOfFreeTrials": numberOfFreeTrials,
        "numberOfVisits": numberOfVisits,
        "role": role,
      };
}
