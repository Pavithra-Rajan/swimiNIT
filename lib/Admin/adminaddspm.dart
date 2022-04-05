import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/adminnavbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminAddSPM extends StatefulWidget
{
  const AdminAddSPM({Key? key}) : super(key: key);

  @override
  State<AdminAddSPM> createState() => _AdminAddSPMState();
}


class _AdminAddSPMState extends State<AdminAddSPM>
{

  Future putSPM() async{
    print('function is getting executed');
    await http.post(
        Uri.parse('https://swiminit.herokuapp.com/addSPM'),
        body: jsonEncode(<String, Map<String,String>>{
          "details":{
            "contact1":"123",
            "contact2":"145",
            "name":"josephmani"
          }
        })
    );
  }
  bool added = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _contact1 = TextEditingController();
    TextEditingController _contact2 = TextEditingController();
    TextEditingController _password = TextEditingController();
    Widget adding()

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
                  prefixIcon: Icon(Icons.person,color:Color(0xFF14839F)),
                  iconColor: Color(0xFF14839F),
                ),
              ),
              const SizedBox(height: 26.0,),
              TextField(
                controller: _contact1,
                obscureText: false,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Contact 1",
                  prefixIcon: Icon(Icons.local_phone,color:Color(0xFF14839F)),
                ),
              ),
              const SizedBox(height: 26.0,
              ),
              TextField(
                controller: _contact2,
                obscureText: false,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Contact 2",
                  prefixIcon: Icon(Icons.phone_android,color:Color(0xFF14839F)),
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
                  prefixIcon: Icon(Icons.lock,color:Color(0xFF14839F)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 45, 0, 5),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment(0, 0),
                          child: FractionallySizedBox(
                              widthFactor: 0.25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF93C6D3), // background
                                  onPrimary: Colors.white, // foreground
                                  minimumSize: Size(175,45),
                                ),
                                child: Text('Submit',style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                onPressed: () {
                                  putSPM();
                                },
                              )
                          )
                      )
                    ],

                  )

              )

            ]);
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
        backgroundColor: Color(0xFF14839F),
      ),

      body: adding(),

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
                onPressed: () => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => AdminNavBar())),

                },
              ),
            )),

    );
  }
}