// To parse this JSON data, do
//
//     final liveSwimmers = liveSwimmersFromJson(jsonString);



class LiveSwimmers {
  LiveSwimmers({
    required this.visits,
  });

  List<Visits> visits;

  factory LiveSwimmers.fromJson(Map<String, dynamic> json) => LiveSwimmers(
    visits: List<Visits>.from(json["visits:"].map((x) => Visits.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "visits:": List<dynamic>.from(visits.map((x) => x.toJson())),
  };
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

  Map<String, dynamic> toJson() => {
    "swimmer": swimmer.toJson(),
    "visit": visit.toJson(),
  };
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
  dynamic numberOfFreeTrials;
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

  Map<String, dynamic> toJson() => {
    "contact1": contact1,
    "contact2": contact2,
    "dues": dues,
    "emailID": emailId,
    "fees": fees,
    "membershipID": membershipId,
    "name": name,
    "numberOfFreeTrials": numberOfFreeTrials,
    "role": role,
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
