import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// List<ProductDataModel> postFromJson(String str) =>
//     List<ProductDataModel>.from(json.decode(str).map((x) => ProductDataModel.fromMap(x)));
class ProductDataModel {
  String? membershipID;
  String? name;
  int? dues;

  ProductDataModel(this.membershipID, this.name, this.dues,);

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    membershipID = json['id'];
    name = json['first_name'];
    dues = json['dues'];
  }
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
    // return data['swimmerWithDues'] ;

  }

  @override
  Widget build(BuildContext context) {
    Future<List<ProductDataModel>?> readJsonData() async {
      final jsondata = await rootBundle.loadString('assets/MOCK_DATA.json');
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => ProductDataModel.fromJson(e)).toList();
    }

    int i;

    List<Color> colors = [Colors.cyan.shade50, Colors.cyan.shade300];

    return Scaffold(
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                          child: Center(
                            child: Text(
                              items[i].name.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
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
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            child: Center(
                              child: Text(
                                items[i].name.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
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
              //throw '';
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
    );
  }
}

