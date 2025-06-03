
import 'dart:convert';

import 'package:http/http.dart' as http;

class DataFetcher {
  String url = '';

  void setUrl(String setUrl) {
    this.url = setUrl;
  }

  Future<dynamic> fetchGetData(Map<String, String> header) async {
    if (url.isEmpty) {
      throw 'url not set exception';
    }

    var response = await http.get(Uri.parse(this.url), headers: header);

    var data = jsonDecode(response.body);
    print(url);
    print(data);

    return data;
  }

  Future<dynamic> fetchPostData(Map<String, String> header, Object body) async {
    if (url.isEmpty) {
      throw 'url not set exception';
    }
    var response = await http.post(
      Uri.parse(this.url),
      headers: header,
      body: body,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  // Future<void> sendFiles(Map<String, dyncamic>)
}
