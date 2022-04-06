import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/ReceiptDetailsSpmClass.dart';
import 'dart:convert';

class ReceiptDetailsServices {
  static const String url='https://swiminit.herokuapp.com/getreceiptdetails?membershipID=B190657CS';
  static Future<dynamic> getSwimmersReceiptDetails() async {

    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return ReceiptDetailsSpm.fromJson(jsonDecode(response.body));
      // final List<LiveSwimmers> swimmers=liveSwimmersFromJson(response.body);
      // return swimmers;
    }

    throw'';
  }
}