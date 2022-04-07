import 'package:http/http.dart' as http;
import 'package:swiminit/Admin/Swimmer_details_admin_class.dart';

import 'dart:convert';

class SwimmerDetailsServices {

  static Future<SwimmerDetailsAdmin> getSwimmersDetails(String val,bool admin) async {
    String url='https://swiminit.herokuapp.com/getdetails?membershipID=${val}&admin=True';
    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return SwimmerDetailsAdmin.fromJson(jsonDecode(response.body));
    }

    throw'';
  }
}