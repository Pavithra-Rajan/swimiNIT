// To parse this JSON data, do
//
//     final exitSwimmers = exitSwimmersFromJson(jsonString);


// ExitSwimmers exitSwimmersFromJson(String str) => ExitSwimmers.fromJson(json.decode(str));
//
// String exitSwimmersToJson(ExitSwimmers data) => json.encode(data.toJson());

class ExitSwimmers {
  ExitSwimmers({
    required this.dateOfVisit,
    required this.endTime,
    required this.membershipId,
  });

  String dateOfVisit;
  String endTime;
  String membershipId;

  factory ExitSwimmers.fromJson(Map<String, dynamic> json) => ExitSwimmers(
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
