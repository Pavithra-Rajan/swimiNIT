import 'package:flutter/material.dart';
import 'DialogAlertBox.dart';

class FreeTrialsAlertBox extends StatelessWidget {
  const FreeTrialsAlertBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: CustomAlertDialogBox(
          title: "Warning",
          description:
          "As 5 free trials have been exhausted, dues will be incurred",
        ),

      ),
    );
  }
}
