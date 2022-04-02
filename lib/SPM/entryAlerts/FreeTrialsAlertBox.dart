import 'package:flutter/material.dart';
import 'DialogAlertBox.dart';
import 'package:google_fonts/google_fonts.dart';

class FreeTrialsAlertBox extends StatelessWidget {
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
                  title: "Warning",
                  description:
                      "As 5 free trials have been exhausted, dues will be incurred",
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
