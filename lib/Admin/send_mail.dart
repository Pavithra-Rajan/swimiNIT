import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendMailPage extends StatelessWidget {
  const SendMailPage({Key? key}) : super(key: key);

  void _contact() async {
    const url = 'mailto:pavithra.rajan01@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

      const SizedBox(height: 30),
      ElevatedButton(
        onPressed: (){_contact();},
        child: Text('Send Mail'),
        style: ElevatedButton.styleFrom(
            primary: Color(0xFF14839F),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            textStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),

      ),
      ],
    ),
    );
  }
}


