import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/get_date_visits_spm.dart';
import 'dart:convert';

class SwimmersVisitsDate {

  static Future<dynamic> getSwimmersVisitsDate(String fromdate, String enddate) async {
    String url='https://swiminit.herokuapp.com/getDateVisits?startDate=${fromdate}&endDate=${enddate}';
    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return GetDateVisitsSpm.fromJson(jsonDecode(response.body));
      // final List<LiveSwimmers> swimmers=liveSwimmersFromJson(response.body);
      // return swimmers;
    }

    throw'';
  }
}