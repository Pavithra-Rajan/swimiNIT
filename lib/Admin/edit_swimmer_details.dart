import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../SPM/Person.dart';
import 'package:http/http.dart';

// class ProductDataModel {
//   final String membershipID;
//   final String name;
//   final String role;
//   final String emailID;
//   final String contact1;
//   final String contact2;
//   final int fees;
// }

class EditSwimmerPage extends StatefulWidget {
  const EditSwimmerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditSwimmerDetailsState();
}

class _EditSwimmerDetailsState extends State<EditSwimmerPage> {
  List<String> roles = ['Student', 'Faculty', 'Faculty Referral'];
  String dropDownVal = 'Student';
  Person p = Person(
      "name",
      "lib/Resources/pic-1.png",
      "rollno",
      "enteredAt",
      "noOfVisits",
      "dues",
      "receiptID",
      "amtPaid",
      "datePaid",
      "Student",
      "mailID",
      "contact1",
      "contact2");

  Widget detailsWidget(Person p) {
    TextEditingController _name = TextEditingController();
    return Padding(
        padding: EdgeInsets.all(0),
        child: Column(
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
              Align(
                  alignment: Alignment(-0.42, 1),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: p.name,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF14839F)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF14839F)),
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
                          p.role = dropDownVal;
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
                          hintText: p.mailID,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF14839F)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF14839F)),
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
                          hintText: p.contact1,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF14839F)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF14839F)),
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
                          hintText: p.contact2,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF14839F)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF14839F)),
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
                        p.receiptID,
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
                        p.datePaid,
                        style: GoogleFonts.poppins(),
                      ))),
              SizedBox(height: 20),
              Stack(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(-0.7, 1),
                          child: Text(
                              "Quarterly Fees",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment(-0.42, 1),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                            alignment: Alignment.centerLeft,
                            width: 250,
                            child: Text(
                              p.role.compareTo(roles[0]) == 0
                                  ? "Rs 200"
                                  : "Rs 500",
                              style: GoogleFonts.poppins(),
                            )
                          )
                        ),
                    ],
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment(0.5, 0),
                      child: Text(
                        "Fees Paid",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.2, 1),
                        child: Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                            alignment: Alignment.centerRight,
                            width: 250,
                            child: Text(
                              p.amtPaid,
                              style: GoogleFonts.poppins(),
                            )
                        )
                      ),
                    ],
                  ),
                ]
              ),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: [
                SizedBox(
                    height: 10,
                ),
                detailsWidget(p)
              ]
        )
    );
  }
}
