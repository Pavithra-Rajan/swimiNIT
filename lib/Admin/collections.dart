import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/pending_dues.dart';

class CollectionsReport extends StatefulWidget {
  const CollectionsReport({Key? key}) : super(key: key);

  @override
  State<CollectionsReport> createState() => _CollectionsReportState();
}

class _CollectionsReportState extends State<CollectionsReport> {

  @override
  Widget build(BuildContext context) {
    int i;

    List<Color> colors = [Color(0xFFFFFFFF), Color(0xFFD2EAF0)];
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
        child: SingleChildScrollView(
          child: FutureBuilder(
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
                              "Name",
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
                              "Dues",
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
                                items[i].membershipID.toString(),
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
                                items[i].name.toString(),
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
                                items[i].dues.toString(),
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
