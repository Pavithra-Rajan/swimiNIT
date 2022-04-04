import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Person.dart';
import 'package:flutter/services.dart';

class UserHistoryTable {
  //data Type
  int? id;
  String? dateVisit;
  String? timeEntry;
  String? timeExit;

// constructor
  UserHistoryTable({
    this.id,
    this.dateVisit,
    this.timeEntry,
    this.timeExit,
  });

  //method that assign values to respective datatype vairables
  UserHistoryTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateVisit = json['dateVisit'];
    timeEntry = json['timeEntry'];
    timeExit = json['timeExit'];
  }
}

class UserHistoryAdminPage extends StatefulWidget {
  const UserHistoryAdminPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserHistoryAdminPageState();
  }
}

class UserHistoryAdminPageState extends State<UserHistoryAdminPage> {
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
          height: 173,
          child: Card(
            color: Color(0xFF93C6D3),
            shadowColor: Color(0xFFFFFFFF),
            margin: EdgeInsets.fromLTRB(20, 20, 20, 8),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white)),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(-0.98, -1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 8, 2, 5),
                    child: Container(
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(p.profileImg)))),
                  ),
                ),
                Align(
                    alignment: Alignment(-0.20, -1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            p.name,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            p.role,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          ),
                          Text(
                            p.rollno,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          ),
                          Text(
                            p.mailID,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          ),
                          Text(
                            p.contact1,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          ),
                          Text(
                            p.contact2,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment(1, -1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 7, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            p.noOfVisits + ' visits',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          ),
                          Text(
                            'Dues: Rs. ' + p.dues,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
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
                borderSide: BorderSide(color: Colors.white)),
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment(-0.98, -1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(7, 10, 1, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Receipt ID: ' + p.receiptID,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Amount Paid: Rs. ' + p.amtPaid,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment(1, -1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 7, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Date: ' + p.datePaid,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget downloadButton() {
    return Container(
      margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 20),
      alignment: Alignment(0, 0),
      child: FractionallySizedBox(
          widthFactor: 0.25,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF93C6D3), // background
              onPrimary: Colors.white, // foreground
              minimumSize: Size(175, 45),
            ),
            child: Text(
              'Download',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {},
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<List<UserHistoryTable>> ReadJsonData() async {
      final jsondata = await rootBundle.loadString('assets/VISIT_DATA.json');
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => UserHistoryTable.fromJson(e)).toList();
    }

    var i;
    List<Color> colors = [Color(0xFFFFFFFF), Color(0xFFD2EAF0)]; // here
    return Container(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
      children: [
        userDetails(P),
        userReceipt(P),
        Container(
          margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: ReadJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else if (data.hasData) {
                  var items = data.data as List<UserHistoryTable>;
                  return Table(
                    border: TableBorder.all(
                      color: Colors.white54,
                    ),
                    children: [
                      TableRow(
                        decoration:
                            const BoxDecoration(color: Color(0xFF93C6D3)),
                        children: <Widget>[
                          Container(
                            height: 64,
                            child: Center(
                              child: Text(
                                "Date of visit",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: 64,
                            child: Center(
                              child: Text(
                                "Time of entry",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: 64,
                            child: Center(
                              child: Text(
                                "Time of exit",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (i = 0; i < items.length; i++)
                        TableRow(
                          decoration: BoxDecoration(
                            color: colors[i % 2],
                          ),
                          children: <Widget>[
                            Container(
                              height: 64,
                              child: Center(
                                child: Text(
                                  items[i].dateVisit.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 64,
                              child: Center(
                                child: Text(
                                  items[i].timeEntry.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 64,
                              child: Center(
                                child: Text(
                                  items[i].timeExit.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                  //var items = data.data as List<ProductDataModel>;

                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                throw '';
              },
            ),
          ),
        ),
        downloadButton(),
      ],
    ))));
  }
}
