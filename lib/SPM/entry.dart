import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'person.dart';
import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/entryAlerts/DuesAlertBox.dart';
import 'package:swiminit/SPM/entryAlerts/FreeTrialsAlertBox.dart';
import 'package:intl/intl.dart';
import 'package:swiminit/Admin/checkClassService.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EntryPageState();
  }
}

class EntryPageState extends State<EntryPage> {
  String membershipID = "-1";
  bool isWrong=false;
  final TextEditingController _membIDController = TextEditingController();

  Person p = Person(
      "name",
      "lib/Resources/pic-1.png",
      "rollno",
      "enteredAt",
      0,
      0,
      "receiptID",
      "0",
      "datePaid",
      "Student",
      "mailID",
      "contact1",
      "contact2");

  Future getSwimmer() async {
    var response = await http.get(Uri.parse(
        'https://swiminit.herokuapp.com/getdetails?membershipID=$membershipID&admin=False'));
    var data = json.decode(response.body);
    p.dues = data["dues"];
    p.mailID = data["emailID"];
    p.rollno = data["membershipID"];
    p.name = data["name"];
    p.role = data["roles"];
    p.noOfVisits = data["numberOfVisits"];
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
        'dateOfVisit': DateFormat('dd-MM-yyyy;HH:mm:ss').format(DateTime.now())
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
                      alignment: Alignment(-0.7, 1),
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
                      alignment: Alignment(-0.72, 1),
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
                      alignment: Alignment(-0.71, 1),
                      child: Text(
                        p.mailID,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Dues",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.dues != 0 ? "Yes" : "No",
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ]);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }

  Future blankInputs() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0,0 ),
            child: AlertDialog(
              content: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      'Please fill the field',
                      style: GoogleFonts.poppins(
                          color: Color(0xFF149F88),
                          fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF149F88), // background
                      onPrimary: Colors.white, // foreground
                      minimumSize: Size(100,45),
                    ),
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                    },
                  ),
                ),
              ],
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (membershipID == "-1") {
      return Scaffold(
        body: Center(
            child: SizedBox(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      autocorrect: false,
                      cursorColor: Color(0xFF14839F),
                      controller: _membIDController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Membership ID",
                        prefixIcon: Icon(Icons.person, color: Color(0xFF14839F)),
                      ),
                    ),
                    Visibility(visible:isWrong,
                      child: Text("Swimmer does not exist")),
                  ],
                ),
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

              onPressed: ()  async{
                try {
                  final _check = await CheckService.check(_membIDController.text);
                  if(_check.error=="Swimmer does not exist")
                  {
                    setState ( () {
                      isWrong = true;
                    });
                  }
                }catch(e)
                {
                  setState(() {
                    membershipID = _membIDController.text;
                    _membIDController.clear();
                    }
                  );
                }
              },
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
    } else if (membershipID == "-2") {
      if (p.dues != 0) {
        return DuesAlertBox();
      }
      if (p.noOfVisits == 5 && p.role == "Student" && p.dues == 0) {
        return FreeTrialsAlertBox();
      }
      return Scaffold(
        body: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Icon(Icons.check,
              color: Color(0xFF149F88),),
              Text(' Swimmer\'s entry has been recorded',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF149F88), fontSize: 18)
              ),
            ],
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
                },
              ),
            )
        ),
      );
    }
  }
}
