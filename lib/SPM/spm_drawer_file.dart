import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF14839F),
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 5,
          ),
          Text(
            'Menu',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
