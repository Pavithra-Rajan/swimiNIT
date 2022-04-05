class SPM
{
  String contact1;
  String contact2;
  String name;
  String password;

  SPM(this.contact1, this.contact2, this.name, this.password);

  factory SPM.fromJson(Map<String, dynamic> json) => SPM(json["contact1"], json["contact2"], json["name"], json["password"]);
}