import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:expandable/expandable.dart';
import '../SPM/Person.dart';

class PoolStatusPage extends StatefulWidget {
  const PoolStatusPage({Key? key}) : super(key: key);

  @override
  State<PoolStatusPage> createState() => _PoolStatusPageState();
}

class _PoolStatusPageState extends State<PoolStatusPage>
{
  List<Person> persons = [
    Person('Varun Anilkumar', 'lib/Resources/pic-1.png', "B190621CS", "16:36", "4", "0", "R-043657839", "200", "24-01-2022","student","varun_b190621cs@nitc.ac.in","6285435321","9061219855"),
    Person('Lenoah Chacko', 'lib/Resources/pic-1.png', "B190657CS", "16:44", "8", "0", "R-043657239", "400", "22-01-2022","student","varun_b190621cs@nitc.ac.in","6285435321","9061219855"),
    Person('Joseph Mani', 'lib/Resources/pic-1.png', "B190529CS", "17:05", "2", "0", "R-021657989", "200", "12-01-2022","student","varun_b190621cs@nitc.ac.in","6285435321","9061219855")
  ];

  Widget buildCard(Person p) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: Color(0xFF93C6D3),
          child: ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                  color: Color(0xFF93C6D3),
                  shadowColor: Color(0xFF93C6D3),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment(-0.98,1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(p.profileImg)
                                    )
                                )),
                          ),
                        ),
                        Align(
                            alignment: Alignment(-0.35, 1),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(p.name,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(p.rollno,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                                  )
                                ],
                              ),
                            )
                        ),
                        Align(
                            alignment: Alignment(1,1),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text('Entered at '+p.enteredAt,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                                  ),
                                  Text(p.rollno,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                                  )
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              collapsed: Container(),
              expanded:
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                alignment: Alignment(0,0),
                child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFDF4759), // background
                        onPrimary: Colors.white, // foreground
                        minimumSize: Size(175,35),
                      ),
                      child: Text('Exit',style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),),
                      onPressed: () {},
                    )),
              )
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: Column(
          children: <Widget>[
            Column(
                children: persons.map((p) {
                  return buildCard(p);
                }).toList()
            )
          ],
        ),
      ),
    );
  }
}

