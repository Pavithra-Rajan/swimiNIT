import 'dart:convert';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import '../SPM/person.dart';
import 'package:intl/intl.dart';

class RegistrationPage extends StatefulWidget {

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {

  bool isVisible = false;
  List<String> roles = ['Student', 'Faculty', 'Faculty Dependant'];
  String dropDownVal = 'Student';

  bool swapColor = false, submitted = false;
  Person p = Person("name", "profileImg", "rollno", "enteredAt", 0, 0, "receiptID", "0", "datePaid", "Student", "mailID", "contact1", "contact2");

  final TextEditingController _memIDController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailIDController = TextEditingController();
  final TextEditingController _contact1Controller = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  final TextEditingController _receiptIDController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _moneyPaidController = TextEditingController();
  DateTime paymentDate = DateTime.now();


  Widget _buildMembershipId() {
    return TextFormField(
      controller: _memIDController,
      decoration: InputDecoration(
        hintText: 'Membership ID',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildName() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        hintText: 'Name',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildRole() {
    return Column(
      children: [
        Align(
          alignment: Alignment(-1, 1),
          child: DropdownButton(
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.white,
            dropdownColor: Colors.white,
            focusColor: Colors.white,
            icon: const Icon(Icons.keyboard_arrow_down),
            value: dropDownVal,
            items: roles.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropDownVal = newValue!;
                p.role = dropDownVal;
              });
            },
            ),
          )
      ],
    );
  }

  Widget _buildEmailId() {
    return TextFormField(
      controller: _mailIDController,
      decoration: InputDecoration(
        hintText: 'Email Id',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildContactNo1() {
    return TextFormField(
      controller: _contact1Controller,
      decoration: InputDecoration(
        hintText: 'Contact No. 1',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildContactNo2() {
    return TextFormField(
      controller: _contact2Controller,
      decoration: InputDecoration(
        hintText: 'Contact No. 2',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  Widget _receiptId() {
    return TextFormField(
      controller: _receiptIDController,
      decoration: InputDecoration(
        hintText: 'Receipt ID',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  Widget _paymentDate() {
    return DateTimeFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'Payment Date',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      onDateSelected: (DateTime value){
        _paymentDateController.text= DateFormat('dd-MM-yyyy').format(value);
      },
    );
  }

  Widget _quaterlyFees() {
    return Text(
      p.role=="Student"?"Fees: 200":"Fees: 500"
    );
  }

  Widget _moneyPaid() {
    return TextFormField(
      controller: _moneyPaidController,
      decoration: InputDecoration(
        hintText: 'Money Paid',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(submitted)
      {
        return Scaffold(
          body: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                Icon(Icons.check,
                  color: Color(0xFF149F88),),
                Text(' Swimmer has been successfully registered',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF149F88), fontSize: 18)),
              ],
            )
          ),
          bottomNavigationBar: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.07,
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
                  onPressed: () {
                    setState(() {
                    submitted = false;
                    });
                  },
                ),
              )
          ),
        );
      }
    else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 35, top: 10, right: 35, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  _buildMembershipId(),
                  SizedBox(height: 15),
                  _buildName(),
                  SizedBox(height: 15),
                  _buildRole(),
                  SizedBox(height: 15),
                  _buildEmailId(),
                  SizedBox(height: 15),
                  _buildContactNo1(),
                  SizedBox(height: 15),
                  _buildContactNo2(),
                  SizedBox(height: 15),
                  ToggleSwitch(
                    minWidth: 140.0,
                    minHeight: 50.0,
                    fontSize: 16.0,
                    initialLabelIndex: swapColor?0:1,
                    activeBgColor: const [Color(0xff0388A9)],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Color(0xffD1E9EF),
                    inactiveFgColor: Color(0xff000000).withOpacity(0.5),
                    totalSwitches: 2,
                    labels: const ['Pay Now', 'Pay Later'],
                    onToggle: (index) {
                      setState(() {
                        if (index == 0) {
                          isVisible = true;
                          swapColor = !swapColor;
                        } else {
                          isVisible = false;
                          swapColor = !swapColor;
                        }
                      }
                      );
                    },
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _receiptId(),
                        _paymentDate(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              child: _quaterlyFees(),
                            ),
                            SizedBox(
                              width: 100,
                              child: _moneyPaid(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.07,
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
              onPressed: () {
                if(_nameController.text.isEmpty || _memIDController.text.isEmpty || _mailIDController.text.isEmpty || _contact1Controller.text.isEmpty || _contact2Controller.text.isEmpty)
                  {
                    //show popup telling to fill details
                    blankInputs();
                    return;
                  }
                p = Person(_nameController.text,
                    "profileImg",
                    _memIDController.text,
                    "enteredAt",
                    0,
                    0,
                    "receiptID",
                    "0",
                    "datePaid",
                    dropDownVal,
                    _mailIDController.text,
                    _contact1Controller.text,
                    _contact2Controller.text);
                if(swapColor){
                  p.receiptID = _receiptIDController.text;
                  p.datePaid = _paymentDateController.text;
                  p.amtPaid = _moneyPaidController.text;
                }
                swimmerRegistration();
                _nameController.clear();
                _memIDController.clear();
                _mailIDController.clear();
                _contact1Controller.clear();
                _contact2Controller.clear();
                _receiptIDController.clear();
                _paymentDateController.clear();
                _moneyPaidController.clear();
                setState(() {
                  submitted = true;
                });
              },
            ),
          )
      ),
      resizeToAvoidBottomInset: true,
    );
    }
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
                    child: Text('Please fill all the fields',style: GoogleFonts.poppins(color: Color(0xFF149F88), fontSize: 16),),
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

  Future repeatID() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0,0 ),
            child: AlertDialog(
              content: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text('Swimmer is already registered', style: GoogleFonts.poppins(color: Color(0xFF149F88), fontSize: 16),),
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

  Future swimmerRegistration() async
  {
    var jsonvalue = {};
    var details = {};
    var receipt = {};
    jsonvalue["paid"] = swapColor;
    details["contact1"] = p.contact1;
    details["contact2"] = p.contact2;
    details["role"] = p.role;
    details["emailID"] = p.mailID;
    details["membershipID"] = p.rollno;
    details["name"] = p.name;
    receipt["receiptID"] = p.receiptID; 
    receipt["membershipID"] = p.rollno; 
    receipt["moneyPaid"] = int.parse(p.amtPaid); 
    receipt["paymentDate"] = p.datePaid;
    jsonvalue["details"] = details;
    jsonvalue["receipt"] = receipt;
    final response = await http.post(
      Uri.parse('https://swiminit.herokuapp.com/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jsonvalue)
    );

    if(response.statusCode != 200)
    {
      repeatID();
    }
  }
}