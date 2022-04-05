import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Person.dart';
import 'package:flutter/services.dart';

class UserHistoryTable{
  //data Type
  int? id;
  String? dateVisit;
  String? timeEntry;
  String? timeExit;


// constructor
  UserHistoryTable(
      {
        this.id,
        this.dateVisit,
        this.timeEntry,
        this.timeExit,
      }
      );

  //method that assign values to respective datatype vairables
  UserHistoryTable.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    dateVisit = json['dateVisit'];
    timeEntry =json['timeEntry'];
    timeExit = json['timeExit'];

  }
}

class UserHistorySPMPage extends StatefulWidget {
  const UserHistorySPMPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserHistorySPMPageState();

  }
}

class UserHistorySPMPageState extends State<UserHistorySPMPage> {

  Person P = Person(
      'Varun Anilkumar',
      'lib/Resources/pic-1.png',
      "B190621CS",
      "16:36",
      "4",
      "0",
      "R-043657839",
      "200",
      "24-01-2022",
      "Student",
      "varun_b190621cs@nitc.ac.in",
      "6285435321",
      "9061219855");

  Widget userDetails(Person p) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: SizedBox(
          height: 108,
          child: Card(
            color: Color(0xFF93C6D3),
            shadowColor: Color(0xFFFFFFFF),
            margin: EdgeInsets.fromLTRB(20, 20, 20, 8),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white)
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(-0.98, -1),
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
                            style: GoogleFonts.poppins(color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(p.role, style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 13),
                          ),
                          Text(p.rollno,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          )
                        ],
                      ),
                    )
                ),
                Align(
                    alignment: Alignment(1, -1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 7, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(p.noOfVisits + ' visits',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          ),
                          Text('Dues: Rs. ' + p.dues,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
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
            shape: OutlineInputBorder(
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
                          Text('Receipt ID: ' + p.receiptID,
                            style: GoogleFonts.poppins(color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          Text('Amount Paid: Rs. ' + p.amtPaid,
                            style: GoogleFonts.poppins(color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                ),
                Align(
                    alignment: Alignment(1, -1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 7, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Date: ' + p.datePaid,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
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
    Future<List<UserHistoryTable>> readJsonData() async {
      final jsondata = await rootBundle.loadString('VISIT_DATA.json');
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => UserHistoryTable.fromJson(e)).toList();
    }
    int i;
    List<Color> colors = [Color(0xFFFFFFFF), Color(0xFFD2EAF0)];
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color(0xFF14839F),
          title: Text('User History',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
        body:
        SingleChildScrollView(
            child: Column(
              children: [
                userDetails(P),
                userReceipt(P),
                Container(
                  margin: EdgeInsets.only(
                      left: 20, top: 10, right: 20, bottom: 0),
                  child: SingleChildScrollView(

                    child: FutureBuilder(
                      future: readJsonData(),
                      builder: (context, data) {
                        if (data.hasError) {
                          return Center(child: Text("${data.error}"));
                        }
                        else if (data.hasData) {
                          var items = data.data as List<UserHistoryTable>;
                          return Table(

                            border: TableBorder.all(
                              color: Colors.white54,

                            ),
                            children: [
                              TableRow(
                                decoration: const BoxDecoration(
                                    color: Color(0xFF93C6D3)
                                ),
                                children: <Widget>[
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        "Date of visit",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        "Time of entry",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        "Time of exit",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              for (i = 0; i < items.length; i++) TableRow(
                                decoration: BoxDecoration(
                                  color: colors[i % 2],
                                ),
                                children: <Widget>[
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        items[i].dateVisit.toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        items[i].timeEntry.toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        items[i].timeExit.toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        else {
                          return Center(
                            child: CircularProgressIndicator(),);
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}