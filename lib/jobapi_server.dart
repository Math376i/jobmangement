import 'dart:convert';
import 'package:flutter_counter/constants.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

const String baseAssetURL = Constants.webapiUrl + Constants.webapiPort;

final headers = {'User-Agent': 'Flutter app'};

class Server {
  static refresh() async {}

  static getProblems() async {
    print(baseAssetURL);
    final url = 'http://$baseAssetURL/api/Problem';

    final response = await http.get(Uri.parse(url));
    if (response != null) {
      print("Got data from $url");
    }
    final jsonString = response.body;
    final data = json.decode(jsonString);
    final problemsList = Problem.fromJson(data['problems'] as List<dynamic>);
    return problemsList;
  }

  static createNewProblem(Problem problem) async {
    final url = 'http://$baseAssetURL/api/Problem';

    try {
      var data = jsonEncode(problem.toJson());
      var resp = await http.put(Uri.parse(url), body: data);
      print(resp);
    } catch (e) {
      print('Error: $e');
    }
  }
}
