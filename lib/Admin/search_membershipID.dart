import 'package:flutter/material.dart';

class MembershipIdSearch_1  extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => MembershipIdSearchState_1();
}

class  MembershipIdSearchState_1 extends State<MembershipIdSearch_1> {
  bool isVisible=false;
  Widget _buildMembershipId() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Membership ID',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF14839F), width: 1.5),
        ),

      ),


    );
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildMembershipId(),
          ]
      ),



    );

  }
}