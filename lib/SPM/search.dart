import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {

  SearchPage({Key? key}) : super(key: key);

  final TextEditingController _membIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 350,
            child: TextField(
              autocorrect: false,
              cursorColor: Color(0xFF14839F),
              controller: _membIDController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Membership ID",
                prefixIcon: Icon(Icons.person, color: Color(0xFF14839F)),
              ),
            )
        )
    );
  }
}
