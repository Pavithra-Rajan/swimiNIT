import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Container(
          child:Stack(
            children: [
              Opacity(opacity:1,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.cyan[700],
                  height:180,
                )
              )),
              Container(
                padding: const EdgeInsets.only(left: 35, top: 210),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.cyan[700], fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 35, top: 280, right:20),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username'
                  ),
              ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 35, top: 360, right:20),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password'
                  ),

                ),
              ),

            ]
          )
        )

      ),

    );
  }
}

class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip (Size size){
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width/5, size.height); //controlling point
    var firstEnd = Offset(size.width/2.25, size.height-50.0);  //little over half of width
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy); //takes 3 points
    var secondStart = Offset(size.width-(size.width/3.24), size.height -105);
    var secondEnd = Offset(size.width,size.height -10);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
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