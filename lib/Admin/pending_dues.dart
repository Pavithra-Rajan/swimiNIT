import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'package:swiminit/Admin/adminnavbar.dart';

// List<ProductDataModel> postFromJson(String str) =>
//     List<ProductDataModel>.from(json.decode(str).map((x) => ProductDataModel.fromMap(x)));
class ProductDataModel {
  final String membershipID;
  final String name;
  final int dues;

  ProductDataModel(
    this.membershipID,
    this.name,
    this.dues,
  );
}

class PendingDuesPage extends StatefulWidget {
  const PendingDuesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PendingDuesPageState();
  }
}

class PendingDuesPageState extends State<PendingDuesPage> {
  // Fetch content from the json file

  Future getDues() async {
    var response =
        await http.get(Uri.parse('https://swiminit.herokuapp.com/getDues'));
    //print(ProductDataModel.fromJson(jsonDecode(response.body)));
    var data = json.decode(response.body);
    List<ProductDataModel> duesData = [];
    //print(data['swimmersWithDues']);

    for (var u in data['swimmersWithDues']) {
      ProductDataModel duesData1 =
          ProductDataModel(u["membershipID"], u["name"], u["dues"]);
      duesData.add(duesData1);
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

      body: Container(
        margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getDues(),
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

      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.07,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF14839F), //background color of button
              //border width and color
              elevation: 0, //elevation of button
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(0)),
              //content padding inside button
            ),
            child: Text(
              'Back',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () => {
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(
            builder: (context) => AdminNavBar()))
            },
          ),
        ),
      ),

      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //   child: FractionallySizedBox(
      //     widthFactor: 1,
      //     heightFactor: 0.07,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         primary: Color(0xFF14839F), //background color of button
      //         //border width and color
      //         elevation: 0, //elevation of button
      //         shape: RoundedRectangleBorder(
      //             //to set border radius to button
      //             borderRadius: BorderRadius.circular(0)),
      //         //content padding inside button
      //       ),
      //       child: Text(
      //         'Download',
      //         style: TextStyle(color: Colors.white, fontSize: 16),
      //       ),
      //       onPressed: () => {},
      //     ),
      //   ),
      // ),
    );
  }
}

// bottomNavigationBar: Container(
// margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
// child: FractionallySizedBox(
// widthFactor: 1,
// heightFactor: 0.07,
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(
// primary: Color(0xFF14839F), //background color of button
// //border width and color
// elevation: 0, //elevation of button
// shape: RoundedRectangleBorder(
// //to set border radius to button
// borderRadius: BorderRadius.circular(0)),
// //content padding inside button
// ),
// child: Text(
// 'Add',
// style: TextStyle(color: Colors.white, fontSize: 16),
// ),
// onPressed: () => {},
// ),
// )),
// );
