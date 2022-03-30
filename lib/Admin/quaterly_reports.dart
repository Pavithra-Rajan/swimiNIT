import 'package:flutter/material.dart';

class QuarterlyReports extends StatelessWidget
{
  const QuarterlyReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Container(
                alignment: Alignment.center,
                child: RawMaterialButton(onPressed: () async {},
                    fillColor: Color(0xFF93C6D3),
                    splashColor: Color(0xFF93C6D3),
                    highlightColor: Color(0xFF93C6D3),
                    constraints: BoxConstraints.tight(Size(300, 225)),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Image.asset("lib/Resources/Checklist.png")
                ),
              )
              ,),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Container(
                alignment: Alignment.center,
                child: RawMaterialButton(onPressed: () async {},
                    fillColor: Color(0xFF93C6D3),
                    splashColor: Color(0xFF93C6D3),
                    highlightColor: Color(0xFF93C6D3),
                    constraints: BoxConstraints.tight(Size(300, 225)),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Image.asset("lib/Resources/money.png")
                ),
              )
              ,)
          ]),
    );
  }
}