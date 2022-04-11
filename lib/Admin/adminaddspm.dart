import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/adminnavbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class AdminAddSPM extends StatefulWidget
{
  const AdminAddSPM({Key? key}) : super(key: key);

  @override
  State<AdminAddSPM> createState() => _AdminAddSPMState();

  static final GlobalKey<FormState> _addScreenFormKey = GlobalKey<FormState>();
}


class _AdminAddSPMState extends State<AdminAddSPM>
{
  Future putSPM(String contact1, String contact2, String name, String pass) async{
    //print('function is getting executed');
    print (contact1);
    final _auth = FirebaseAuth.instance;
    String email;
    String password;
    email=contact1+'@swiminit.com';
    password=pass;
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //print(newUser);
    } catch (e) {
      print(e);
    }

    await http.post(
        Uri.parse('https://swiminit.herokuapp.com/addSPM'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String, Map<String,String>>{
          "details":{
            "contact1":contact1,
            "contact2":contact2,
            "name":name
          }
        })
    );
  }

  Future<void> popupSPMadded() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return
          Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10,3 ),
              child: AlertDialog(
                content: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 8, 30, 50),
                      child: Text('SPM added successfully',style: GoogleFonts.poppins(color: Color(0xFF149F88), fontSize: 16),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(90, 50, 90, 5),

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF149F88), // background
                          onPrimary: Colors.white, // foreground
                          minimumSize: Size(100,45),
                        ),
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => AdminNavBar()));
                        },
                      ),
                    )
                  ],
                ),
              ),
          );
      },
    );
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _contact1 = TextEditingController();
  final TextEditingController _contact2 = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool added = false;
  @override
  Widget build(BuildContext context)
  {
    Widget adding()
    {
      if(!added)
      {
        return ListView(
          children: [
            Column(
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
                                  putSPM(_contact1.text,_contact2.text,_name.text,_password.text);
                                  popupSPMadded();
                                },
                              )
                            )
                          )
                        ],
                      )
                  )
              ]
            )
          ]
        );
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
                          builder: (context) => AdminNavBar()
                      )
                  ),
                },
              ),
            )
      ),
    );
  }
}