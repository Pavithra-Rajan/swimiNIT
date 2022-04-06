class GetDateVisitsSpm {
  GetDateVisitsSpm({
    required this.visits,
  });

  List<Visit> visits;

  factory GetDateVisitsSpm.fromJson(Map<String, dynamic> json) => GetDateVisitsSpm(
    visits: List<Visit>.from(json["visits"].map((x) => Visit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "visits": List<dynamic>.from(visits.map((x) => x.toJson())),
  };
}

class Visit {
  Visit({
    required  this.dateOfVisit,
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
