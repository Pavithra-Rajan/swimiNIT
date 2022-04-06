import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/pool_status_class.dart';
import 'dart:convert';

class PoolStatusServices {
  static const String url='https://swiminit.herokuapp.com/getLiveSwimmers';
  static Future<dynamic> getSwimmers() async {

      final response=await http.get(Uri.parse(url));
      if(200 == response.statusCode) {
        return LiveSwimmers.fromJson(jsonDecode(response.body));
        // final List<LiveSwimmers> swimmers=liveSwimmersFromJson(response.body);
        // return swimmers;
      }

    throw'';
  }
}