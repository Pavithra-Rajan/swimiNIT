import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Person.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({Key? key}) : super(key: key);

  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {

  Person P = Person('Varun Anilkumar', 'lib/Resources/pic-1.png', "B190621CS", "16:36", "4", "0", "R-043657839", "200", "24-01-2022", "Student","varun_b190621cs@nitc.ac.in","6285435321","9061219855");

  Widget userDetails(Person p) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
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
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(p.profileImg)
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
                        Text(p.name,
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(p.role, style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                  ),
                        Text(p.rollno,
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
                        Text(p.noOfVisits+' visits',
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                        ),
                        Text('Dues: Rs. '+p.dues,
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

  Widget userReceipt(Person p) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: SizedBox(
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
                          Text('Receipt ID: '+ p.receiptID,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text('Amount Paid: Rs. '+p.amtPaid, style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
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
                          Text('Date: ' + p.datePaid,
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

      body: Column(
             children: [
               userDetails(P),
               userReceipt(P)
             ],
      )
    );
  }
}
