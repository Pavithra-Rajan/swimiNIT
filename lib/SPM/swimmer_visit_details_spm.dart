import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/UserVisitsSpmClass.dart';
import 'dart:convert';

class SwimmerVisitServices {

  static Future<dynamic> getSwimmersVisitDetails(String val) async {
    String url='https://swiminit.herokuapp.com/getUserVisits?membershipID=${val}';
    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return UserVisitsSpm.fromJson(jsonDecode(response.body));
      // final List<LiveSwimmers> swimmers=liveSwimmersFromJson(response.body);
      // return swimmers;
    }

    throw'';
  }
}