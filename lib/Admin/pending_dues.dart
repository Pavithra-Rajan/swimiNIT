import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// List<ProductDataModel> postFromJson(String str) =>
//     List<ProductDataModel>.from(json.decode(str).map((x) => ProductDataModel.fromMap(x)));
class ProductDataModel {
  final String membershipID;
  final String name;
  final int dues;

  ProductDataModel(this.membershipID, this.name, this.dues,);
}
class PendingDuesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PendingDuesPageState();
  }
}

class PendingDuesPageState extends State<PendingDuesPage> {
  // Fetch content from the json file

  Future getDues() async {
    var response = await http
        .get(Uri.parse('https://swiminit.herokuapp.com/getDues'));
    //print(ProductDataModel.fromJson(jsonDecode(response.body)));
    var data=json.decode(response.body);
    List <ProductDataModel> duesData=[];
    //print(data['swimmersWithDues']);

    for (var u in data['swimmersWithDues']){
      ProductDataModel duesData1=ProductDataModel(u["membershipID"],u["name"],u["dues"]);
      duesData.add(duesData1);
      //print(u['membershipID']);
    }
    //print(duesData.length);
    return duesData;
    //print(data['swimmersWithDues']);
    //print(data['swimmersWithDues'][0]['membershipID']);
    // print(ProductDataModel.fromJson(jsonDecode(response.body)).dues);
    return data['swimmerWithDues'] ;

  }

  @override
  Widget build(BuildContext context) {
    var i;

    List<Color> colors = [Colors.cyan.shade50, Colors.cyan.shade300];
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Pending Dues'),
          backgroundColor: Color(0xFF14839F),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 35, top: 20, right: 35, bottom: 0),
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
                                  items[i].membershipID.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 64,
                              child: Center(
                                child: Text(
                                  items[i].name.toString(),
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

