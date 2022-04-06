import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Person.dart';
import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/entryAlerts/DuesAlertBox.dart';
import 'package:swiminit/SPM/entryAlerts/FreeTrialsAlertBox.dart';
import 'package:intl/intl.dart'; // for date format


class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EntryPageState();
  }
}

class EntryPageState extends State<EntryPage> {
  String membershipID = "-1";

  final TextEditingController _membIDController = TextEditingController();

  Person p = Person(
      "name",
      "lib/Resources/pic-1.png",
      "rollno",
      "enteredAt",
      "noOfVisits",
      "1",
      "receiptID",
      "amtPaid",
      "datePaid",
      "Student",
      "mailID",
      "contact1",
      "contact2");

  Future getSwimmer() async {
    var response = await http.get(Uri.parse(
        'https://swiminit.herokuapp.com/getdetails?membershipID=$membershipID&admin=False'));
    var data = json.decode(response.body);
    p.dues = data["dues"].toString();
    p.mailID = data["emailID"];
    p.rollno = data["membershipID"];
    p.name = data["name"];
    p.role = data["roles"];
    return p;
  }

  Future swimmerEntry() async {
    await http.post(
      Uri.parse('https://swiminit.herokuapp.com/entry'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'membershipID': p.rollno,
        'dateOfVisit': DateFormat('dd-MM-yyyy;hh:mm:ss').format(DateTime.now())
      }),
    );
  }

  Widget detailsWidget(Person p) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: FutureBuilder(
          future: getSwimmer(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Membership ID",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.rollno,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Name",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.name,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Role",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.role,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Email ID",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.mailID,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Payment made",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        int.parse(p.dues) == 0 ? "No" : "Yes",
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ]);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (membershipID == "-1") {
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
            )
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
                'Search',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () => {
                setState(() {
                  membershipID = _membIDController.text;
                  _membIDController.clear();
                })
              },
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
    } else if (membershipID == "-2") {
      if (p.dues != "0") {
        return DuesAlertBox();
      }
      if (p.noOfVisits == "5" && p.role == "Student") {
        return FreeTrialsAlertBox();
      }
      return Scaffold(
        body: Center(
          //child: Image.asset("lib/Resources/entry_recorded.png"),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Icon(Icons.check,
              color: Color(0xFF149F88),),
              Text(' Swimmer\'s entry has been recorded',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF149F88), fontSize: 18)),
            ],
          )
          // child: Text("Swimmers entry has been recorded",
          //   style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF149F88), fontSize: 18),),

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
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => {
                  setState(() {
                    membershipID = "-1";
                  })
                },
              ),
            )),
      );
    } else {
      return Scaffold(
        body: Column(children: [
          SizedBox(
            height: 10,
          ),
          detailsWidget(p)
        ]),
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
                  'Allow Entry',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => {
                  setState(() {
                    swimmerEntry();
                    membershipID = "-2";
                  }),
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DuesAlertBox())),
                },
              ),
            )
        ),
      );
    }
  }
}
