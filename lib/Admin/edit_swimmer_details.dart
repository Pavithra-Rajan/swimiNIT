import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/adminnavbar.dart';
import 'package:http/http.dart' as http;
import 'swimmer.dart';
import 'dart:convert';
import 'package:swiminit/Admin/checkClassService.dart';

class EditSwimmerPage extends StatefulWidget {
  const EditSwimmerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditSwimmerDetailsState();
}

enum currState { searching, editing }

class _EditSwimmerDetailsState extends State<EditSwimmerPage> {
  bool isWrong = false;
  currState state = currState.searching;
  String membershipID = "-1";
  List<String> roles = ['Student', 'Faculty', 'Faculty Dependant'];
  String dropDownVal = 'Student';
  Swimmer s = Swimmer("membershipID", "name", "role", "emailID", "contact1",
      "contact2", "moneyPaid", "receiptID", "paymentDate");
  final TextEditingController _membIDController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailIDController = TextEditingController();
  final TextEditingController _contact1Controller = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  bool _text1Controller_bool = false;
  bool _text2Controller_bool = false;
  bool _text3Controller_bool = false;
  bool _text4Controller_bool = false;

  Future<void> popupSwimmerDetailsUpdated() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
          child: AlertDialog(
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 8, 20, 10),
                    child: Text('Swimmer details updated successfully',
                        style: GoogleFonts.poppins(
                            color: Color(0xFF149F88), fontSize: 15),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 20, 50, 5),
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF149F88), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => AdminNavBar()));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future blankInputs() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: AlertDialog(
            content: Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Please fill the field',
                    style: GoogleFonts.poppins(
                        color: Color(0xFF149F88), fontSize: 16),
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
                    minimumSize: Size(100, 45),
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

  Future getSwimmer() async {
    var response = await http.get(Uri.parse(
        'https://swiminit.herokuapp.com/getdetails?membershipID=$membershipID&admin=True'));
    var data = json.decode(response.body);
    s.membershipID = data["membershipID"];
    s.name = data["name"];
    s.role = data["role"];
    s.emailID = data["emailID"];
    s.contact1 = data["contact1"];
    s.contact2 = data["contact2"];
    _nameController.text = s.name;
    _emailIDController.text = s.emailID;
    _contact1Controller.text = s.contact1;
    _contact2Controller.text = s.contact2;
    return s;
  }

  Future getReceiptDetails() async {
    var response = await http.get(Uri.parse(
        'https://swiminit.herokuapp.com/getreceiptdetails?membershipID=$membershipID'));
    var data = json.decode(response.body);
    if (data.containsKey("error")) {
      s.moneyPaid = "-";
      s.receiptID = "-";
      s.paymentDate = "-";
    } else {
      var data1 = data["receipt"];
      s.moneyPaid = data1["moneyPaid"].toString();
      s.receiptID = data1["receiptID"];
      s.paymentDate = data1["paymentDate"];
    }

    return s;
  }

  Future editSwimmerDetails() async {
    await http.put(
      Uri.parse('https://swiminit.herokuapp.com/editContactDetails'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Map<String, String>>{
        "details": {
          'membershipID': _membIDController.text,
          'contact1': _contact1Controller.text,
          'contact2': _contact2Controller.text,
          'emailID': _emailIDController.text,
          'name': _nameController.text
        }
      }),
    );
  }

  Widget detailsWidget(Swimmer s) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Column(children: [
          FutureBuilder(
              future: getSwimmer(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else if (data.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment(-0.71, 10),
                        child: Text(
                          "Membership ID",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          s.membershipID,
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          "Name",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                          alignment: Alignment(-0.42, 1),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: 250,
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: s.name,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF14839F)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF14839F)),
                                  ),
                                ),
                                style: GoogleFonts.poppins(),
                              ))),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          _text1Controller_bool ? "*Invalid input" : "",
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          "Role",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment(-0.42, 1),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: Text(
                              s.role,
                              style: GoogleFonts.poppins(),
                            ),
                            // child: DropdownButton(
                            //   value: dropDownVal,
                            //   // Down Arrow Icon
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   items: roles.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(items),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       dropDownVal = newValue!;
                            //       s.role = dropDownVal;
                            //     });
                            //   },
                            // ),
                          )),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          "Email ID",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                          alignment: Alignment(-0.42, 1),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: 250,
                              child: TextField(
                                controller: _emailIDController,
                                decoration: InputDecoration(
                                  hintText: s.emailID,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF14839F)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF14839F)),
                                  ),
                                ),
                                style: GoogleFonts.poppins(),
                              ))),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          _text2Controller_bool ? "*Invalid input" : "",
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          "Contact 1",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                          alignment: Alignment(-0.42, 1),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: 250,
                              child: TextField(
                                controller: _contact1Controller,
                                decoration: InputDecoration(
                                  hintText: s.contact1,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF14839F)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF14839F)),
                                  ),
                                ),
                                style: GoogleFonts.poppins(),
                              ))),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          _text3Controller_bool ? "*Invalid input" : "",
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          "Contact 2",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                          alignment: Alignment(-0.42, 1),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: 250,
                              child: TextField(
                                controller: _contact2Controller,
                                decoration: InputDecoration(
                                  hintText: s.contact2,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF14839F)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF14839F)),
                                  ),
                                ),
                                style: GoogleFonts.poppins(),
                              ))),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          _text4Controller_bool ? "*Invalid input" : "",
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          FutureBuilder(
              future: getReceiptDetails(),
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
                            "Receipt ID",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment(-0.42, 1),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                width: 250,
                                child: Text(
                                  s.receiptID,
                                  style: GoogleFonts.poppins(),
                                ))),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment(-0.7, 1),
                          child: Text(
                            "Date Of Payment",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment(-0.42, 1),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                width: 250,
                                child: Text(
                                  s.paymentDate,
                                  style: GoogleFonts.poppins(),
                                ))),
                        SizedBox(height: 20),
                        Stack(children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment(-0.7, 1),
                                child: Text(
                                  "Quarterly Fees",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Align(
                                  alignment: Alignment(-0.42, 1),
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                                      alignment: Alignment.centerLeft,
                                      width: 250,
                                      child: Text(
                                        s.role == roles[0]
                                            ? "Rs 200"
                                            : "Rs 500",
                                        style: GoogleFonts.poppins(),
                                      ))),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment(0.5, 0),
                                child: Text(
                                  "Fees Paid",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Align(
                                  alignment: Alignment(-0.2, 1),
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                                      alignment: Alignment.centerRight,
                                      width: 250,
                                      child: Text(
                                        s.moneyPaid,
                                        style: GoogleFonts.poppins(),
                                      ))),
                            ],
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        )
                      ]);
                } else {
                  return Center(child: Container());
                }
              }),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    if (state == currState.searching) {
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
              Visibility(
                visible: isWrong,
                child: Text(
                  "Swimmer does not exist",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        )),
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
                onPressed: () async {
                  try {
                    final _check =
                        await CheckService.check(_membIDController.text);
                    if (_check.error == "Swimmer does not exist") {
                      setState(() {
                        isWrong = true;
                      });
                    }
                  } catch (e) {
                    if (_membIDController.text.isEmpty) {
                      blankInputs();
                      return;
                    } else {
                      setState(() {
                        membershipID = _membIDController.text;
                        state = currState.editing;
                      });
                    }
                  }
                },
              ),
            )),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(child: detailsWidget(s)),
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
                  setState(() {
                    _text1Controller_bool = false;
                    _text2Controller_bool = false;
                    _text3Controller_bool = false;
                    _text4Controller_bool = false;

                    if (_nameController.text.length == 0) {
                      _text1Controller_bool = true;
                    } else if (_emailIDController.text.length == 0) {
                      _text2Controller_bool = true;
                    } else if (_contact1Controller.text.length != 10) {
                      _text3Controller_bool = true;
                    } else if (_contact2Controller.text.length != 10) {
                      _text4Controller_bool = true;
                    } else {
                      editSwimmerDetails();
                      popupSwimmerDetailsUpdated();
                    }
                  })
                },
              ),
            )),
      );
    }
  }
}
