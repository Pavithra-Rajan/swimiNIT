import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// import 'package:swiminit/product_data_model.dart';

class ProductDataModel {
  //data Type
  int? id;
  String? firstName;
  String? date;
  String? time;

// constructor
  ProductDataModel({
    this.id,
    this.firstName,
    this.date,
    this.time,
  });

  //method that assign values to respective datatype vairables
  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    date = json['date'];
    time = json['time'];
  }
}

class SearchByDateRange extends StatefulWidget {

  const SearchByDateRange({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchByDateRangeState();
  }
}

class SearchByDateRangeState extends State<SearchByDateRange> {
  // Fetch content from the json file

  @override
  Widget build(BuildContext context) {
    Future<List<ProductDataModel>> readJsonData() async {
      final jsondata = await rootBundle.loadString('assets/MOCK_DATA.json');
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => ProductDataModel.fromJson(e)).toList();
    }

    int i;

    List<Color> colors = [Colors.cyan.shade50, Colors.cyan.shade300];

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 35, top:10, right: 35, bottom:0),
        child:SingleChildScrollView(
          child: FutureBuilder(
            future: readJsonData(),
            builder: (context, data){
              if(data.hasError){
                return Center(child: Text("${data.error}"));
              }
              else if(data.hasData){
                var items = data.data as List<ProductDataModel>;
                return Table(
                  border:TableBorder.all(
                    color: Colors.blueGrey,
                ),
                children: [
                  TableRow(
                    decoration:
                        const BoxDecoration(color: Colors.lightBlueAccent),
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
                              items[i].firstName.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                          child: Center(
                            child: Text(
                              "26-07-2001",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                          child: Center(
                            child: Text(
                              "06:00:00-07:00:00",
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
