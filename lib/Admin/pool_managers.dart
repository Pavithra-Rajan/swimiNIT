import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../SPM/spm.dart';
import '../main.dart';

class ViewPoolManagers extends StatefulWidget
{
  const ViewPoolManagers({Key? key}) : super(key: key);

  @override
  State<ViewPoolManagers> createState() => _ViewPoolManagers();
}

class _ViewPoolManagers extends State<ViewPoolManagers>
{
  List<SPM> managers = [SPM("1234567890", "0987654321", "John Doe", "123456"),
    SPM("1234567890", "0987654321", "John Wick", "123456"),
    SPM("1234567890", "0987654321", "John Cena", "123456")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            for(int i = 0; i < managers.length; i++)
              buildCard(i),
          ],
        )
    );
  }

  Widget buildCard(int i) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Card(
        color: Color(0xFF93C6D3),
        shadowColor: Color(0xFF93C6D3),
        child: ExpandablePanel(
            header: Text(
                managers[i].name,

            ),

            expanded:RawMaterialButton(
              onPressed: () { setState(() { managers.removeAt(i); });},
              child: Text("Delete"),
              fillColor: Colors.red,
            ),
            collapsed: Text(managers[i].contact1)
        ),
      ),
    );
  }

}