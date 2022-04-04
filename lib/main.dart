import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swiminit/Admin/pool_managers.dart';
import 'package:swiminit/Admin/adminnavbar.dart';
import 'package:swiminit/SPM/entry.dart';
import 'package:swiminit/SPM/pool_status.dart';
import 'package:swiminit/SPM/spmnavbar.dart';
import 'firebase_options.dart';

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
            return SPMNavBar();
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
    return Container(
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
                  ))),
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
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context);
                        print(user);
                        if (user != null) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => AdminNavBar()));
                        }
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AdminNavBar()));
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
                      )))
            ],
          )
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
