import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ProductDataModel {
  final String paymentDate;
  final String receiptID;
  final String membershipID;
  final int moneyPaid;


  ProductDataModel(
      this.membershipID, this.paymentDate, this.receiptID, this.moneyPaid,
      );
}

class CollectionsReport extends StatefulWidget {
  const CollectionsReport({Key? key}) : super(key: key);

  @override
  State<CollectionsReport> createState() => _CollectionsReportState();
}

class _CollectionsReportState extends State<CollectionsReport> {

  Future getReport() async {
    var response =
    await http.get(Uri.parse('https://swiminit.herokuapp.com/getCollectionsReport'));
    var data = json.decode(response.body);
    List<ProductDataModel> duesData = [];

    for (var u in data['collectionInQuarter']) {
      String membershipID = u["membershipID"];
      int moneyPaid = u["moneyPaid"];
      String paymentDate = u["paymentDate"];
      String receiptID = u["receiptID"];

      ProductDataModel duesData1 =
      ProductDataModel(membershipID, paymentDate, receiptID, moneyPaid);
      duesData.add(duesData1);
    }
    return duesData;
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
                              "Receipt ID",
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
                              "Payment date",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                          child: Center(
                            child: Text(
                              "Amount Paid",
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
                                items[i].receiptID,
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
                                items[i].membershipID,
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
                                items[i].paymentDate,
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
                                "Rs. ${items[i].moneyPaid.toString()}",
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
                //var items = data.data as List<ProductDataModel>;

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
