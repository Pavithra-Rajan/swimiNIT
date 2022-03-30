import 'package:flutter/material.dart';
import 'Person.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({Key? key}) : super(key: key);

  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  Person P = Person('Varun Anilkumar', 'lib/Resources/pic-1.png', "B190621CS", "16:36", "4", "0", "R-043657839", "200", "24-01-2022");
  Widget userHistoryCard(Person p) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
        color: Color(0xFF93C6D3),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userHistoryCard(P)
    );
  }
}
