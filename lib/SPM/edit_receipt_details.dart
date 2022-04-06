import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'Person.dart';

class EditReceiptPage extends StatefulWidget {
  const EditReceiptPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditReceiptPageState();
}

enum currState {searching, editing, submitted}

class EditReceiptPageState extends State<EditReceiptPage>
{
  currState state = currState.editing;
  Person p = Person("name", "profileImg", "rollno", "enteredAt", "noOfVisits", "dues", "receiptID", "amtPaid", "datePaid", "role", "mailID", "contact1", "contact2");
  String membershipID = "-1";
  final TextEditingController _recieptController = TextEditingController();

  DateTime _selectedDate = DateTime(1999);

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  Future getSwimmer() async {
    var response = await http.get(Uri.parse(
        'https://swiminit.herokuapp.com/getdetails?membershipID=B190621CS&admin=False'));
    var data = json.decode(response.body);

    p = Person(data["name"], "profileImg", data["membershipID"],
        "enteredAt", "noOfVisits", data["dues"].toString(), "receiptID",
        "amtPaid", "datePaid", data["roles"], data["emailID"], "contact1", "contact2");
    return p;
  }

  Widget detailsWidget(Person p) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: FutureBuilder(
          future: getSwimmer(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Membership ID",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.rollno,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Name",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.name,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Role",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.role,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Email ID",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        p.mailID,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: TextField(
                        autocorrect: false,
                        cursorColor: Color(0xFF14839F),
                        controller: _recieptController,
                        decoration: const InputDecoration(
                          hintText: "Receipt ID",
                          prefixIcon: Icon(Icons.person, color: Color(0xFF14839F)),
                        ),
                      )
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: ElevatedButton(child: Text(_selectedDate.year<=1999?'Add Date':"${_selectedDate.day} ${_selectedDate.month} ${_selectedDate.year}"), onPressed: _pickDateDialog),
                    ),
                  ]
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    if(state == currState.searching)
    {
      return Container();
    }
    else if(state == currState.editing)
    {
      return Scaffold(
        body: SingleChildScrollView(
          child: detailsWidget(p)
        ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.08,
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
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => {
                  setState(() {

                  })
                },
              ),
            )
        ),
      );
    }
    else
    {
        return Container();
    }
  }

}
