import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:swiminit/SPM/search_by_daterange_results.dart';
import 'package:intl/intl.dart';
class Daterange2 extends StatefulWidget {
  final Function toggleswitch;
  final bool showMembership;
  Daterange2({required this.toggleswitch,required this.showMembership});
  @override
  State<StatefulWidget> createState() => Daterange2State();
}

class Daterange2State extends State<Daterange2> {
  bool isVisible = false;
  bool isChecked=false;
  var fromdate;
  var enddate;
  TextEditingController _textEditingController1 =TextEditingController();
  TextEditingController _textEditingController2 =TextEditingController();

  Widget _builddaterange1() {
    return DateTimeFormField(

      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'From Date',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      lastDate: DateTime.now(),

      onDateSelected: (DateTime value) {
        //print(value);
        fromdate = value;
        print(fromdate);
        fromdate=fromdate.toString().split(" ")[0];
        fromdate=fromdate.split('-').reversed.join('-');
        print(fromdate);
      },

    );
  }

  Widget _builddaterange2() {
    return DateTimeFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'To Date',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      initialDate: DateTime.now(),
      onDateSelected: (DateTime value) {
        enddate=value;
        enddate=enddate.toString().split(" ")[0];
        enddate=enddate.split('-').reversed.join('-');

      },
    );
  }

  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.cyan.shade900;
      }
      return Colors.cyan.shade900;
    }
    void check(bool value)
    {
      setState(() {

        isChecked=value;
      });
    }
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _builddaterange1(),
                      StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                // setState(() {
                                //   isChecked = value!;
                                // });
                                check(value!);
                                print(isChecked);
                              },
                            );

                          }),
                      Visibility(
                        child:_builddaterange2(),
                        visible: !isChecked,
                      ),

                    ]),
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
              onPressed: () {
                if(isChecked==false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) =>
                          SearchByDateRange(
                              fromdate: fromdate, enddate: enddate)));
                }
                if(isChecked==true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) =>
                          SearchByDateRange(
                              fromdate: fromdate, enddate: fromdate)));
                }

              },
            ),
          )
        ],
      ),
    );
  }
}