import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/ReceiptDetailsSpmClass.dart';
import 'dart:convert';

class ReceiptDetailsServices {

  static Future<dynamic> getSwimmersReceiptDetails(String val) async {
  String url='https://swiminit.herokuapp.com/getreceiptdetails?membershipID=$val';

    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return ReceiptDetailsSpm.fromJson(jsonDecode(response.body));
      // final List<LiveSwimmers> swimmers=liveSwimmersFromJson(response.body);
      // return swimmers;
    }

    throw'';
  }
}