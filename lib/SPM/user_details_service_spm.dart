import 'package:swiminit/SPM/SwimmerDetailsSpmClass.dart';
import 'package:swiminit/SPM/UserVisitsSpmClass.dart';
import 'package:swiminit/SPM/ReceiptDetailsSpmClass.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserDetailsService {

  // static const String url='https://swiminit.herokuapp.com/getLiveSwimmers';
   static Future getSwimmerDetails() async {

    final r1=http.get(Uri.parse('https://swiminit.herokuapp.com/getdetails?membershipID=B190657CS&admin=False'));
    final r2=http.get(Uri.parse('https://swiminit.herokuapp.com/getreceiptdetails?membershipID=B190657CS'));
    final r3=http.get(Uri.parse('https://swiminit.herokuapp.com/getUserVisits?membershipID=B190657CS'));
    var results = await Future.wait([
    r1,r2,r3
    ]);
    var value = <dynamic>[];
     // list of Responses


      SwimmerDetailsSpm.fromJson(jsonDecode(results[0].body));
      ReceiptDetailsSpm.fromJson(jsonDecode(results[1].body));
      UserVisitsSpm.fromJson(jsonDecode(results[2].body));

    return value;
  }
    // if(200 == response.statusCode) {
    //   return LiveSwimmers.fromJson(jsonDecode(response.body));
    //   // final List<LiveSwimmers> swimmers=liveSwimmersFromJson(response.body);
    //   // return swimmers;
    // }



}
