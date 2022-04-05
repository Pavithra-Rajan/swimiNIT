import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                child: Stack(
                  children:[
                    Container(
                      alignment: Alignment.center,
                      //margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: RawMaterialButton(onPressed: () async {},
                        fillColor: Color(0xFF93C6D3),
                        splashColor: Color(0xFF93C6D3),
                        highlightColor: Color(0xFF93C6D3),
                        constraints: BoxConstraints.tight(Size(300, 225)),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      alignment: Alignment.center,
                      child: Image.asset("lib/Resources/visitReport.png",
                        width: 150,
                        height: 150,),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        alignment: Alignment.center,
                        child: Text('Collections Report',
                            style: GoogleFonts.rubik(color: Colors.black, fontSize: 18))
                    ),

                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      alignment: Alignment.center,
                        //margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: RawMaterialButton(onPressed: () async {},
                          fillColor: Color(0xFF93C6D3),
                          splashColor: Color(0xFF93C6D3),
                          highlightColor: Color(0xFF93C6D3),
                          constraints: BoxConstraints.tight(Size(300, 225)),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                    ),
                ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      alignment: Alignment.center,
                      child: Image.asset("lib/Resources/collectionReport.png",
                        width: 150,
                        height: 150,),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      alignment: Alignment.center,
                      child: Text('Collections Report',
                        style: GoogleFonts.rubik(color: Colors.black, fontSize: 18))
                    ),
                ]
                ),
              )
              ,),



          ]),
    );
  }
}