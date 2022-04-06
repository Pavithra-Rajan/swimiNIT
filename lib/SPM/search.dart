import 'package:flutter/material.dart';
import 'edit_receipt_details.dart';

class SearchPage extends StatefulWidget {

  SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchPageState();
}


class SearchPageState extends State<SearchPage>
{
  final TextEditingController _membIDController = TextEditingController();
  currState state = currState.searching;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.08,
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
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () => {

              },
            ),
          )
      ),
    );
  }
}
