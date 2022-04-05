import 'package:flutter/material.dart';
import 'DialogAlertBox.dart';
import 'package:google_fonts/google_fonts.dart';

class DuesAlertBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Color(0xFF14839F),
          onPressed: () {
            showDialog(
              barrierColor: Colors.black26,
              context: context,
              builder: (context) {
                return CustomAlertDialogBox(
                  title: "Error",
                  description:
                      "User cannot enter as they have outstanding dues",
                );
              },
            );
          },
          child: Text("Enter"),
        ),
      ),
    );
  }
}
