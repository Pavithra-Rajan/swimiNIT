import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/adminnavbar.dart';
import 'package:swiminit/Admin/quarterlyReportResults.dart';
import 'package:swiminit/SPM/spmnavbar.dart';
import 'package:swiminit/SPM/pool_status.dart';
import 'firebase_options.dart';
import 'package:swiminit/Admin/search_by_daterange_results.dart';
import 'package:swiminit/Admin/adminaddspm.dart';
import 'package:swiminit/Admin/edit_swimmer_details.dart';
import 'package:swiminit/SPM/edit_receipt_details.dart';

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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (email == "@swiminit.com" || password.isEmpty) {
      emptyInputs();
      return null;
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      if (user != null) {
        print("User logged in: ");
      } else {
        print("User not logged in: ");
        wrongInputs();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Incorrect Credentials");
        wrongInputs();
      }
    }
    return user;
  }

  Future wrongInputs() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: AlertDialog(
            content: Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Invalid credentials',
                    style: GoogleFonts.poppins(
                        color: Color(0xFF14839F), fontSize: 16),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF14839F), // background
                    onPrimary: Colors.white, // foreground
                    minimumSize: Size(100, 45),
                  ),
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future emptyInputs() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: AlertDialog(
            content: Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Enter all the fields',
                    style: GoogleFonts.poppins(
                        color: Color(0xFF14839F), fontSize: 16),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF14839F), // background
                    onPrimary: Colors.white, // foreground
                    minimumSize: Size(100, 45),
                  ),
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(0.0),
        child: ListView(
          children: [
            Opacity(
                opacity: 1,
                child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Color(0xFF14839F),
                      height: 180,
                    )
                )
            ),
            Text("Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF14839F),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 44.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Username",
                prefixIcon: Icon(Icons.person, color: Color(0xFF14839F)),
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
                prefixIcon: Icon(Icons.lock, color: Color(0xFF14839F)),
              ),
            ),
            const SizedBox(
              height: 40.0,
              width: 10.0,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: 100,
                    height: 50,
                    color: Colors.white,
                    child: RawMaterialButton(
                        fillColor: Color(0xFF14839F),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: () async {
                          User? user = await loginUsingEmailPassword(
                              email: _emailController.text + '@swiminit.com',
                              password: _passwordController.text,
                              context: context);
                          if (user != null) {
                            String emailID = user.email.toString();
                            String result =
                                emailID.substring(0, emailID.indexOf('@'));
                            if (result == 'admin') {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => AdminNavBar()
                                  )
                              );
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SPMNavBar()
                                  )
                              );
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        )
                    )
                )
              ],
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
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
    //throw UnimplementedError();
    return false;
  }
}