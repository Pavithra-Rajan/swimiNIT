import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class AdminAddSPM extends StatefulWidget
{
  const AdminAddSPM({Key? key}) : super(key: key);

  @override
  State<AdminAddSPM> createState() => _AdminAddSPMState();
}

class _AdminAddSPMState extends State<AdminAddSPM>
{
  bool added = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _contact1 = TextEditingController();
    TextEditingController _contact2 = TextEditingController();
    TextEditingController _password = TextEditingController();


    Widget Adding()
    {
      if(!added)
      {
        return Column(
            children: [
              const SizedBox(height: 40.0),
              TextField(
                controller: _name,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(Icons.person,color:Colors.indigo),
                  iconColor: Colors.indigo,
                ),
              ),
              const SizedBox(height: 26.0,),
              TextField(
                controller: _contact1,
                obscureText: true,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Contact 1",
                  prefixIcon: Icon(Icons.local_phone,color:Colors.indigo),
                ),
              ),
              const SizedBox(height: 26.0,
              ),
              TextField(
                controller: _contact2,
                obscureText: true,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Contact 2",
                  prefixIcon: Icon(Icons.phone_android,color:Colors.indigo),
                ),
              ),
              const SizedBox(height: 26.0,
              ),
              TextField(
                controller: _password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock,color:Colors.indigo),
                ),
              ),]);
      }
      else
      {
        return Padding(
            padding: EdgeInsets.all(0),
            child: Text("Successfully added",
              style: GoogleFonts.rubik(),
            ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Pool Manager'),
        backgroundColor: Colors.blue[900],
      ),
      body: Adding(),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.arrow_left), label: "Back")
          ],
        onTap: (int a){
            if(a == 0)
              {
                setState(() {added = true;});
              }
        },
      ),
    );
  }
}