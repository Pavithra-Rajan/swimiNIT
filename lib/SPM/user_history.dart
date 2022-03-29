import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Person.dart';
import 'package:expandable/expandable.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({Key? key}) : super(key: key);

  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  Person P = Person('Varun Anilkumar', 'lib/Resources/pic-1.png', "B190621CS", "16:36", "4", "0", "R-043657839", "200", "24-01-2022", "Student");


  Widget userDetails(Person) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 108,
        child: Card(
          color: Color(0xFF93C6D3),
          shadowColor: Color(0xFFFFFFFF),
          margin: EdgeInsets.fromLTRB(20, 20, 20, 8),
          shape:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(-0.98,-1),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 8, 1, 5),
                  child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(Person.profileImg)
                          )
                      )),
                ),
              ),
              Align(
                  alignment: Alignment(-0.35, -1),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(Person.name,
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(Person.role, style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                  ),
                        Text(Person.rollno,
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                        )
                      ],
                    ),
                  )
              ),
              Align(
                  alignment: Alignment(1,-1),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 7, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(Person.noOfVisits+' visits',
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                        ),
                        Text('Dues: Rs. '+Person.dues,
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                        )
                      ],
                    ),
                  )

              )

            ],
          ),
        ),
      )

      );
  }

  Widget userReceipt(Person) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          height: 80,
          child: Card(
            color: Color(0xFF93C6D3),
            shadowColor: Color(0xFFFFFFFF),
            margin: EdgeInsets.fromLTRB(20, 8, 20, 10),
            shape:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white)
            ),
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment(-0.98, -1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(7, 10, 1, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Receipt ID: '+ Person.receiptID,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text('Amount Paid: Rs. '+Person.amtPaid, style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                ),
                Align(
                    alignment: Alignment(1,-1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 7, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Date: ' + Person.datePaid,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    )

                )

              ],
            ),
          ),
        )

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        backgroundColor: Color(0xFF14839F),
        title: Text('User History', style: GoogleFonts.poppins(color: Colors.white)
        ),
      ),

      body:
      Column(
       children: [
         userDetails(P),
         userReceipt(P)
       ],
      )

    );
  }

}
