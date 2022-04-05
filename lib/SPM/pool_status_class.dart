// To parse this JSON data, do
//
//     final liveSwimmers = liveSwimmersFromJson(jsonString);

import 'dart:convert';


class LiveSwimmers {
  LiveSwimmers({
    required this.visits,
  });

  List<Visits> visits;

  factory LiveSwimmers.fromJson(Map<String, dynamic> json) => LiveSwimmers(
    visits: List<Visits>.from(json["visits:"].map((x) => Visits.fromJson(x))),
  );


}

class Visits {
  Visits({
    required this.swimmer,
    required this.visit,
  });

  Swimmer swimmer;
  Visit visit;

  factory Visits.fromJson(Map<String, dynamic> json) => Visits(
    swimmer: Swimmer.fromJson(json["swimmer"]),
    visit: Visit.fromJson(json["visit"]),
  );


}

class Swimmer {
  Swimmer({
    required this.contact1,
    required this.contact2,
    required this.dues,
    required this.emailId,
    required this.fees,
    required this.membershipId,
    required this.name,
    required this.numberOfFreeTrials,
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
  String role;

  factory Swimmer.fromJson(Map<String, dynamic> json) => Swimmer(
    contact1: json["contact1"],
    contact2: json["contact2"],
    dues: json["dues"],
    emailId: json["emailID"],
    fees: json["fees"],
    membershipId: json["membershipID"],
    name: json["name"],
    numberOfFreeTrials: json["numberOfFreeTrials"],
    role: json["role"],
  );


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



}





