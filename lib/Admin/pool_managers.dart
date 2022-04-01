import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../SPM/spm.dart';

class ViewPoolManagers extends StatefulWidget {
  const ViewPoolManagers({Key? key}) : super(key: key);

  @override
  State<ViewPoolManagers> createState() => _ViewPoolManagers();
}

class _ViewPoolManagers extends State<ViewPoolManagers> {
  List<SPM> managers = [
    SPM("1234567890", "0987654321", "John Doe", "123456"),
    SPM("1234567890", "0987654321", "John Wick", "123456"),
    SPM("1234567890", "0987654321", "John Cena", "123456")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        for (int i = 0; i < managers.length; i++) buildCard(i),
      ],
    ));
  }

  Widget buildCard(int i) {
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
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("lib/Resources/pic-1.png"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.35, 1),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                managers[i].name,
                                style: GoogleFonts.rubik(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                managers[i].contact1,
                                style: GoogleFonts.rubik(color: Colors.black),
                              )
                            ],
                          ),
                        )),
                  ],
                )),
            expanded: Align(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        managers.removeAt(i);
                      });
                    },
                    child: Text("Delete"),
                    fillColor: Colors.red,
              ),
            )),
            collapsed: Container()),
      ),
    );
  }
}
