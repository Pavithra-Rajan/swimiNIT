import 'package:swiminit/Admin/checkClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckService {

  static Future<CheckClass> check(String val) async {
    String url='https://swiminit.herokuapp.com/getdetails?membershipID=${val}&admin=True';
    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return CheckClass.fromJson(jsonDecode(response.body));
      // final List<LiveSwimmers> swimmers=liveSwimmersFromJson(response.body);
      // return swimmers;
    }

    throw'';
  }
}