import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swiminit/SPM/Person.dart';
import 'search_dateRange.dart';
import 'search_membershipID.dart';
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
  Person p = Person("name", "profileImg", "rollno", "enteredAt", "noOfVisits", "dues", "receiptID", "amtPaid", "datePaid", "role", "mailID", "contact1", "contact2");

  Future getSwimmer() async {
    var response = await http.get(Uri.parse('https://swiminit.herokuapp.com/getdetails?membershipID=$membershipID&admin=False'));
    var data = json.decode(response.body);
    p.name = data["name"];
    p.rollno = data["membershipID"];
    p.dues = data["dues"].toString();
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
//
// // class SearchPage extends StatelessWidget {
// //
// //   final TextEditingController _membIDController = TextEditingController();
// //
// //   SearchPage({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: SizedBox(
// //           width: 350,
// //           child: TextField(
// //             autocorrect: false,
// //             cursorColor: Color(0xFF14839F),
// //             controller: _membIDController,
// //             keyboardType: TextInputType.emailAddress,
// //             decoration: const InputDecoration(
// //                 hintText: "Membership ID",
// //                 prefixIcon: Icon(Icons.person, color: Color(0xFF14839F)),
// //               ),
// //           )
// //       )
// //     );
// //   }
// // }
