import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/Swimmer_details_admin_class.dart';
import 'package:swiminit/SPM/swimmer_visit_details_spm.dart';
import 'package:swiminit/Admin/swimmer_details_admin_service.dart';
import 'package:swiminit/SPM/receipt_details_service_spm.dart';
import 'package:swiminit/SPM/UserVisitsSpmClass.dart';
import 'package:swiminit/SPM/ReceiptDetailsSpmClass.dart';
//method that assign values to respective datatype vairables

class UserHistoryAdminPage extends StatefulWidget {

  String rollno;
  UserHistoryAdminPage({required this.rollno});

  @override
  State<StatefulWidget> createState() => UserHistoryAdminPageState();
}

class UserHistoryAdminPageState extends State<UserHistoryAdminPage> {
  bool admin= true;
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
    print(widget.rollno);
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
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 0),
                child: SingleChildScrollView(

                  child: FutureBuilder(
                    future: SwimmerDetailsServices.getSwimmersDetails(widget.rollno, admin),
                    builder: (context,data) {
                      if (data.hasError) {
                        return Center(child: Text("${data.error}"));
                      }
                      else if (data.hasData) {
                        var posts = data.data as SwimmerDetailsAdmin;
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
                                                    image: AssetImage('lib/Resources/pic-1.png')))),
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
                                                posts.name,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                posts.role,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black, fontSize: 13),
                                              ),
                                              Text(
                                                posts.membershipId,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black, fontSize: 13),
                                              ),
                                              Text(
                                                posts.emailId,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black, fontSize: 13),
                                              ),
                                              Text(
                                                posts.contact1,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black, fontSize: 13),
                                              ),
                                              Text(
                                                posts.contact2,
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
                                                posts.numberOfFreeTrials.toString() + ' visits',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black, fontSize: 13),
                                              ),
                                              Text(
                                                'Dues: Rs. ' + posts.dues.toString(),
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
                        // print(posts);
                        //var items = data.data as List<ProductDataModel>;
                      }
                      else {
                        return Center(
                            child: CircularProgressIndicator(),
                        );
                      }
                    },

                  ),

                ),
              ),

              Container(
                margin: EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 0),
                child: SingleChildScrollView(

                  child: FutureBuilder(
                    future: ReceiptDetailsServices.getSwimmersReceiptDetails(widget.rollno),
                    builder: (BuildContext context,data) {
                      if (data.hasError) {
                        print("hello");
                        return Center(child: Text(""));
                      }
                      else if (data.hasData) {

                        var receipt = data.data as ReceiptDetailsSpm;

                        //var items = data.data as List<ProductDataModel>;
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
                                              Text('Receipt ID: ' + receipt.receipt.receiptId,
                                                style: GoogleFonts.poppins(color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              Text('Amount Paid: Rs. ' + receipt.receipt.moneyPaid.toString(),
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
                                              Text('Date: ' + receipt.receipt.paymentDate,
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
                      else {
                        return Center(
                          child: Text(" "),);
                      }
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 0),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: SwimmerVisitServices.getSwimmersVisitDetails(widget.rollno),
                    builder: (context, data) {
                      if (data.hasError) {
                        return Center(child: Text("${data.error}"));
                      }
                      else if (data.hasData) {
                        var items = data.data as UserVisitsSpm;
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
                            for (var i = 0; i < items.visits.length; i++) TableRow(
                              decoration: BoxDecoration(
                                color: colors[i % 2],
                              ),
                              children: <Widget>[
                                SizedBox(
                                  height: 64,
                                  child: Center(
                                    child: Text(
                                      items.visits[i].dateOfVisit.split(";")[0],
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
                                      items.visits[i].dateOfVisit.split(";")[1],
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
                                      items.visits[i].endTime.split(";")[1],
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
                        //var items = data.data as List<ProductDataModel>;
                      }
                      else {
                        return Center(
                          child: Text(" "),);
                      }
                    },
                  ),
                ),
              ),
              downloadButton(),
            ],
          )
      ),
    );
  }
}