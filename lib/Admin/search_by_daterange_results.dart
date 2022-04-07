import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/adminnavbar.dart';
import 'dart:convert';
import 'package:swiminit/SPM/get_date_visits_spm.dart';
import 'package:swiminit/SPM/get_date_visits_service_spm.dart';
// import 'package:swiminit/product_data_model.dart';
import 'package:swiminit/SPM/search.dart';
import 'package:swiminit/SPM/spmnavbar.dart';


class SearchByDateRange extends StatefulWidget {

  final String fromdate;
  final String enddate;
  SearchByDateRange({required this.fromdate, required this.enddate});


  @override
  State<StatefulWidget> createState() {
    return SearchByDateRangeState();
  }
}

class SearchByDateRangeState extends State<SearchByDateRange> {
  // Fetch content from the json file
  // Widget downloadButton() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 20),
  //     alignment: Alignment(0, 0),
  //     child: FractionallySizedBox(
  //         widthFactor: 0.25,
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             primary: Color(0xFF93C6D3), // background
  //             onPrimary: Colors.white, // foreground
  //             minimumSize: Size(175, 45),
  //           ),
  //           child: Text(
  //             'Download',
  //             style: GoogleFonts.poppins(
  //                 color: Colors.black,
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //           onPressed: () {},
  //         )),
  //   );
  // }
  @override
  Widget build(BuildContext context) {


    int i;



    List<Color> colors = [Color(0xFFFFFFFF), Color(0xFFD2EAF0)];

    return Container(

      child:Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color(0xFF14839F),

          title: Text('Results',

            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),


        body: Container(
          margin: EdgeInsets.only(left: 35, top:10, right: 35, bottom:0),
          child:SingleChildScrollView(


            child:Column(
                children: <Widget>[
                  FutureBuilder(
                    future: SwimmersVisitsDate.getSwimmersVisitsDate(widget.fromdate,widget.enddate),
                    builder: (context, data){
                      if(data.hasError){
                        return Center(child: Text("${data.error}"));
                      }
                      else if(data.hasData){
                        var items = data.data as GetDateVisitsSpm;

                        return Table(

                          border:TableBorder.all(
                            color: Colors.blueGrey,
                          ),
                          children: [
                            TableRow(
                              decoration:
                              const BoxDecoration(color: Color(0xFF189BBA)),
                              children: const <Widget>[
                                SizedBox(
                                  height: 64,
                                  child: Center(
                                    child: Text(
                                      "Membership ID",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 64,
                                  child: Center(
                                    child: Text(
                                      "Date Of Visit",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 64,
                                  child: Center(
                                    child: Text(
                                      "Start-End time",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],

                            ),

                            for (i = 0; i < items.visits.length; i++)
                              TableRow(
                                decoration: BoxDecoration(
                                  color: colors[i % 2],
                                ),
                                children: <Widget>[
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        items.visits[i].membershipId,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        items.visits[i].dateOfVisit.split(";")[0],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        items.visits[i].dateOfVisit.split(";")[1],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        );
                        //var items = data.data as List<ProductDataModel>;
                        //var items = data.data as List<ProductDataModel>;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      //throw '';
                    },
                  ),
                  SizedBox(height: 20),
                ]
            ),



          ),
        ),


      ),
    );
  }
}
