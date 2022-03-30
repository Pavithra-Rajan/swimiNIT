import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  bool isVisible=false;
  Widget _buildMembershipId() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Membership ID',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),

      ),


    );
  }
  Widget _buildName() {
    return TextFormField(

      decoration: InputDecoration(hintText: 'Name',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),

    );
  }
  Widget _buildRole() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Role',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),

    );
  }
  Widget _buildEmailId() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Email Id',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),

    );
  }
  Widget _buildContactNo1() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Contact No. 1',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),
    );
  }
  Widget _buildContactNo2() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Contact No. 2',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),
    );
  }
  Widget _receiptId() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Receipt ID',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),
    );
  }
  Widget _paymentDate() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Payment Date',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),
    );
  }
  Widget _quaterlyFees() {
    return TextFormField(
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
      decoration: InputDecoration(
        hintText: 'Money Paid',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

      // appBar: AppBar(
      //   leading: Icon(Icons.menu),
      //   title: Text('Registration'),
      //   backgroundColor: Color(0xFF14839F),
      // ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 35, top:10, right: 35, bottom:0),
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
                  initialLabelIndex: 1,
                  activeBgColor: [Color(0xff0388A9)],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Color(0xffD1E9EF),
                  inactiveFgColor: Color(0xff000000).withOpacity(0.5),
                  totalSwitches: 2,
                  labels: ['Pay Now', 'Pay Later'],
                  onToggle: (index) {
                    setState(() {
                      if(index==0)
                      {
                        isVisible=true;
                        print(isVisible);
                      }
                      else
                      {
                        isVisible=false;
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
                            width:100,
                            child:_quaterlyFees(),),
                          SizedBox(
                            width:100,
                            child:_moneyPaid(),)

                        ],
                      ),
                    ],

                  ) ,
                ),



              ],
            ),
          ),


        ),
      ),


      bottomNavigationBar:

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          SizedBox(
            height:40, //height of button
            width:384, //width of button equal to parent widget
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan[900], //background color of button
                //border width and color
                elevation: 0, //elevation of button
                shape: RoundedRectangleBorder( //to set border radius to button
                    borderRadius: BorderRadius.circular(3)
                ),
                //content padding inside button
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: ()=> {},
            ),
          )

        ],


      ),
    );

  }
}
