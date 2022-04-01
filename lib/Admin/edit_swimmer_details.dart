import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../SPM/Person.dart';

class EditSwimmerPage extends StatefulWidget {
  const EditSwimmerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditSwimmerDetailsState();
}

class _EditSwimmerDetailsState extends State<EditSwimmerPage>
{
  List<String> roles = ['Student', 'Faculty', 'Faculty Referral'];
  String dropDownVal = 'Student';
  Widget detailsWidget(Person p)
  {
    TextEditingController _name = TextEditingController();
    return Padding(
        padding: EdgeInsets.all(0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment(-0.71, 10),
                child: Text("Membership ID",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                  height: 10
              ),
              Align(
                alignment: Alignment(-0.75, 1),
                child: Text(p.rollno,
                  style: GoogleFonts.poppins(),
                ),
              ),
              SizedBox(
                  height: 20
              ),
              Align(
                alignment: Alignment(-0.75, 1),
                child: Text("Name",
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
                        ),
                        style: GoogleFonts.poppins(),
                      )
                  )
              ),
              SizedBox(
                  height: 20
              ),
              Align(
                alignment: Alignment(-0.75, 1),
                child: Text("Role",
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
                        setState(() { dropDownVal = newValue!;});
                      },
                    ),
                  )
              ),
              SizedBox(
                  height: 20
              ),
              Align(
                alignment: Alignment(-0.75, 1),
                child: Text("Email ID",
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
                        ),
                        style: GoogleFonts.poppins(),
                      )
                  )
              ),
              SizedBox(
                  height: 20
              ),
              Align(
                alignment: Alignment(-0.75, 1),
                child: Text("Contact 1",
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
                        ),
                        style: GoogleFonts.poppins(),
                      )
                  )
              ),
              SizedBox(
                  height: 20
              ),
              Align(
                alignment: Alignment(-0.75, 1),
                child: Text("Contact 2",
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
                        ),
                        style: GoogleFonts.poppins(),
                      )
                  )
              ),
              SizedBox(
                  height: 20
              ),
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Person p = Person("name", "lib/Resources/pic-1.png", "rollno", "enteredAt", "noOfVisits", "dues", "receiptID", "amtPaid", "datePaid", "role", "mailID", "contact1", "contact2");
    return Column(
        children: [
          SizedBox(height: 10,),
          detailsWidget(p)
        ]
    );
  }
}