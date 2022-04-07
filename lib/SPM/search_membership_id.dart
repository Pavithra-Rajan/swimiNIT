import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:swiminit/SPM/user_history.dart';
import 'package:swiminit/Admin/checkClassService.dart';
class MembershipIdSearch1 extends StatefulWidget {
  final Function toggleswitch;
  final bool showMembership;

  const MembershipIdSearch1(
      {required this.toggleswitch, required this.showMembership});

  @override
  State<StatefulWidget> createState() => MembershipIdSearchState1();
}

class MembershipIdSearchState1 extends State<MembershipIdSearch1> {
  late String rollno;
  bool swapColor = false;
  bool isVisible = false;
  bool isWrong =false;

  Widget _buildMembershipId() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Membership ID',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
      ),
      onChanged: (value) {
        setState(() {
          rollno = value;
        });

      },
    );
  }

  Widget blankInputs() {

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
                initialLabelIndex: swapColor ? 1 : 0,
                activeBgColor: const [Color(0xff0388A9)],
                activeFgColor: Colors.white,
                inactiveBgColor: Color(0xffD1E9EF),
                inactiveFgColor: Color(0xff000000).withOpacity(0.5),
                totalSwitches: 2,
                labels: const ['By Membership ID', 'By Date'],
                onToggle: (index) {
                  if (index == 0 && widget.showMembership == false) {
                    setState(() {
                      widget.toggleswitch();
                      swapColor = !swapColor;
                    });
                  }
                  if (index == 1 && widget.showMembership == true) {
                    setState(() {
                      widget.toggleswitch();
                      swapColor = !swapColor;
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
                      Visibility(
                        visible: isWrong,
                        child: Text("Swimmer does not exist"),),
                    ]),
              )
            ],
          ),
        ),
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
                try{
            final _check = await CheckService.check(rollno);
            if(_check.error=="Swimmer does not exist")
            {
            setState ( () {
            isWrong = true;
            });
            }
            }catch(e)
            {Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => UserHistorySPMPage(rollno: rollno)));}

              },
            ),
          )),
    );
  }
}
