import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/SwimmerDetailsSpmClass.dart';
import 'package:swiminit/SPM/get_date_visits_spm.dart';
import 'dart:convert';

class SwimmerDetailsServices {

  static Future<SwimmerDetailsSpm> getSwimmersDetails(String val,bool admin) async {
    String url='https://swiminit.herokuapp.com/getdetails?membershipID=${val}&admin=${admin}';
    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return SwimmerDetailsSpm.fromJson(jsonDecode(response.body));
    }

    throw'';
  }
}