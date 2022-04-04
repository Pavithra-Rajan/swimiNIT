import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class Daterange2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Daterange2State();
}

class Daterange2State extends State<Daterange2> {
  bool isVisible = false;
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
        var fromDate = value;
        print(fromDate);
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
        print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _builddaterange1(),
            _builddaterange2(),
          ]),
    );
  }
}
