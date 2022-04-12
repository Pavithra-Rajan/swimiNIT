// To parse this JSON data, do
//
//     final swimmerDetailsSpm = swimmerDetailsSpmFromJson(jsonString);



class SwimmerDetailsSpm {
  SwimmerDetailsSpm({
    required this.dues,
    required this.emailId,
    required this.fees,
    required this.membershipId,
    required this.name,
    required this.numberOfVisits,
    required this.roles,
  });

  int dues;
  String emailId;
  int fees;
  String membershipId;
  String name;
  int numberOfVisits;
  String roles;

  factory SwimmerDetailsSpm.fromJson(Map<String, dynamic> json) => SwimmerDetailsSpm(
    dues: json["dues"],
    emailId: json["emailID"],
    fees: json["fees"],
    membershipId: json["membershipID"],
    name: json["name"],
    numberOfVisits: json["numberOfVisits"],
    roles: json["roles"],
  );

  Map<String, dynamic> toJson() => {
    "dues": dues,
    "emailID": emailId,
    "fees": fees,
    "membershipID": membershipId,
    "name": name,
    "numberOfVisits": numberOfVisits,
    "roles": roles,
  };
}
