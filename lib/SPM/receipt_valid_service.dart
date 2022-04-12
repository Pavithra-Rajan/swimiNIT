import 'package:http/http.dart' as http;
import 'package:swiminit/SPM/receipt_valid_class.dart';

import 'dart:convert';

class ReceiptIDvalidServices {

  static Future<ReceipIDreportValid > receiptIDservices(String val) async {
    String url='https://swiminit.herokuapp.com/getreceiptdetails?membershipID=${val}';
    final response=await http.get(Uri.parse(url));
    if(200 == response.statusCode) {
      return ReceipIDreportValid .fromJson(jsonDecode(response.body));
    }

    throw'';
  }
}