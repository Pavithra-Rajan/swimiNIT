import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
class Daterange2  extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => Daterange2State();
}

class  Daterange2State extends State<Daterange2> {
  bool isVisible=false;
  Widget _builddaterange1() {
    return DateTimeFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'From Date',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
      onDateSelected: (DateTime value) {
        print(value);
      },
    );
  }
  Widget _builddaterange2() {
    return DateTimeFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'To Date',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
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
          ]
      ),



    );

  }
}