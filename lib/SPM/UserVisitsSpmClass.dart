// To parse this JSON data, do
//
//     final userVisitsSpm = userVisitsSpmFromJson(jsonString);

import 'dart:convert';

// UserVisitsSpm userVisitsSpmFromJson(String str) => UserVisitsSpm.fromJson(json.decode(str));
//
// String userVisitsSpmToJson(UserVisitsSpm data) => json.encode(data.toJson());

class UserVisitsSpm {
  UserVisitsSpm({
    required this.membershipId,
    required this.visits,
  });

  String membershipId;
  List<Visit> visits;

  factory UserVisitsSpm.fromJson(Map<String, dynamic> json) => UserVisitsSpm(
    membershipId: json["membershipID"],
    visits: List<Visit>.from(json["visits"].map((x) => Visit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "membershipID": membershipId,
    "visits": List<dynamic>.from(visits.map((x) => x.toJson())),
  };
}

class Visit {
  Visit({
    required this.dateOfVisit,
    required this.endTime,
    required this.membershipId,
  });

  String dateOfVisit;
  String endTime;
  String membershipId;

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
    dateOfVisit: json["dateOfVisit"],
    endTime: json["endTime"],
    membershipId: json["membershipID"],
  );

  Map<String, dynamic> toJson() => {
    "dateOfVisit": dateOfVisit,
    "endTime": endTime,
    "membershipID": membershipId,
  };
}
