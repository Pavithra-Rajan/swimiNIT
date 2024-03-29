import 'package:flutter/material.dart';
import 'package:swiminit/Admin/search_membership_id.dart';
import 'package:swiminit/Admin/search_date_range.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<Search> {
  bool showMembership = true;
  void toggleswitch(){
     setState(()=>
       showMembership=!showMembership
     );
  }
  @override
  Widget build(BuildContext context) {
       if(showMembership)
         {
           return MembershipIdSearch1(toggleswitch: toggleswitch,showMembership: showMembership);
         }
       else{
         return Daterange2(toggleswitch: toggleswitch,showMembership: showMembership);
       }
  }
}
//
// // class SearchPage extends StatelessWidget {
// //
// //   final TextEditingController _membIDController = TextEditingController();
// //
// //   SearchPage({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: SizedBox(
// //           width: 350,
// //           child: TextField(
// //             autocorrect: false,
// //             cursorColor: Color(0xFF14839F),
// //             controller: _membIDController,
// //             keyboardType: TextInputType.emailAddress,
// //             decoration: const InputDecoration(
// //                 hintText: "Membership ID",
// //                 prefixIcon: Icon(Icons.person, color: Color(0xFF14839F)),
// //               ),
// //           )
// //       )
// //     );
// //   }
// // }
