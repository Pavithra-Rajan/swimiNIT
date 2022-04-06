import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swiminit/Admin/adminaddspm.dart';

import 'adminnavbar.dart';

class ProductDataModel {
  final String contact1;
  final String contact2;
  final String name;

  ProductDataModel(this.contact1, this.contact2, this.name);

}

class ViewPoolManagers extends StatefulWidget {
  const ViewPoolManagers({Key? key}) : super(key: key);

  @override
  State<ViewPoolManagers> createState() => _ViewPoolManagers();
}

class _ViewPoolManagers extends State<ViewPoolManagers> {
  // Fetch content from the json file

  Future getSPM() async {
    var response =
        await http.get(Uri.parse('https://swiminit.herokuapp.com/getSPMs'));
    //print(ProductDataModel.fromJson(jsonDecode(response.body)));
    var data = json.decode(response.body);
    List<ProductDataModel> duesData = [];
    // print(data['spms']);

    for (var u in data['spms']) {
      ProductDataModel duesData1 =
          ProductDataModel(u["contact1"], u["contact2"], u["name"]);
      //print(u["contact1"]);
      duesData.add(duesData1);
      //print(duesData1);
    }

    //print(duesData[0].contact1);

    return duesData;
  }

  Future delSPM(String cont1) async{
    String contact1 = cont1;
    var response =
    await http.delete(Uri.parse('https://swiminit.herokuapp.com/deleteSPM?contact1=$contact1'));
    //print(ProductDataModel.fromJson(jsonDecode(response.body)));
    var data = json.decode(response.body);
    List<ProductDataModel> duesData = [];

     return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: SingleChildScrollView(
              child: FutureBuilder(
                  future: getSPM(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<ProductDataModel>;
                      return Container(
                        width: 1500,
                        height: 1500,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: ListView(
                          children: [
                            for (int i = 0; i < items.length; i++)
                              buildCard(items[i], i)
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))),
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
                'Add',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () => {
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(
              builder: (context) => AdminAddSPM())),

              },
            ),
          )
      ),
    );
  }

  Widget buildCard(ProductDataModel managers, int i) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Card(
        color: Color(0xFF93C6D3),
        shadowColor: Color(0xFF93C6D3),
        child: ExpandablePanel(
            header: Padding(
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(-0.98, 1),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(7, 5, 0, 3),
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("lib/Resources/pic-1.png"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.40, 1),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(30, 6, 0, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                managers.name,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                managers.contact1,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 12),
                              ),
                              Text(
                                managers.contact2,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        )),
                  ],
                )),
            expanded: Align(
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RawMaterialButton(
                      onPressed: () async{
                        await delSPM(managers.contact1).then((value) => getSPM());
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => AdminNavBar()));
                        },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      fillColor: Color(0xFFDF4759),
                    ),
                  )),
            ),
            collapsed: Container()),
      ),
    );
  }
}
