import 'dart:convert';
import 'package:http/http.dart';

import 'SPM/spm.dart';

class HttpService {
  final String spmURL = "lib/Resources/spms.json";

  Future<List> getPosts() async {
    Response res = await get(Uri.parse(spmURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List posts = body
          .map(
            (dynamic item) => SPM.fromJson(item),
      )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}