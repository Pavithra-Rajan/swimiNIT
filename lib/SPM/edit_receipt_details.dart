import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/spmnavbar.dart';
import 'Person.dart';
import 'package:intl/intl.dart';

class EditReceiptPage extends StatefulWidget {
  const EditReceiptPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditReceiptPageState();
}

enum currState {searching, editing}

class EditReceiptPageState extends State<EditReceiptPage>
{
  currState state = currState.searching;
  Person p = Person("name", "profileImg", "rollno", "enteredAt", "noOfVisits", "dues", "receiptID", "amtPaid", "datePaid", "role", "mailID", "contact1", "contact2");
  String membershipID = "-1";
  final TextEditingController _recieptController = TextEditingController();
  final TextEditingController _moneyPaidController = TextEditingController();
  final TextEditingController _membIDController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> popupReceiptadded() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10,3 ),
            child: AlertDialog(
              content: Stack(
                children: [
                  Text('Receipt details uploaded successfully',style: GoogleFonts.poppins(color: Color(0xFF149F88), fontSize: 30),),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => SPMNavBar()));
                  },
                ),
              ],
            ),
          );
      },
    );
  }

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  Future getSwimmer() async {
    var response = await http.get(Uri.parse(
        'https://swiminit.herokuapp.com/getdetails?membershipID=$membershipID&admin=False'));
    var data = json.decode(response.body);
    // print("This is data");
    // print(data);
    p.name = data["name"];
    p.rollno = data["membershipID"];
    p.dues = data["dues"].toString();
    p.role = data["roles"];
    p.mailID = data["emailID"];

    return p;
  }

  String findQuarterEnd(DateTime curDT)
  {
    int x = curDT.month;
    if(x <= 3) {
      return DateFormat('dd-MM-yyyy').format(DateTime(curDT.year, 3, 31)).toString();
    }
    else if(x <= 6) {
      return DateFormat('dd-MM-yyyy').format(DateTime(curDT.year, 6, 30)).toString();
    }else if(x <= 9) {
      return DateFormat('dd-MM-yyyy').format(DateTime(curDT.year, 9, 30)).toString();
    }else {
      return DateFormat('dd-MM-yyyy').format(DateTime(curDT.year, 12, 31)).toString();
    }
  }

  Future editReceiptDetails() async {
    var jsonvalue = {};
    var details = {};
    details["accountBalance"] = -int.parse(p.dues) + int.parse(_moneyPaidController.text);
    details["membershipID"] = membershipID;
    details["moneyPaid"] = int.parse(_moneyPaidController.text);
    details["paymentDate"] = DateFormat('dd-MM-yyyy').format(_selectedDate);
    details["receiptID"] = _recieptController.text;
    details["validUntil"] = findQuarterEnd(_selectedDate);
    jsonvalue["details"] = details;
    await http.put(
      Uri.parse('https://swiminit.herokuapp.com/editReceiptDetails'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jsonvalue),
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
                    SizedBox(height: 20,),
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
                      alignment: Alignment(-0.3, 1),

                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          autocorrect: false,
                          cursorColor: Color(0xFF14839F),
                          controller: _recieptController,
                          decoration: const InputDecoration(
                              hintText: "Receipt ID",
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Date Of Payment",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment(-0.6, 1),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: Stack(
                                children: [
                                  Align(
                                      alignment: Alignment(-0.9, 0),
                                    child: Text(
                                      DateFormat('dd-MM-yyyy').format(_selectedDate),
                                      style: GoogleFonts.poppins(),
                                    )
                                  ),
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: RawMaterialButton(child: Icon(Icons.event_note), onPressed: _pickDateDialog),
                                  ),
                                ]
                            )
                        )
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Quarterly fees",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(-0.75, 0),
                            child: Text(
                              p.role=="Student"?"200":"500",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                            Align(
                              alignment: Alignment(0.6, 0),
                              child: SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: _moneyPaidController,
                                  autocorrect: false,
                                  cursorColor: Color(0xFF14839F),
                                  decoration: const InputDecoration(
                                    hintText: "Money Paid",
                                    //prefixIcon: Icon(Icons.attach_money, color: Color(0xFF14839F)),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ]
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    if(state == currState.searching)
    {
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
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => {
                  setState(() {
                        membershipID = _membIDController.text;
                        state = currState.editing;
                  })
                },
              ),
            )
        ),
      );
    }
    else
    {
      return Scaffold(
        body: SingleChildScrollView(
          child: detailsWidget(p)
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
                  setState(() {
                    editReceiptDetails();
                    popupReceiptadded();
                  })
                },
              ),
            )
        ),
      );
    }
  }

}
