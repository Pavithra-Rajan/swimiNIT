import 'package:flutter/material.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:swiminit/Admin/search_membershipID.dart';
import 'package:swiminit/Admin/search_dateRange.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<Search> {
  bool showMembership = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.menu),
      //   title: Text('Search'),
      //   backgroundColor: Color(0xFF14839F),
      // ),
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
                            setState(() {
                              if (index == 0) {
                                showMembership = true;
                              } else {
                                showMembership = false;
                              }
                            });
                          },
                        ),
                // SizedBox(height: 75,),
                Visibility(
                  visible: showMembership,
                  child: MembershipIdSearch_1(),
                  replacement: Daterange2(),
                ),
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
        width: 410, //width of button equal to parent widget
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
          onPressed: () => {},
        ),
      )
    ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {

  final TextEditingController _mebIDController = TextEditingController();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 350,
          child: TextField(
            autocorrect: false,
            cursorColor: Color(0xFF14839F),
            controller: _mebIDController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
            hintText: "Membership ID",
            prefixIcon: Icon(Icons.person, color: Color(0xFF14839F)),
      ),
      )
      )
    );
  }
}
