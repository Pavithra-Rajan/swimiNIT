import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/receiptIDerror.dart';

import 'dart:convert';

class ReceiptIDerrorServices {

  static Future<ReceipIDreport> receiptIDservices(String val) async {
    String url='https://swiminit.herokuapp.com/getreceiptdetails?membershipID=${val}';
    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return ReceipIDreport.fromJson(jsonDecode(response.body));
    }

    throw'';
  }
}