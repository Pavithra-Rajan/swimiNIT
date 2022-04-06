import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:swiminit/SPM/user_history.dart';
class MembershipIdSearch_1  extends StatefulWidget {

  final Function toggleswitch;
  final bool showMembership;
  MembershipIdSearch_1({required this.toggleswitch,required this.showMembership});
  @override
  State<StatefulWidget> createState() => MembershipIdSearchState_1();
}

class  MembershipIdSearchState_1 extends State<MembershipIdSearch_1> {
  late String rollno;
  bool isVisible=false;
  Widget _buildMembershipId() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Membership ID',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),

      ),
      onChanged:(value){
        rollno=value;
      },


    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 35, top: 40, right: 35, bottom: 0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ToggleSwitch(
                minWidth: 140.0,
                minHeight: 40.0,
                fontSize: 14.0,
                initialLabelIndex: 0,
                activeBgColor: const [Color(0xff0388A9)],
                activeFgColor: Colors.white,
                inactiveBgColor: Color(0xffD1E9EF),
                inactiveFgColor: Color(0xff000000).withOpacity(0.5),
                totalSwitches: 2,
                labels: const ['By Membership ID', 'By Date'],
                onToggle: (index) {
                  if(index==0 && widget.showMembership==false) {
                    setState(() {
                      widget.toggleswitch();
                    });
                  }
                  if(index==1 && widget.showMembership==true) {
                    setState(() {
                      widget.toggleswitch();
                    });
                  }
                },
              ),
              // SizedBox(height: 75,),
              Expanded(
                child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildMembershipId(),
                    ]
                ),



              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 40, //height of button
            width: 400, //width of button equal to parent widget
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF14839F), //background color of button
                //border width and color
                elevation: 0, //elevation of button
                shape: RoundedRectangleBorder(
                  //to set border radius to button
                    borderRadius: BorderRadius.circular(3)),
                //content padding inside button
              ),
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => UserHistorySPMPage(rollno: rollno)))
              },
            ),
          )
        ],
      ),
    );

  }
}