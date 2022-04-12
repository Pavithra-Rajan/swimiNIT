import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

// List<ProductDataModel> postFromJson(String str) =>
//     List<ProductDataModel>.from(json.decode(str).map((x) => ProductDataModel.fromMap(x)));
class ProductDataModel {
  final String dateOfVisit;
  final String startTime;
  final String endTime;
  final String membershipID;


  ProductDataModel(
      this.dateOfVisit,
      this.startTime,
      this.endTime,
      this.membershipID,
      );
}

class quarterlyReportsPage extends StatefulWidget {
  const quarterlyReportsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return quarterlyReportsPageState();
  }
}

class quarterlyReportsPageState extends State<quarterlyReportsPage> {
  // Fetch content from the json file

  Future getReport() async {
    var response =
    await http.get(Uri.parse('https://swiminit.herokuapp.com/getQuarterlyVisitReport'));
    //print(ProductDataModel.fromJson(jsonDecode(response.body)));
    var data = json.decode(response.body);
    List<ProductDataModel> duesData = [];
    //print(data['swimmersWithDues']);

    for (var u in data['visitsInQuarter']) {
      //print(u["dateOfVisit"]);
      var tempTime = u["endTime"].split(';');
      //print(tempTime);
      if (u["endTime"]!='NULL'){
        var tempTime = u["endTime"].split(';');
        String tempDate = u["dateOfVisit"].substring(0, u["dateOfVisit"].indexOf(';'));
        String startTime = u["dateOfVisit"].split(";")[1];
        ProductDataModel duesData1 =
        ProductDataModel(tempDate,startTime, tempTime[1], u["membershipID"]);
        duesData.add(duesData1);
      }

      //print(u['membershipID']);
    }
    //print(duesData.length);
    return duesData;
    //print(data['swimmersWithDues']);
    //print(data['swimmersWithDues'][0]['membershipID']);
    // print(ProductDataModel.fromJson(jsonDecode(response.body)).dues);
  }

  @override
  Widget build(BuildContext context) {
    int i;

    List<Color> colors = [Color(0xFFFFFFFF), Color(0xFFD2EAF0)];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xFF14839F),
        title: Text('Results',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),

      body: Container(
        margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getReport(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<ProductDataModel>;
                //print('Inside');
                return Table(
                  border: TableBorder.all(
                    color: Colors.white54,
                  ),
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: Color(0xFF93C6D3)),
                      children: <Widget>[
                        SizedBox(
                          height: 64,
                          child: Center(
                            child: Text(
                              "Date of Visit",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                          child: Center(
                            child: Text(
                              "Start Time",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                          child: Center(
                            child: Text(
                              "End Time",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                          child: Center(
                            child: Text(
                              "Membership ID",
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
                          SizedBox(
                            height: 64,
                            child: Center(
                              child: Text(
                                items[i].dateOfVisit.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            child: Center(
                              child: Text(
                                items[i].startTime.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            child: Center(
                              child: Text(
                                items[i].endTime.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            child: Center(
                              child: Text(
                                items[i].membershipID.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}