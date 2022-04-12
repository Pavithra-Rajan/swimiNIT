import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/receipt_valid_service.dart';
import 'package:swiminit/SPM/spmnavbar.dart';
import 'person.dart';
import 'package:intl/intl.dart';
import 'package:swiminit/Admin/checkClassService.dart';
import 'package:swiminit/SPM/receiptIDerrorService.dart';
import 'package:swiminit/SPM/receiptIDerror.dart';
import 'package:swiminit/SPM/receipt_valid_class.dart';
class EditReceiptPage extends StatefulWidget {
  const EditReceiptPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditReceiptPageState();
}

enum currState {searching, editing}

class EditReceiptPageState extends State<EditReceiptPage>
{
  bool isWrong=false;
  currState state = currState.searching;
  Person p = Person("name", "profileImg", "rollno", "enteredAt", 0, 0, "receiptID", "amtPaid", "datePaid", "role", "mailID", "contact1", "contact2");
  String membershipID = "-1";
  var  _recieptController = TextEditingController();
  final TextEditingController _moneyPaidController = TextEditingController();
  final TextEditingController _membIDController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> popupReceiptadded() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
          child: AlertDialog(
            content: Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(40, 8, 40, 50),
                  child: Text('Receipt details uploaded successfully',
                      style: GoogleFonts.poppins(
                          color: Color(0xFF149F88), fontSize: 15),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(100, 70, 100, 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF149F88), // background
                      onPrimary: Colors.white, // foreground
                      minimumSize: Size(100, 45),
                    ),
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SPMNavBar()));
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime
            .now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
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
    p.dues = data["dues"];
    p.role = data["roles"];
    p.mailID = data["emailID"];

    return p;
  }

  Future editReceiptDetails() async {
    var jsonvalue = {};
    var details = {};
    details["membershipID"] = membershipID;
    details["moneyPaid"] = int.parse(_moneyPaidController.text);
    details["paymentDate"] = DateFormat('dd-MM-yyyy').format(_selectedDate);
    details["receiptID"] = _recieptController.text;
    jsonvalue["details"] = details;
    print(details["moneyPaid"]);

    await http.put(
      Uri.parse('https://swiminit.herokuapp.com/editReceiptDetails'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jsonvalue),
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
                    child: Text('Please fill the field',style: GoogleFonts.poppins(color: Color(0xFF149F88), fontSize: 16),),
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

  Widget detailsWidget(Person p) {
    return Padding(
      padding: EdgeInsets.all(0),
      child:Column(
        children: <Widget>[
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


                      ]
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          FutureBuilder(
            future: ReceiptIDerrorServices.receiptIDservices(membershipID),
            builder:(context,data)
            {
              if(data.hasError)
                {
                  return Text("");
                }
              else if(data.hasData)
                {
                  var swimmers= data.data as ReceipIDreport;

                  return Column(
                    children: <Widget>[
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
                      SizedBox(height: 20,),
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
                    ],
                  );
                }
              else
                {
                  return Center(child: Text("Loading"));
                }
            }
            ,
          ),
          FutureBuilder(
              future:ReceiptIDvalidServices.receiptIDservices(membershipID),
              builder:(context,data)
          {
              if(data.hasError)
                {
                  return Text("");
                }
              else if(data.hasData)
                {

                  var swimmers= data.data as ReceipIDreportValid ;
                  _recieptController.text=swimmers.receipt.receiptId;
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          "Receipt ID",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment(-0.75, 1),
                        child: Text(
                          swimmers.receipt.receiptId,
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      SizedBox(height: 20,),
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
                    ],
                  );
                }
              else
                {
                  return Text("");
                }
          })
        ],
      ),

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[TextField(
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
                child: Text("Swimmer does not exist",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),),
            ],),
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
                  { if(_membIDController.text.isEmpty)
                  {
                    blankInputs();
                    return;
                  }
                  else
                  {
                    setState(() {

                      membershipID = _membIDController.text;
                      state = currState.editing;
                    });
                  }
                  }

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
