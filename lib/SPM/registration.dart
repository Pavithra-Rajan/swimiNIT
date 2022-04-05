import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../Admin/Person.dart';

class RegistrationPage extends StatefulWidget {

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {

  bool isVisible = false;
  List<String> roles = ['Student', 'Faculty', 'Faculty Referral'];
  String dropDownVal = 'Student';
  bool swapColor = false;
  Person p = Person(
      "name",
      "lib/Resources/pic-1.png",
      "rollno",
      "enteredAt",
      "noOfVisits",
      "dues",
      "receiptID",
      "amtPaid",
      "datePaid",
      "Student",
      "mailID",
      "contact1",
      "contact2");

  Widget _buildMembershipId() {
    return TextFormField(
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
            alignment: Alignment(-0.42, 1),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 250,
              child: DropdownButton(
                value: dropDownVal,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
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
            )),
      ],
    );
  }

  Widget _buildEmailId() {
    return TextFormField(
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
      decoration: InputDecoration(
        hintText: 'Payment Date',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
    );
  }

  Widget _quaterlyFees() {
    return Column(
      children: [
        Align(
          alignment: Alignment(-0.7, 1),

          child: Text(
            "Quarterly Fees",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
        Align(
            alignment: Alignment(-0.42, 1),
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                alignment: Alignment.centerLeft,
                width: 250,
                child: Text(
                  p.role.compareTo(roles[0]) == 0
                      ? "Rs 200"
                      : "Rs 500",
                  style: GoogleFonts.poppins(),
                ))),
      ],
    );
  }

  Widget _moneyPaid() {
    return TextFormField(
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
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.menu),
      //   title: Text('Registration'),
      //   backgroundColor: Color(0xFF14839F),
      // ),
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
              onPressed: () => {},
            ),
          )
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
