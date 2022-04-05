import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/exit_class.dart';
// import 'package:swiminit/Admin/pool_status_class.dart';

import 'dart:convert';
class PoolExitServices {
  static Future <ExitSwimmers> exitSwimmers(String membershipID,String endtime) async {
      final response=await http.post(
        Uri.parse('https://swiminit.herokuapp.com/exit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'membershipID': membershipID,
          'endTime' : endtime
        }),
      );

      if(200==response.statusCode)
        {

          return ExitSwimmers.fromJson(jsonDecode(response.body));
        }

       throw '';
    }
  }
