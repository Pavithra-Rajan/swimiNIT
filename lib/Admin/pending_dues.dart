import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// List<ProductDataModel> postFromJson(String str) =>
//     List<ProductDataModel>.from(json.decode(str).map((x) => ProductDataModel.fromMap(x)));

class ProductDataModel {
  //data Type

  String? mID;
  String? first_name;
  int? dues;

// constructor
  ProductDataModel({
    this.mID,
    this.first_name,
    this.dues,
  });

  //method that assign values to respective datatype vairables
  ProductDataModel.fromJson(Map<String, dynamic> json) {

    first_name = json['first_name'];
    mID = json['mID'];
    dues = json['dues'];
  }
}
class PendingDuesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PendingDuesPageState();
  }
}

class PendingDuesPageState extends State<PendingDuesPage> {
  // Fetch content from the json file

  @override
  Widget build(BuildContext context) {
    Future<List<ProductDataModel>> ReadJsonData() async {
      final jsondata = await rootBundle.loadString('assets/DUES_DATA.json');
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => ProductDataModel.fromJson(e)).toList();
      // final response = await http
      //     .get(Uri.parse('https://swiminit.herokuapp.com/getDues'));
      // print(response);
      //
      //
      // if (response.statusCode == 200) {
      //   print(response);
      //   print("Buha");
      //   //return ProductDataModel.fromJson(jsonDecode(response.body));
      //   final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      //
      //   return [];
      // } else {
      //   // If the server did not return a 200 OK response,
      //   // then throw an exception.
      //   throw Exception('Failed to load album');
      // }


    }

    var i;

    List<Color> colors = [Colors.cyan.shade50, Colors.cyan.shade300];
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Results'),
          backgroundColor: Color(0xFF14839F),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 35, top: 20, right: 35, bottom: 0),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: ReadJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else if (data.hasData) {
                  var items = data.data as List<ProductDataModel>;

                  return Table(
                    border: TableBorder.all(
                      color: Colors.white,
                    ),
                    children: [
                      TableRow(
                        decoration:
                        const BoxDecoration(color: Color(0xFF14839F)),
                        children: <Widget>[
                          Container(
                            height: 64,
                            child: Center(
                              child: Text(
                                "Membership ID",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 64,
                            child: Center(
                              child: Text(
                                "Name",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 64,
                            child: Center(
                              child: Text(
                                "Dues",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
                                  items[i].mID.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 64,
                              child: Center(
                                child: Text(
                                  items[i].first_name.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 64,
                              child: Center(
                                child: Text(
                                  items[i].dues.toString(),
                                  textAlign: TextAlign.center,
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
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40, //height of button
              width: 384, //width of button equal to parent widget
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF14839F), //background color of button
                  //border width and color
                  elevation: 0, //elevation of button
                  shape: RoundedRectangleBorder(
                    //to set border radius to button
                      borderRadius: BorderRadius.circular(3)),
                  //content padding inside button
                ),
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

