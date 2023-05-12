import 'dart:convert';
import 'package:flutter_counter/constants.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

const String baseAssetURL = Constants.webapiUrl + Constants.webapiPort;

class Server {
  static refresh() async {}

  static getProblems() async {
    final url = 'http://$baseAssetURL/WebApi/Problem';
    final response = await http.get(Uri.parse(url));
    final jsonString = response.body;
    final data = json.decode(jsonString);
    final problemsList = Problem.fromJson(data['problems'] as List<dynamic>);
    return problemsList;
  }
}
