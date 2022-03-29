import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swiminit/Admin/send_mail.dart';
import 'package:swiminit/Admin/adminaddspm.dart';
import 'package:swiminit/Admin/pool_managers.dart';
import 'package:swiminit/Admin/quaterly_reports.dart';
import 'package:swiminit/SPM/spmnavbar.dart';
import 'package:swiminit/SPM/pool_status.dart';
import 'package:swiminit/Admin/adminnavbar.dart';

import 'dart:math' as math;
import 'package:swiminit/profile_screen.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginScreen(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Incorrect Credentials");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
              opacity: 1,
              child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    color: Colors.blue[900],
                    height: 180,
                  ))),
          //const SizedBox(height: 34.0,
          //),
          Text("Login",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 44.0),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Username",
              prefixIcon: Icon(Icons.person, color: Colors.indigo),
            ),
          ),
          const SizedBox(
            height: 26.0,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Password",
              prefixIcon: Icon(Icons.lock, color: Colors.indigo),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          SizedBox(
              width: 100.0,
              child: RawMaterialButton(
                  fillColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  onPressed: () async {
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);
                    print(user);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AdminNavBar()));
                    }
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AdminNavBar())); //Put this back in that if later
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  )))
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height); //controlling point
    var firstEnd = Offset(
        size.width / 2.25, size.height - 50.0); //little over half of width
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx,
        firstEnd.dy); //takes 3 points
    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
