import 'dart:convert';
import 'package:flutter_counter/constants.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

const String baseAssetURL = Constants.webapiUrl + Constants.webapiPort;

final headers = {
  'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
};

class Server {
  static refresh() async {}

  static getProblems() async {
    print(baseAssetURL);
    final url = 'http://$baseAssetURL/WebApi/Problem';

    try {
      var resp = await http.get(Uri.parse(url), headers: headers);
      print("Response status: ${resp.statusCode}");
      print('Response body: ${resp.body}');
    } catch (e) {
      print('Error: $e');
    }

    final response = await http.get(Uri.parse(url));
    if (response != null) {
      print("Got data from $url");
    }
    final jsonString = response.body;
    final data = json.decode(jsonString);
    final problemsList = Problem.fromJson(data['problems'] as List<dynamic>);
    return problemsList;
  }
}
