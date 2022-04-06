import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'Swimmer.dart';
import 'dart:convert';

class EditSwimmerPage extends StatefulWidget {
  const EditSwimmerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditSwimmerDetailsState();
}

class _EditSwimmerDetailsState extends State<EditSwimmerPage> {
  String membershipID = "B190657CS";
  List<String> roles = ['Student', 'Faculty', 'Faculty Dependant'];
  String dropDownVal = 'Student';
  Swimmer s = Swimmer("membershipID", "name", "role", "emailID", "contact1",
      "contact2", "fees");

  Future getSwimmer() async {
    var response = await http.get(Uri.parse(
        'https://swiminit.herokuapp.com/getdetails?membershipID=$membershipID&admin=True'));
    var data = json.decode(response.body);
    s.membershipID = data["membershipID"];
    s.name = data["name"];
    s.role = data["role"];
    s.emailID = data["emailID"];
    s.contact1 = data["contact1"];
    s.contact2 = data["contact2"];
    s.fees = data["fees"].toString();

    return s;
  }

  Widget detailsWidget(Swimmer s) {
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
                      alignment: Alignment(-0.71, 10),
                      child: Text(
                        "Membership ID",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        s.membershipID,
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
                    Align(
                        alignment: Alignment(-0.42, 1),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: s.name,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF14839F)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF14839F)),
                                ),
                              ),
                              style: GoogleFonts.poppins(),
                            ))),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Role",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.42, 1),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 250,
                          child: DropdownButton(
                            value: dropDownVal,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: roles.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownVal = newValue!;
                                s.role = dropDownVal;
                              });
                            },
                          ),
                        )),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Email ID",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.42, 1),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: s.emailID,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF14839F)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF14839F)),
                                ),
                              ),
                              style: GoogleFonts.poppins(),
                            ))),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Contact 1",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.42, 1),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: s.contact1,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF14839F)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF14839F)),
                                ),
                              ),
                              style: GoogleFonts.poppins(),
                            ))),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Contact 2",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.42, 1),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: s.contact2,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF14839F)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF14839F)),
                                ),
                              ),
                              style: GoogleFonts.poppins(),
                            ))),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.75, 1),
                      child: Text(
                        "Receipt ID",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment(-0.42, 1),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: Text(
                              "RA03",
                              style: GoogleFonts.poppins(),
                            ))),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment(-0.7, 1),
                      child: Text(
                        "Date Of Payment",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment(-0.42, 1),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: Text(
                              "04-04-2022",
                              style: GoogleFonts.poppins(),
                            ))),
                    SizedBox(height: 20),
                    Stack(children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment(-0.7, 1),
                            child: Text(
                              "Quarterly Fees",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                              alignment: Alignment(-0.42, 1),
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                                  alignment: Alignment.centerLeft,
                                  width: 250,
                                  child: Text(
                                    s.role.compareTo(roles[0]) == 0
                                        ? "Rs 200"
                                        : "Rs 500",
                                    style: GoogleFonts.poppins(),
                                  ))),
                        ],
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment(0.5, 0),
                            child: Text(
                              "Fees Paid",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                              alignment: Alignment(-0.2, 1),
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                                  alignment: Alignment.centerRight,
                                  width: 250,
                                  child: Text(
                                    s.fees,
                                    style: GoogleFonts.poppins(),
                                  ))),
                        ],
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment(0, 0),
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Submit",
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ]);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          detailsWidget(s)
        ]),
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
              onPressed: () => {},
            ),
          )),
    );
  }
}
