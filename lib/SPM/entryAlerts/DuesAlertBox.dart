import 'package:flutter/material.dart';
import 'DialogAlertBox.dart';

class DuesAlertBox extends StatelessWidget {
  const DuesAlertBox({Key? key}) : super(key: key);

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
