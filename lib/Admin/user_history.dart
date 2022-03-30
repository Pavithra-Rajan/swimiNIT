import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Person.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({Key? key}) : super(key: key);

  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  Person P = Person('Varun Anilkumar', 'lib/Resources/pic-1.png', "B190621CS", "16:36", "4", "0", "R-043657839", "200", "24-01-2022", "Student","varun_b190621cs@nitc.ac.in","6285435321","9061219855");


  Widget userDetails(Person) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 173,
          child: Card(
            color: Color(0xFF93C6D3),
            shadowColor: Color(0xFFFFFFFF),
            margin: EdgeInsets.fromLTRB(20, 20, 20, 8),
            shape:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white)
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(-0.98,-1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 8, 2, 5),
                    child: Container(
                        width: 55.0,
                        height: 55.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(Person.profileImg)
                            )
                        )),
                  ),
                ),
                Align(
                    alignment: Alignment(-0.20, -1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(Person.name,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(Person.role, style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                          ),
                          Text(Person.rollno,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                          ),
                          Text(Person.mailID,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                          ),
                          Text(Person.contact1,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                          ),
                          Text(Person.contact2,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                          ),

                        ],
                      ),
                    )
                ),
                Align(
                    alignment: Alignment(1,-1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 7, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(Person.noOfVisits+' visits',
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                          ),
                          Text('Dues: Rs. '+Person.dues,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                          )
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

  Widget userReceipt(Person) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          height: 80,
          child: Card(
            color: Color(0xFF93C6D3),
            shadowColor: Color(0xFFFFFFFF),
            margin: EdgeInsets.fromLTRB(20, 8, 20, 10),
            shape:  OutlineInputBorder(
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
                          Text('Receipt ID: '+ Person.receiptID,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text('Amount Paid: Rs. '+Person.amtPaid, style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                ),
                Align(
                    alignment: Alignment(1,-1),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 7, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Date: ' + Person.datePaid,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
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

  Widget userVisits(Person){
    return Padding(
    padding: const EdgeInsets.all(0),
    child: Container(

    margin: EdgeInsets.only(left: 35, top:10, right: 35, bottom:0),
    child:SingleChildScrollView(

      child: FutureBuilder(
      future: ReadJsonData(),
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
        decoration: const BoxDecoration(
        color: Colors.lightBlueAccent
        ),
        children: <Widget>[
        Container(
        height: 64,
        child:Center(
        child:Text(
        "Membership ID",
        textAlign:TextAlign.center,
        style: TextStyle(
        fontWeight: FontWeight. bold),),

        ),

        ),
        Container(

        height: 64,
        child:Center(
        child:Text(
        "Date Of Visit",
        textAlign:TextAlign.center,
        style: TextStyle(
        fontWeight: FontWeight. bold),),

        ),

        ),
        Container(
        height: 64,
        child:Center(
        child:Text(
        "Start-End time",
        textAlign:TextAlign.center,
        style: TextStyle(
        fontWeight: FontWeight. bold),
        ),


        ),

        ),
        ],
        ),
        for (i=0;i < items.length;i++) TableRow(

        decoration: BoxDecoration(
        color: colors[i%2],

        ),
        children: <Widget> [
        Container(
        height: 64,
        child:Center(
        child:Text(
        items[i].first_name.toString(),
        textAlign:TextAlign.center,
        ),

        ),

        ),
        Container(

        height: 64,
        child:Center(
        child:Text(
        "26-07-2001",
        textAlign:TextAlign.center,
        ),

        ),

        ),
        Container(
        height: 64,
        child:Center(
        child:Text(
        "06:00:00-07:00:00",
        textAlign:TextAlign.center,

        ),


        ),

        ),
        ],
        ),



        ],
        );
        //var items = data.data as List<ProductDataModel>;

    }
    else
    {
    return Center(child: CircularProgressIndicator(),);
    }
    throw '';
    },

    ),

    ),

    )
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: false,
          backgroundColor: Color(0xFF14839F),
          title: Text('User History', style: GoogleFonts.poppins(color: Colors.white)
          ),
        ),

        body:
        Column(
          children: [
            userDetails(P),
            userReceipt(P),
            userVisits(P),
          ],
        )

    );
  }

}






import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// import 'package:swiminit/product_data_model.dart';


class UserHistoryTable{
  //data Type
  String? dateVisit;
  String? timeEntry;
  String? timeExit;


// constructor
UserHistoryTable(
      {
        this.dateVisit,
        this.timeEntry,
        this.timeExit,
      }
      );

  //method that assign values to respective datatype vairables
  UserHistoryTable.fromJson(Map<String,dynamic> json)
  {
    dateVisit = json['dateVisit'];
    timeEntry =json['timeEntry'];
    timeExit = json['timeExit'];

  }
}


class SearchByDateRange extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchByDateRangeState();

  }
}

class SearchByDateRangeState extends State<SearchByDateRange> {


  // Fetch content from the json file

  @override
  Widget build(BuildContext context) {
    Future<List<UserHistoryTable>>ReadJsonData() async{
      final jsondata= await rootBundle.loadString('assets/MOCK_DATA.json');
      final list=json.decode(jsondata) as List<dynamic>;
      return list.map((e)=>UserHistoryTable.fromJson(e)).toList();
    }
    var i;

    List<Color> colors = [Colors.cyan.shade50, Colors.cyan.shade300];
    return Container(

      child:Scaffold(

        body: Container(
          margin: EdgeInsets.only(left: 35, top:10, right: 35, bottom:0),
          child:SingleChildScrollView(


            child: FutureBuilder(
              future: ReadJsonData(),
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
                        decoration: const BoxDecoration(
                            color: Colors.lightBlueAccent
                        ),
                        children: <Widget>[
                          Container(
                            height: 64,
                            child:Center(
                              child:Text(
                                "Membership ID",
                                textAlign:TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight. bold),),

                            ),

                          ),
                          Container(

                            height: 64,
                            child:Center(
                              child:Text(
                                "Date Of Visit",
                                textAlign:TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight. bold),),

                            ),

                          ),
                          Container(
                            height: 64,
                            child:Center(
                              child:Text(
                                "Start-End time",
                                textAlign:TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight. bold),
                              ),


                            ),

                          ),
                        ],
                      ),
                      for (i=0;i < items.length;i++) TableRow(

                        decoration: BoxDecoration(
                          color: colors[i%2],

                        ),
                        children: <Widget> [
                          Container(
                            height: 64,
                            child:Center(
                              child:Text(
                                items[i].first_name.toString(),
                                textAlign:TextAlign.center,
                              ),

                            ),

                          ),
                          Container(

                            height: 64,
                            child:Center(
                              child:Text(
                                "26-07-2001",
                                textAlign:TextAlign.center,
                              ),

                            ),

                          ),
                          Container(
                            height: 64,
                            child:Center(
                              child:Text(
                                "06:00:00-07:00:00",
                                textAlign:TextAlign.center,

                              ),


                            ),

                          ),
                        ],
                      ),



                    ],
                  );
                  //var items = data.data as List<ProductDataModel>;

                }
                else
                {
                  return Center(child: CircularProgressIndicator(),);
                }
                throw '';
              },

            ),

          ),),
        bottomNavigationBar:

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            SizedBox(
              height:40, //height of button
              width:384, //width of button equal to parent widget
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[900], //background color of button
                  //border width and color
                  elevation: 0, //elevation of button
                  shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(3)
                  ),
                  //content padding inside button
                ),
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: ()=> {},
              ),
            )

          ],


        ),
      ),);



  }

}