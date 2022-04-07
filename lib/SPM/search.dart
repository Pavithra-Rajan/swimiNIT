import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swiminit/SPM/person.dart';
import 'search_date_range.dart';
import 'search_membership_id.dart';
import 'edit_receipt_details.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>
{
  final TextEditingController _membIDController = TextEditingController();
  currState state = currState.searching;
  String membershipID = "-1";
  Person p = Person("name", "profileImg", "rollno", "enteredAt", 0, 0, "receiptID", "amtPaid", "datePaid", "role", "mailID", "contact1", "contact2");

  Future getSwimmer() async {
    var response = await http.get(Uri.parse('https://swiminit.herokuapp.com/getdetails?membershipID=$membershipID&admin=False'));
    var data = json.decode(response.body);
    p.name = data["name"];
    p.rollno = data["membershipID"];
    p.dues = data["dues"];
    p.role = data["roles"];
    p.mailID = data["emailID"];
    return p;
  }

  bool showMembership = true;
  void toggleswitch(){
    setState(()=>
    showMembership=!showMembership
    );
  }
  @override
  Widget build(BuildContext context) {
    if(showMembership)
    {
      return MembershipIdSearch1(toggleswitch: toggleswitch,showMembership: showMembership);
    }
    else{
      return Daterange2(toggleswitch: toggleswitch,showMembership: showMembership);
    }
  }
}
