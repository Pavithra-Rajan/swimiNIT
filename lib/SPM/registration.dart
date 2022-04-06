import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import '../SPM/Person.dart';

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
  late Person p;

  final TextEditingController _memIDController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailIDController = TextEditingController();
  final TextEditingController _contact1Controller = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  final TextEditingController _receiptIDController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();
  final TextEditingController _moneyPaidController = TextEditingController();


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
            iconEnabledColor: Colors.teal,
            iconDisabledColor: Colors.teal,
            dropdownColor: Colors.teal,
            focusColor: Colors.teal,
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
    return TextFormField(
      controller: _paymentDateController,
      decoration: InputDecoration(
        hintText: 'Payment Date',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  Widget _quaterlyFees() {

    return TextFormField(
      controller: _feesController,
      decoration: InputDecoration(
        hintText: 'Fees',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
    ),
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
            child: Form(
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
                      });
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
                    return;
                  }
                p = Person(_nameController.text,
                    "profileImg",
                    _memIDController.text,
                    "enteredAt",
                    "noOfVisits",
                    "dues",
                    "receiptID",
                    "amtPaid",
                    "datePaid",
                    dropDownVal,
                    _mailIDController.text,
                    _contact1Controller.text,
                    _contact2Controller.text);
                if(!swapColor){
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

  Future swimmerRegistration() async
  {
    var jsonvalue = {};
    var details = {};
    jsonvalue["paid"] = swapColor.toString();
    details["contact1"] = p.contact1;
    details["contact2"] = p.contact2;
    details["dues"] = p.role=="Student"?0:(swapColor?0:500);
    details["role"] = p.role;
    details["emailID"] = p.mailID;
    details["fees"] = p.role=="Student"?200:500;
    details["membershipID"] = p.rollno;
    details["name"] = p.name;
    details["numberOfFreeTrials"] = p.role=="Student"?5:0;
    jsonvalue["details"] = details;

    await http.post(
      Uri.parse('https://swiminit.herokuapp.com/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jsonvalue)
    );
  }
}