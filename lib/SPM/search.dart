import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swiminit/SPM/Person.dart';
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
  Person p = Person("name", "profileImg", "rollno", "enteredAt", "noOfVisits", "dues", "receiptID", "amtPaid", "datePaid", "role", "mailID", "contact1", "contact2")

  Future getSwimmer() async {
    var response = await http.get(Uri.parse(
        'https://swiminit.herokuapp.com/getdetails?membershipID=$membershipID&admin=False'));
    var data = json.decode(response.body);
    p.name = data["name"];
    p.rollno = data["membershipID"];
    p.dues = data["dues"].toString();
    p.role = data["roles"];
    p.mailID = data["emailID"];

    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 350,
            child: TextField(
              autocorrect: false,
              cursorColor: Color(0xFF14839F),
              controller: _membIDController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Membership ID",
                prefixIcon: Icon(Icons.person, color: Color(0xFF14839F)),
              ),
            )
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.08,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF14839F), //background color of button
                //border width and color
                elevation: 0, //elevation of button
                shape: RoundedRectangleBorder(
                  //to set border radius to button
                    borderRadius: BorderRadius.circular(0)),
                //content padding inside button
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () => {

              },
            ),
          )
      ),
    );
  }
}
